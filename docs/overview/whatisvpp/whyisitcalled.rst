.. _whyisitcalled:

.. toctree::

Why is it called vector processing?
***********************************

As the name implies, FD.io VPP uses vector processing as opposed to scalar
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

