.. _packet-processing:

=================
Packet Processing
=================

* Layer 2 - 4 Network Stack

  * Fast lookup tables for routes, bridge entries
  * Arbitrary n-tuple classifiers 
  * Control Plane, Traffic Management and Overlays
 
* `Linux <https://en.wikipedia.org/wiki/Linux>`_ and `FreeBSD <https://en.wikipedia.org/wiki/FreeBSD>`_ support

  * Wide support for standard Operating System Interfaces such as AF_Packet, Tun/Tap & Netmap.

* Wide network and cryptograhic hardware support with `DPDK <https://www.dpdk.org/>`_.
* Container and Virtualization support

  * Para-virtualized intefaces; Vhost and Virtio 
  * Network Adapters over PCI passthrough
  * Native container interfaces; MemIF
  
* Universal Data Plane: one code base, for many use cases
 
  * Discrete appliances; such as `Routers <https://en.wikipedia.org/wiki/Router_(computing)>`_ and `Switches <https://en.wikipedia.org/wiki/Network_switch>`_.
  * `Cloud Infrastructure and Virtual Network Functions <https://en.wikipedia.org/wiki/Network_function_virtualization>`_
  * `Cloud Native Infrastructure <https://www.cncf.io/>`_
  * The same binary package for all use cases. 

* Fault-tolerant and upgradable

  * Runs as a standard user-space process for fault tolerance, software crashes seldom require more than a process restart. 
  * Improved fault-tolerance and upgradability when compared to running similar packet processing in the kernel, software updates never require system reboots. 
  * Development expierence is easier compared to similar kernel code 
  * Gardware isolation and protection (`iommu <https://en.wikipedia.org/wiki/Input%E2%80%93output_memory_management_unit>`_)

* `Out of the box production quality <https://wiki.fd.io/view/CSIT#Start_Here>`_. 

For more information, please see :ref:`features` for the complete list.

