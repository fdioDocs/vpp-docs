.. _directories::

.. toctree::

Useful Directories
======================

After pulling and building FDIO there are a few directories worth looking at.
src/vpp/conf

This directory contains default configuration files.

::

    # ls
    80-vpp.conf  startup.conf

User Tools 
----------

This directory is provided with DPDK. The two import scripts are cpu_layout.py and dpdk-devbind.py

build-root/build-vpp_debug-native/dpdk/dpdk-17.02/usertools/
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    # ls ./build-root/build-vpp_debug-native/dpdk/dpdk-17.02/usertools/
    cpu_layout.py  dpdk-devbind.py  dpdk-pmdinfo.py  dpdk-setup.sh

VPP/bin
-------

build-root/install-vpp_debug-native/vpp/bin/
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* This directory contains the vpp executables. 
* The most useful files are vpp and vppctl.
* These files are copied to/usr/bin after FDIO is installed. 
* You can use the binary file “vpp” located in this directory with gdb to help debug FDIO.
 
::

    root@tf-ucs-3# ls ./build-root/install-vpp_debug-native/vpp/bin
    elftool  svmdbtool  svmtool  vpp  vppapigen  vpp_api_test  vppctl  vpp_get_metrics  vpp_json_test  vpp_restart

Devbind 
-------

dpdk-devbind.py
^^^^^^^^^^^^^^^

* The dpdk-devbind.py script is provided with the Intel DPDK. 
* It is included with FD.io VPP.
* After FD.io VPP is built, this script and other DPDK tools can be found in build-root/build-vpp_debug-native/dpdk/dpdk-17.02/usertools/. 

vNet 
----

src/scripts/vnet/
^^^^^^^^^^^^^^^^^

This directory has some very useful examples using the FDIO traffic generator and general configuration.

::

    # ls src/scripts/vnet/
    arp4       dhcp   ip6          l2efpfilter_perf  l2flood   mcast            pcap     rightpeer  snat_det


src/vnet/
^^^^^^^^^

This directory contains most of the important source code.

::

    # ls src/vnet
    adj          config.h  fib             interface.api       interface_output.c  lawful-intercept  misc.c      ppp

src/vnet/devices/
^^^^^^^^^^^^^^^^^

This directory contains the device drivers. For example, the vhost driver is in src/vnet/devices/virtio.

::

    # ls src/vnet/devices/virtio/
    dir.dox  vhost_user.api  vhost_user_api.c  vhost-user.c  vhost-user.h
