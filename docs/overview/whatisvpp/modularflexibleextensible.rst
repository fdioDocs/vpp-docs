.. _modularflexibleextensible:

.. toctree::

Modular, Flexible, and Extensible
***********************************

The FD.io VPP packet processing pipeline is decomposed into a ‘packet processing graph’. 
This modular approach means that anyone can ‘plugin’ new graph nodes. This makes
FD.io VPP easily exensible, and it means that plugins can be customized
for specific purposes. FD.io is also configurable through it's Low-Level API.

.. figure:: /_images/VPP_custom_application_packet_processing_graph.280.jpg
   :alt: How do plugins work?
   
   How do plugins work?

At runtime, the FD.io VPP platform assembles a vector of packets
from RX rings, typically up to 256 packets in a single vector. A packet processing graph is applied, 
node by node (including plugins) to the entire packet vector. The received packets typically traverse
the packet processing graph nodes in the vector, when the network processing represented by each graph node is applied to each packet in turn.
Graph nodes are small and modular. Graph nodes are loosely coupled. This makes it easy to introduce new graph nodes. 
It also makes it relatively easy to rewire existing graph nodes.

A plugin can introduce new graph nodes or rearrange the packet processing graph.
You can also build a plugin independently of the FD.io VPP source tree - which means you can treat it as an independent component.

The FD.io VPP platform can be used to build any kind of packet processing
application. It can be used as the basis for a Load Balancer, a
Firewall, an IDS, or a Host Stack. You could also create a combination
of applications. For example, you could add load balancing to a vSwitch.

