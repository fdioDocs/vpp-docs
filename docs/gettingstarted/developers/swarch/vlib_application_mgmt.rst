.. _vlib_application_mgmt:

.. toctree::

####################################
VLIB Application Management Layer
####################################

The files associated with the Vlibs are located in the …/src/{Vlib, Vlibapi, Vlibmemory} folders. These Vlib libraries provide vector processing support including graph-node scheduling, reliable multicast support, ultra-lightweight cooperative multi-tasking threads, a CLI, plug in .DLL support, physical memory and Linux epoll support. Parts of this library embody US Patent 7,961,636.

The different Vlibs provide support for the following functions:

G2 graphical event viewer
++++++++++++++++++++++++++

The G2 graphical event viewer can display serialized vppinfra event
logs directly, or via the c2cpel tool.

.. note::
   Todo: please convert wiki page and figures


Init function discovery
++++++++++++++++++++++++

vlib applications register for various [initialization] events by
placing structures and __attribute__((constructor)) functions into the
image. At appropriate times, the vlib framework walks
constructor-generated singly-linked structure lists, calling the
indicated functions. vlib applications create graph nodes, add CLI
functions, start cooperative multi-tasking threads, etc. etc. using
this mechanism.

vlib applications invariably include a number of VLIB_INIT_FUNCTION
(my_init_function) macros.

Each init / configure / etc. function has the return type clib_error_t
\*. Make sure that the function returns 0 if all is well, otherwise
the framework will announce an error and exit.

vlib applications must link against vppinfra, and often link against
other libraries such as VNET. In the latter case, it may be necessary
to explicitly reference symbol(s) otherwise large portions of the
library may be AWOL at runtime.

Node Graph Initialization
++++++++++++++++++++++++++

vlib packet-processing applications invariably define a set of graph
nodes to process packets. 

One constructs a vlib_node_registration_t, most often via the
VLIB_REGISTER_NODE macro. At runtime, the framework processes the set
of such registrations into a directed graph. It is easy enough to add
nodes to the graph at runtime. The framework does not support removing
nodes.

vlib provides several types of vector-processing graph nodes,
primarily to control framework dispatch behaviors. The type member of
the vlib_node_registration_t functions as follows:

* VLIB_NODE_TYPE_PRE_INPUT - run before all other node types
* VLIB_NODE_TYPE_INPUT - run as often as possible, after pre_input nodes
* VLIB_NODE_TYPE_INTERNAL - only when explicitly made runnable by adding pending frames for processing
* VLIB_NODE_TYPE_PROCESS - only when explicitly made runnable. "Process" nodes are actually cooperative multi-tasking threads. They **must** explicitly suspend after a reasonably short period of time.
  
For a precise understanding of the graph node dispatcher, please read
.../src/vlib/main.c:vlib_main_loop.
 
Graph node dispatcher
++++++++++++++++++++++

Vlib_main_loop() dispatches graph nodes. The basic vector processing
algorithm is diabolically simple, but may not be obvious from even a
long stare at the code. Here's how it works: some input node, or
set of input nodes, produce a vector of work to process. The graph
node dispatcher pushes the work vector through the directed graph,
subdividing it as needed, until the original work vector has been
completely processed. At that point, the process recurs.

This scheme yields a stable equilibrium in frame size, by
construction. Here's why: as the frame size increases, the
per-frame-element processing time decreases. There are several related
forces at work; the simplest to describe is the effect of vector
processing on the CPU L1 I-cache. The first frame element [packet]
processed by a given node warms up the node dispatch function in the
L1 I-cache. All subsequent frame elements profit. As we increase the
number of frame elements, the cost per element goes down.

Under light load, it is a crazy waste of CPU cycles to run the graph
node dispatcher flat-out. So, the graph node dispatcher arranges to
wait for work by sitting in a timed epoll wait if the prevailing frame
size is low. The scheme has a certain amount of hysteresis to avoid
constantly toggling back and forth between interrupt and polling
mode. Although the graph dispatcher supports interrupt and polling
modes, our current default device drivers do not.

The graph node scheduler uses a hierarchical timer wheel to reschedule
process nodes upon timer expiration.  

Process / thread model
++++++++++++++++++++++

vlib provides an ultra-lightweight cooperative multi-tasking thread
model. The graph node scheduler invokes these processes in much the
same way as traditional vector-processing run-to-completion graph
nodes; plus-or-minus a setjmp/longjmp pair required to switch
stacks. Simply set the vlib_node_registration_t type field to
vlib_NODE_TYPE_PROCESS. Yes, process is a misnomer. These are
cooperative multi-tasking threads. 

