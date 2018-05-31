.. _whatisvpp01:

.. toctree::

Introduction
------------

The VPP platform is an extensible framework that provides out-of-the-box
production quality switch/router functionality. It is the open source
version of Cisco's Vector Packet Processing (VPP) technology: a high
performance, packet-processing stack that can run on commodity CPUs.

The benefits of this implementation of VPP are its high performance,
proven technology, its modularity and flexibility, and rich feature set.

The VPP technology is based on proven technology that has helped ship
over $1 Billion of Cisco products. It is a modular design. The framework
allows anyone to "plug in" new graph nodes without the need to change
core/kernel code.

.. figure:: /_images/VPP_Packet_Processing_Layer_In_Network_Stack_Overview.jpg
   :alt:

   Packet Processing Layer in High Level Overview of Networking Stack

Why is it called vector processing?
-----------------------------------

As the name implies, VPP uses vector processing as opposed to scalar
processing. Scalar packet processing refers to the processing of one
packet at a time. That older, traditional approach entails processing an
interrupt, and traversing the call stack (a calls b calls c... return
return return from the nested calls... then return from Interrupt). That
process then does one of 3 things: punt, drop, or rewrite/forward the
packet.

The problem with that traditional scalar packet processing is:

* thrashing occurs in the I-cache
* each packet incurs an identical set of I-cache misses
* no workaround to the above except to provide larger caches

By contrast, vector processing processes more than one packet at a time.

One of the benefits of the vector approach is that it fixes the I-cache
thrashing problem. It also mitigates the dependent read latency problem
(pre-fetching eliminates the latency).

This approach fixes the issues related to stack depth / D-cache misses
on stack addresses. It improves "circuit time". The "circuit" is the
cycle of grabbing all available packets from the device RX ring, forming
a "frame" (vector) that consists of packet indices in RX order, running
the packets through a directed graph of nodes, and returning to the RX
ring. As processing of packets continues, the circuit time reaches a
stable equilibrium based on the offered load.

As the vector size increases, processing cost per packet decreases
because you are amortizing the I-cache misses over a larger N.

Modular, Flexible, and Extensible
---------------------------------

The VPP platform is built on a ‘packet processing graph’. This modular
approach means that anyone can ‘plugin’ new graph nodes. This makes
extensibility rather simple, and it means that plugins can be customized
for specific purposes.

.. figure:: /_images/VPP_custom_application_packet_processing_graph.280.jpg
   :alt: Custom Packet Processing Graph

   Custom Packet Processing Graph

How does the plugin come into play? At runtime, the VPP platform grabs
all available packets from RX rings to form a vector of packets. A
packet processing graph is applied, node by node (including plugins) to
the entire packet vector. Graph nodes are small and modular. Graph nodes
are loosely coupled. This makes it easy to introduce new graph nodes. It
also makes it relatively easy to rewire existing graph nodes.

A plugin can introduce new graph nodes or rearrange the packet
processing graph. You can also build a plugin independently of the VPP
source tree - which means you can treat it as an independent component.
A plugin can be installed by adding it to a plugin directory.

The VPP platform can be used to build any kind of packet processing
application. It can be used as the basis for a Load Balancer, a
Firewall, an IDS, or a Host Stack. You could also create a combination
of applications. For example, you could add load balancing to a vSwitch.

The engine runs in pure userspace. This means that plugins do not
require changing core code - you can extend the capabilities of the
packet processing engine without the need to change code running at the
kernel level. Through the creation of a plugin, anyone can extend
functionality with:

-  New custom graph nodes
-  Rearrangement of graph nodes
-  New low level APIs

Feature Rich
------------
The full suite of graph nodes allows a wide variety of network appliance
workloads to be built. At a high level, the platform provides:

-  Fast lookup tables for routes, bridge entries
-  Arbitrary n-tuple classifiers
-  Out of the box production quality switch/router functionality

The following is a summary of the features the VPP platform provides:

.. toctree::

   featurerich

