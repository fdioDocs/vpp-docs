.. _performance:

.. toctree::

Performance
***********

Performance Expectations
-------------------------

One of the benefits of this implementation of FD.io VPP is its high
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

The FD.io VPP platform has been shown to provide the following approximate
performance metrics:

* Multiple MPPS from a single x86_64 core
* >100Gbps full-duplex on a single physical host
* Example of multi-core scaling benchmarks (on UCS-C240 M3, 3.5 gHz, all memory channels forwarded, simple ipv4 forwarding):

   * 1 core: 9 MPPS in+out
   * 2 cores: 13.4 MPPS in+out
   * 4 cores: 20.0 MPPS in+out
