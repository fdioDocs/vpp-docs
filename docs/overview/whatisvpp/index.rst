.. _whatisvpp:

=========================================
What is VPP?
=========================================

FD.io's Vector Packet Processing (VPP) technology is a :ref:`fast`,
:ref:`packet-processing` stack that runs on commodity CPUs. It provides
out-of-the-box production quality switch/router functionality and much, much
more. FD.io VPP is at the same time, an :ref:`extensible` and
:ref:`developer-friendly` framework, capable of boot-strapping the development
of packet-processing applications. The benefits of FD.io VPP are its high
performance, proven technology, its modularity and flexibility, integrations and
rich feature set.

For more detailed information, see the following sections:

.. toctree::
   :maxdepth: 1

   dataplane.rst
   fast.rst
   developer.rst
   extensible.rst

**What is vector packet processing?**

As the name implies, FD.io VPP uses vector packet processing, as opposed to
scalar packet processing. A scalar packet processing stack simply processes one
packet at a time: an interrupt handling function takes a single packet from a
device rx ring, and processes it by traversing a set of functions: A calls B
calls C … return return return, then return from interrupt. For each packet, one
of three things happens: the path punts, drops, or rewrites and forwards the
packet.

Scalar packet processing is simple, but problematic in these ways:

* When the path length exceeds the size of the I-cache, thrashing
  occurs. Each packet incurs an identical set of I-cache misses
  The only solution: bigger caches.
* Deep call stack adds load-store-unit pressure since stack-locals
  fall out of the L1 D-cache
* Aside from prefetching packet data - probably not in time - one
  can't address dependent read latency on table walks in a meaningful way

In contrast, vector packet processing constructs vectors of packets by
scraping up to 256 packets at a time from device rx rings, and
processes them using a directed graph of node. The graph scheduler
invokes one node dispatch function at a time, restricting stack depth
to a few stack frames.

This scheme fixes the I-cache thrashing problem. 

Graph node dispatch functions iterate across up to 256 vector
elements. Processing the first packet in a vector warms up the
I-cache. The remaining packets all hit in the I-cache, reducing
I-cache miss stalls by up to two orders of magnitude.

Given a vector of packets, one can pipeline and prefetch to cover
dependent read latency on table data needed to process packets.

Vector packet processing techniques lead to a **stable** graph
dispatch circuit time equilibrium. For a given offered load, imagine
that the dispatch circuit time - and hence the vector size - converge
to certain values. Say that an operating system event such as a
clock-tick interrupt introduces a delay into the main dispatch loop.

The next rx vector will be larger. Larger vectors are processed more
efficiently: I-cache warmup costs are amortized over a larger number
of packets.

Rapidly, the rx vector size and the dispatch circuit time return to
the previous equilibrium values. Given a relatively stable offered
load, it's an important advantage for the vector size to remain stable
in the face of exogenous events.