As of this writing, the default stack size is 2<<15; 32kb. Initialize
the node registration's process_log2_n_stack_bytes member as
needed. The graph node dispatcher makes some effort to detect stack
overrun, e.g. by mapping a no-access page below each thread stack.

Process node dispatch functions are expected to be "while(1) { }" loops
which suspend when not otherwise occupied, and which must not run for
unreasonably long periods of time. 

"Unreasonably long" is an application-dependent concept. Over the
years, we have constructed frame-size sensitive control-plane nodes
which will use a much higher fraction of the available CPU bandwidth
when the frame size is low. The classic example: modifying forwarding
tables. So long as the table-builder leaves the forwarding tables in a
valid state, one can suspend the table builder to avoid dropping
packets as a result of control-plane activity.

Process nodes can suspend for fixed amounts of time, or until another
entity signals an event, or both. See the next section for a
description of the vlib process event mechanism.

When running in vlib process context, one must pay strict attention to
loop invariant issues. If one walks a data structure and calls a
function which may suspend, one had best know by construction that it
cannot change. Often, it's best to simply make a snapshot copy of a
data structure, walk the copy at leisure, then free the copy.

Process events
++++++++++++++
The vlib process event mechanism API is extremely lightweight and easy
to use. Here is a typical example::

  vlib_main_t *vm = &vlib_global_main;
  uword event_type, * event_data = 0;

  while (1) 
  {
     vlib_process_wait_for_event_or_clock (vm, 5.0 /* seconds */);

     event_type = vlib_process_get_events (vm, &event_data);

     switch (event_type) {
     case EVENT1:
         handle_event1s (event_data);
         break;

     case EVENT2:
         handle_event2s (event_data);
         break; 

     case ~0: /* 5-second idle/periodic */
         handle_idle ();
         break;

     default: /* bug! */
         ASSERT (0);
     }

     vec_reset_length(event_data);
  } 

In this example, the VLIB process node waits for an event to occur, or
for 5 seconds to elapse. The code demuxes on the event type, calling
the appropriate handler function. Each call to vlib_process_get_events
returns a vector of per-event-type data passed to successive
vlib_process_signal_event calls; vec_len (event_data) >= 1.  

It is an error to process only event_data[0].

Resetting the event_data vector-length to 0 [instead of calling
vec_free] means that the event scheme doesn't burn cycles continuously
allocating and freeing the event data vector. This is a common
vppinfra / vlib coding pattern, well worth using when appropriate.

Signaling an event is easy, for example::

  vlib_process_signal_event (vm, process_node_index, EVENT1,
      (uword)arbitrary_event1_data); /* and so forth */

One can either know the process node index by construction - dig it
out of the appropriate vlib_node_registration_t - or by finding the
vlib_node_t with vlib_get_node_by_name(...).

Buffers
+++++++

vlib buffering solves the usual set of packet-processing problems,
albeit at high performance. Key in terms of performance: one
ordinarily allocates / frees N buffers at a time rather than one at a
time. Except when operating directly on a specific buffer, one deals
with buffers by index, not by pointer. 

Packet-processing frames are effectively u32[], not
vlib_buffer_t[]. 

Packets comprise one or more vlib buffers, chained together as
required. Multiple particle sizes are supported; hardware input nodes
simply ask for the required size(s). Coalescing support is
available. For obvious reasons one is discouraged from writing one's
own wild and wacky buffer chain traversal code.

vlib buffer headers are allocated immediately prior to the buffer data
area. In typical packet processing this saves a dependent read wait:
given a buffer's address, one can prefetch the buffer header
[metadata] at the same time as the first cache line of buffer data.

Buffer header metadata (vlib_buffer_t) includes the usual rewrite
expansion space, a current_data offset, RX and TX interface indices,
packet trace information, and a opaque areas.

The opaque data is intended to control packet processing in arbitrary
subgraph-dependent ways. The programmer shoulders responsibility for
data lifetime analysis, type-checking, etc.

Buffers have reference-counts in support of e.g. multicast
replication.

Shared-memory message API
++++++++++++++++++++++++++

Local control-plane and application processes interact with the vpp
dataplane via asynchronous message-passing in shared memory over
unidirectional queues. The same application APIs are available via
sockets. 

Capturing API traces and replaying them in a
simulation environment requires a disciplined approach
to the problem. This seems like a make-work task, but it is not. When
something goes wrong in the control-plane after 300,000 or 3,000,000
operations, high-speed replay of the events leading up to the accident
is a huge win. 

The shared-memory message API message allocator vl_api_msg_alloc uses
a particularly cute trick. Since messages are processed in order, we
try to allocate message buffering from a set of fixed-size,
preallocated rings. Each ring item has a "busy" bit. Freeing one of
the preallocated message buffers merely requires the message consumer
to clear the busy bit. No locking required.