.. toctree::


Example Use Case: VPP as a vSwitch/vRouter
------------------------------------------

One of the use cases for the VPP platform is to implement it as a
virtual switch or router. The following section describes examples of
possible implementations that can be created with the VPP platform. For
more in depth descriptions about other possible use cases, see the list
of 

.. note::

   jadfix todo Link to the Use Cases

.. figure:: /_images/VPP_App_as_a_vSwitch_x201.jpg
   :alt: Figure: Linux host as a vSwitch
   :align: right

   Figure: Linux host as a vSwitch

You can use the VPP platform to create out-of-the-box virtual switches
(vSwitch) and virtual routers (vRouter). The VPP platform allows you to
manage certain functions and configurations of these application through
a command-line interface (CLI).

Some of the functionality that a switching application can create
includes:

* Bridge Domains
* Ports (including tunnel ports)
* Connect ports to bridge domains
* Program ARP termination

Some of the functionality that a routing application can create
includes:

* Virtual Routing and Forwarding (VRF) tables (in the thousands)
* Routes (in the millions)

Local Programmability
---------------------

.. figure:: /_images/VPP_App_as_vSwitch_with_local_programmability_x260.jpg
   :alt: VPP Communication Through Low Level API
   :align: right

   VPP Communication Through Low Level API

One approach is to implement a VPP application to communicate with an
external application within a local environment (Linux host or
container). The communication would occur through a low level API. This
approach offers a complete, feature rich solution that is simple yet
high performance. For example, it is reasonable to expect performance
yields of 500k routes/second.

This approach takes advantage of using a shared memory/message queue.
The implementation is on a local on a box or container. All CLI tasks
can be done through API calls.

The current implementation of the VPP platform generates Low Level
Bindings for C clients and for Java clients. It's possible for future
support to be provided for bindings for other programming languages.

Remote Programmability
----------------------

Another approach is to use a Data Plane Management Agent through a High
Level API. As shown in the figure, a Data Plane Management Agent can
speak through a low level API to the VPP App (engine). This can run
locally in a box (or VM or container). The box (or container) would
expose higher level APIs through some form of binding.

.. figure:: /_images/VPP_as_vSwitch_or_vRouter_supporting_remote_programmability_x260.jpg
   :alt: Figure: API Through Data Plane Management Agent

   Figure: API Through Data Plane Management Agent

This is a particularly flexible approach because the VPP platform does
not force a particular Data Plane Management Agent. Furthermore, the VPP
platform does not restrict communication to only \*one\* high level API.
Anybody can bring a Data Plane Management Agent. This allows you to
match the high level API/Data Plane Management Agent and implementation
to the specific needs of the VPP app.

Sample Data Plane Management Agent
----------------------------------

One example of using a high hevel API is to implement the VPP platform
as an app on a box that is running a local ODL instance (Honeycomb). You
could use a low level API over generated Java Bindings to talk to the
VPP App, and expose Yang Models over netconf/restconf NB.

.. figure:: /_images/VPP_sample_data_plane_management_agent_x260.jpg
   :alt: VPP Using ODL Honeycomb as a Data Plane Management Agent

   VPP Using ODL Honeycomb as a Data Plane Management Agent

This would be one way to implement Bridge Domains.

Primary Characteristics Of VPP
------------------------------

Improved fault-tolerance and ISSU
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Improved fault-tolerance and ISSU when compared to running similar
packet processing in the kernel:

* crashes seldom require more than a process restart
* software updates do not require system reboots
* development environment is easier to use and perform debug than similar kernel code
* user-space debug tools (gdb, valgrind, wireshark)
* leverages widely-available kernel modules (uio, igb_uio): DMA-safe memory

Runs as a Linux user-space process:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* same image works in a VM, in a Linux container, or over a host kernel
* KVM and ESXi: NICs via PCI direct-map
* Vhost-user, netmap, virtio paravirtualized NICs
* Tun/tap drivers
* DPDK poll-mode device drivers

