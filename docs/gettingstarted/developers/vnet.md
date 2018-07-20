
VNET (VPP Network Stack)
========================

The files associated with the VPP network stack layer are located in the
./src/vnet folder. The Network Stack Layer is basically an
instantiation of the code in the other layers. This layer has a vnet
library that provides vectorized layer-2 and 3 networking graph nodes, a
packet generator, and a packet tracer.

In terms of building a packet processing application, vnet provides a
platform-independent subgraph to which one connects a couple of
device-driver nodes.

Typical RX connections include "ethernet-input" \[full software
classification, feeds ipv4-input, ipv6-input, arp-input etc.\] and
"ipv4-input-no-checksum" \[if hardware can classify, perform ipv4 header
checksum\].

![image](/_images/VNET_Features.png)

List of features and layer areas that VNET works with:

Effective graph dispatch function coding
----------------------------------------

Over the 15 years, two distinct styles have emerged: a single/dual/quad
loop coding model and a fully-pipelined coding model. We seldom use the
fully-pipelined coding model, so we won't describe it in any detail

Single/dual loops
-----------------

The single/dual/quad loop model is the only way to conveniently solve
problems where the number of items to process is not known in advance:
typical hardware RX-ring processing. This coding style is also very
effective when a given node will not need to cover a complex set of
dependent reads.

Packet tracer
-------------

Vlib includes a frame element \[packet\] trace facility, with a simple
vlib cli interface. The cli is straightforward: "trace add
input-node-name count".

To trace 100 packets on a typical x86\_64 system running the dpdk
plugin: "trace add dpdk-input 100". When using the packet generator:
"trace add pg-input 100"

Each graph node has the opportunity to capture its own trace data. It is
almost always a good idea to do so. The trace capture APIs are simple.

The packet capture APIs snapshoot binary data, to minimize processing at
capture time. Each participating graph node initialization provides a
vppinfra format-style user function to pretty-print data when required
by the VLIB "show trace" command.

Set the VLIB node registration ".format\_trace" member to the name of
the per-graph node format function.

Here's a simple example:

```c
    u8 * my_node_format_trace (u8 * s, va_list * args)
    {
        vlib_main_t * vm = va_arg (*args, vlib_main_t *);
        vlib_node_t * node = va_arg (*args, vlib_node_t *);
        my_node_trace_t * t = va_arg (*args, my_trace_t *);

        s = format (s, "My trace data was: %d", t-><whatever>);

        return s;
    } 
```

The trace framework hands the per-node format function the data it
captured as the packet whizzed by. The format function pretty-prints the
data as desired.
