.. _performance:

=========================================
Performance 
=========================================

Performance Expectations
^^^^^^^^^^^^^^^^^^^^^^^^

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
^^^^^^^^^^^^^^^^^^^

FD.io VPP platform is high performance packet processing software, typically achieving:

* Multiple MPPS from a single x86_64 core
* >100Gbps full-duplex on a single physical host
* Continuous performance regression testing in FD.io, demonstrates FD.io ongoing commitment to achieving ever performance.

=========================================
Performance Tests
=========================================

.. toctree::

    l2ethswitch.rst
    ipv4routedforwarding.rst
    ndr.rst