Integrated with the DPDK, VPP supports existing NIC devices including:
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Intel i40e, Intel ixgbe physical and virtual functions, Intel e1000, virtio, vhost-user, Linux TAP
* HP rebranded Intel Niantic MAC/PHY
* Cisco VIC

Security issues considered:
^^^^^^^^^^^^^^^^^^^^^^^^^^^

* Extensive white-box testing by Cisco's security team
* Image segment base address randomization
* Shared-memory segment base address randomization
* Stack bounds checking
* Debug CLI "chroot"

The vector method of packet processing has been proven as the primary
punt/inject path on major architectures.

Supported Architectures
-----------------------
.. list-table:: Supported Architectures
   :widths: 50
   :header-rows: 1

   * - The VPP platform supports:

   * - x86/64
     
Supported Packaging Models
--------------------------

The VPP platform supports package installation on the following
operating systems:

.. list-table:: Supported Packaging Models
   :widths: 50 
   :header-rows: 1

   * - Operating System:

   * - Debian
   * - Ubuntu 16.04
   * - CentOS 7.3


Performance Expectations
------------------------

One of the benefits of this implementation of VPP is its high
performance on relatively low-power computing. This high level of
performance is based on the following highlights:

* High-performance user-space network stack for commodity hardware
* The same code for host, VMs, Linux containers
* Integrated vhost-user virtio backend for high speed VM-to-VM connectivity
* L2 and L3 functionality, multiple encapsulations
* Leverages best-of-breed open source driver technology: DPDK
* Extensible by use of plugins
* Control-plane / orchestration-plane via standards-based APIs

Performance Metrics
-------------------

The VPP platform has been shown to provide the following approximate
performance metrics:

* Multiple MPPS from a single x86_64 core
* >100Gbps full-duplex on a single physical host
* Example of multi-core scaling benchmarks (on UCS-C240 M3, 3.5 gHz, all memory channels forwarded, simple ipv4 forwarding):

   * 1 core: 9 MPPS in+out
   * 2 cores: 13.4 MPPS in+out
   * 4 cores: 20.0 MPPS in+out

NDR Rates 
---------

NDR rates for 2p10GE, 1 core, L2 NIC-to_NIC
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

The following chart shows the NDR rates on: 2p10GE, 1 core, L2
NIC-to_NIC.

.. figure:: /_images/Vpp_performance_barchart_ndr_rates_l2-nic-to-nic.jpg
   :alt: NDR rate for 2p10GE, 1 core, L2 NIC-to_NIC 

   NDR rate for 2p10GE, 1 core, L2 NIC-to_NIC

NDR rates for 2p10GE, 1 core, L2 NIC-to-VM/VM-to-VM
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


The following chart shows the NDR rates on: 2p10GE, 1 core, L2
NIC-to-VM/VM-to-VM .

.. figure:: /_images/VPP_performance_barchart_ndr_rates_l2-nic-to-VM.small.jpg
   :alt: NDR rates for 2p10GE, 1 core, L2 NIC-to-VM/VM-to-VM

   NDR rates for 2p10GE, 1 core, L2 NIC-to-VM/VM-to-VM

..

     NOTE:

    * Virtual network infra benchmark of efficiency
    * All tests per connection only, single core
    * Potential higher performance with more connections, more cores
    * Latest SW: OVSDPDK 2.4.0, VPP 09/2015

NDR rates VPP versus OVSDPDK
^^^^^^^^^^^^^^^^^^^^^^^^^^^^


The following chart show VPP performance compared to open-source and
commercial reports.

The rates reflect VPP and OVSDPDK performance tested on Haswell x86
platform with E5-2698v3 2x16C 2.3GHz. The graphs shows NDR rates for 12
port 10GE, 16 core, IPv4.

.. figure:: /_images/VPP_and_ovsdpdk_tested_on_haswellx86_platform.jpg
   :alt: VPP and OVSDPDK Comparison

   VPP and OVSDPDK Comparison
