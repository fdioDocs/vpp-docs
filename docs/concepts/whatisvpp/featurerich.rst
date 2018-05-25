.. _featurerich:

.. toctree::

List of Features
----------------

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

IPv4
^^^^

* GRE, MPLS-GRE, NSH-GRE,
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

MPLS
^^^^

* MPLS-o-Ethernet – Deep label stacks supported

L2
^^

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
