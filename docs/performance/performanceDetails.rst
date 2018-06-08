.. _performanceDetails:

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

FD.io VPP platform is high performance packet processing software, typically achieving:

* Multiple MPPS from a single x86_64 core
* >100Gbps full-duplex on a single physical host
* Continuous performance regression testing in FD.io, demonstrates FD.io ongoing commitment to achieving ever performance.
    * L2 Ethernet Switching (1 thread, 1 core, 10GE).

    .. note::
     
        todo embed this `live graph <https://docs.fd.io/csit/master/trending/_static/vpp/cpta-l2-1t1c-x520.html>`_

    * IPv4 Routed Forwarding (1 thread, 1 core, 10GE).

    .. note::
     
        todo embed this `graph <https://docs.fd.io/csit/master/trending/_static/vpp/cpta-ip4-1t1c-x520.html>`_

    * `Further information can be found in the VPP Performance Dashboard <https://docs.fd.io/csit/master/trending/introduction/index.html>`_

