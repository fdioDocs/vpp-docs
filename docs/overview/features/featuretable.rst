=================
List of features
=================

	 
.. rst-class:: center-align-table
	 
+-------------------------+-----------+
| :ref:`sdn`              |           |
+------------+------------+ :ref:`cp` |
|            | :ref:`l4`  |           |
|            +------------+-----------+
| :ref:`tun` | :ref:`l3`  |           |
|            +------------+ :ref:`tm` |
|            | :ref:`l2`  |           |
+------------+------------+-----------+
| :ref:`dev`                          |
+-------------------------------------+


.. toctree::
   :hidden:
  
   devices.rst
   integrations.rst
   l2.rst
   l3.rst
   l4.rst
   trafficmanagement.rst
   tunnels.rst
   controlplane.rst

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

.. _featuretable:

=========
In Detail
=========

+-------------------------+-----------+-----------+
| :ref:`sdn`              |           |           |
+------------+------------+ :ref:`cp` |           |
|            | :ref:`l4`  |           |           |
|            +------------+-----------+ :ref:`pg` |
| :ref:`tun` | :ref:`l3`  |           |           |
|            +------------+ :ref:`tm` |           |
|            | :ref:`l2`  |           |           |
+------------+------------+-----------+-----------+
| :ref:`dev`                                      |
+-------------------------------------------------+

=================
Need a Title Here
=================

.. toctree::

   devices.rst
   trafficmanagement.rst
   l2.rst
   l3.rst
   l4.rst
   tunnels.rst
   controlplane.rst
   plugins.rst
