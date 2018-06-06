.. _modularflexibleextensible:

.. toctree::

Modular, Flexible, and Extensible
***********************************

The FD.io VPP platform is built on a ‘packet processing graph’. This modular
approach means that anyone can ‘plugin’ new graph nodes. This makes
extensibility rather simple, and it means that plugins can be customized
for specific purposes.

.. figure:: /_images/VPP_custom_application_packet_processing_graph.280.jpg
   :alt: Custom Packet Processing Graph

   Custom Packet Processing Graph

How does the plugin come into play? At runtime, the FD.io VPP platform grabs
all available packets from RX rings to form a vector of packets. A
packet processing graph is applied, node by node (including plugins) to
the entire packet vector. Graph nodes are small and modular. Graph nodes
are loosely coupled. This makes it easy to introduce new graph nodes. It
also makes it relatively easy to rewire existing graph nodes.

A plugin can introduce new graph nodes or rearrange the packet
processing graph. You can also build a plugin independently of the FD.io VPP
source tree - which means you can treat it as an independent component.
A plugin can be installed by adding it to a plugin directory.

The FD.io VPP platform can be used to build any kind of packet processing
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
