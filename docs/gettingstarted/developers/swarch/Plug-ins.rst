.. _Plug-ins:

.. toctree::

###############
Plug-ins Layer
###############

The files associated with the application shell layer are located in the …/src/plugins folder. 
vlib implements a straightforward plug-in DLL
mechanism. VLIB client applications specify a directory to search for
plug-in .DLLs, and a name filter to apply (if desired). VLIB needs to
load plug-ins very early.

Once loaded, the plug-in DLL mechanism uses dlsym to find and verify
a vlib_plugin_registration data structure in the newly-loaded
plug-in. 

Debug CLI
=========

Adding debug CLI commands to VLIB applications is very simple.

Here is a complete example::

  static clib_error_t *
  show_ip_tuple_match (vlib_main_t * vm,
                       unformat_input_t * input,
                       vlib_cli_command_t * cmd)
  {
      vlib_cli_output (vm, "%U\n", format_ip_tuple_match_tables, &routing_main);
      return 0;
  }

  static VLIB_CLI_COMMAND (show_ip_tuple_command) = {
      .path = "show ip tuple match",
      .short_help = "Show ip 5-tuple match-and-broadcast tables",
      .function = show_ip_tuple_match,
  };

This example implements the "show ip tuple match" debug cli
command. In ordinary usage, the vlib cli is available via the "vppctl"
applicationn, which sends traffic to a named pipe. One can configure
debug CLI telnet access on a configurable port.

The cli implementation has an output redirection facility which makes
it simple to deliver cli output via shared-memory API messaging,

Particularly for debug or "show tech support" type commands, it would
be wasteful to write vlib application code to pack binary data, write
more code elsewhere to unpack the data and finally print the
answer. If a certain cli command has the potential to hurt packet
processing performance by running for too long, do the work
incrementally in a process node. The client can wait.

Packet Tracer
=============

Vlib includes a frame element [packet] trace facility, with a simple
vlib cli interface. The cli is straightforward: "trace add
<input-node-name> <count>".  

To trace 100 packets on a typical x86_64 system running the dpdk
plugin: "trace add dpdk-input 100". When using the packet generator:
"trace add pg-input 100"

Each graph node has the opportunity to capture its own trace data. It
is almost always a good idea to do so. The trace capture APIs are
simple. 

The packet capture APIs snapshoot binary data, to minimize processing
at capture time. Each participating graph node initialization provides
a vppinfra format-style user function to pretty-print data when required
by the VLIB "show trace" command.

Set the VLIB node registration ".format_trace" member to the name of the per-graph node format function. 

Here's a simple example::

  u8 * my_node_format_trace (u8 * s, va_list * args)
  {
      vlib_main_t * vm = va_arg (*args, vlib_main_t *);
      vlib_node_t * node = va_arg (*args, vlib_node_t *);
      my_node_trace_t * t = va_arg (*args, my_trace_t *);

      s = format (s, "My trace data was: %d", t-><whatever>);

      return s;
  } 

The trace framework hands the per-node format function the data it
captured as the packet whizzed by. The format function pretty-prints
the data as desired. 


