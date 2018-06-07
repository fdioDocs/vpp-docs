.. _featurerich:

.. toctree::

Feature Rich
************

The huge number of supported network protocols allows a wide variety of network appliance
workloads to be built. At a high level, the platform provides:

-  Fast lookup tables for routes, bridge entries
-  Arbitrary n-tuple classifiers
-  Out of the box production quality switch/router functionality

The following is a summary of the features the FD.io VPP platform provides:

List of Features
----------------

Universal Data Plane
^^^^^^^^^^^^^^^^^^^^^

* Layer 2 - 4 Network Stack
* CP, TM, Overlays and more...
* Linux (and FreeBSD) support
* Kernel Interfaces (Netmap, Fastmap)
* Container and Virtualization support
* Appliance, infrastructure, VNF & CNF

Fast, Scalable and Deterministic
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* L2XC - 15+ Mpps per core
* 0 packet drops, ~15µs latency
* Continuous & extensive latency testing
* Linear scaling with core/thread count
* Supporting millions of concurrent L[2,3] tables entries

Extensible Modular Design
^^^^^^^^^^^^^^^^^^^^^^^^^

* Pluggable, easy to understand & extend
* Mature graph node Architecture
* Full control to reorganize the pipeline
* Fast, plugins are equal citizens

Developer Friendly
^^^^^^^^^^^^^^^^^^

* Runtime counters for everything. (throughput, ipc, errors etc)
* Full pipeline tracing facilities
* Multi-language API bindings
* VPP command line introspection

IPv4/IPv6
^^^^^^^^^

* 14+ MPPS, single core
* Multimillion entry FIBs
* Input Checks

  * Source RPF
  * TTL expiration
  * header checksum
  * L2 length < IP length
  * ARP resolution/snooping
  * ARP proxy

* Thousands of VRFs

  * Controlled cross-VRF lookups

* Multipath – ECMP and Unequal Cost
* Multiple million Classifiers - Arbitrary N-tuple
* VLAN Support – Single/Double tag

L2
--

* VLAN Support

  * Single/ Double tag
  * L2 forwarding with EFP/BridgeDomain concepts

* VTR – push/pop/Translate (1:1,1:2, 2:1,2:2)
* Mac Learning – default limit of 50k addresses
* Bridging – Split-horizon group support/EFP Filtering
* Proxy Arp
* Arp termination
* IRB – BVI Support with RouterMac assignment
* Flooding
* Input ACLs
* Interface cross-connect

MPLS
^^^^

* MPLS-o-Ethernet – Deep label stacks supported

L3
-- 

IPv4
^^^^

* GRE, MPLS-GRE, NSH-GRE
* VXLAN
* IPSEC
* DHCP client/proxy

IPv6
^^^^

* Neighbor discovery
* Router Advertisement
* DHCPv6 Proxy
* L2TPv3
* Segment Routing
* MAP/LW46 – IPv4aas
* iOAM