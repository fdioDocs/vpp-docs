.. _software_architecture:

.. toctree::

#######################
Software Architecture
#######################

The fd.io vpp implementation is a third-generation vector packet
processing implementation specifically related to US Patent 7,961,636,
as well as earlier work. Note that the Apache-2 license specifically
grants non-exclusive patent licenses; we mention this patent as a
point of historical interest.

For performance, the vpp dataplane consists of a directed graph of
forwarding nodes which process multiple packets per invocation. This
schema enables a variety of micro-processor optimizations: pipelining
and prefetching to cover dependent read latency, inherent I-cache
phase behavior, vector instructions. Aside from hardware input and hardware output nodes,
the entire forwarding graph is portable code.

Depending on the scenario at hand, we often spin up multiple worker
threads which process ingress-hashes packets from multiple queues using
identical forwarding graph replicas. 

Implementation Taxonomy
=======================

The vpp dataplane consists of four distinct layers: 

* An infrastructure layer comprising vppinfra, vlib, svm, and binary api libraries. See .../src/{vppinfra, vlib, vlibapi, vlibmemory, svm}

* A generic network stack layer: vnet. See .../src/vnet

* An application shell: vpp. See .../src/vpp

* An increasingly rich set of data-plane plugins: see .../src/plugins

It's important to understand each of these layers in a certain amount
of detail. Much of the implementation is best dealt with at the API
level, and otherwise left alone.

         
