.. _vagrantOverview:

.. toctree::

Overview
^^^^^^^^

In finer detail, this guide shows how the VPP :ref:`vppVagrantfile` interacts with shell scripts to configure a `Vagrant box <https://www.vagrantup.com/docs/boxes.html>`_ that boots a VM with VPP *built*. Once inside the VM, VPP is installed and ran, along with *lxc* to manage the two linux containers. The containers are then accessed individually, so VPP can be installed and their network interface settings can be viewed. Finally, the last section connects these containers with VPP and sends pings from one container to the other.

A container is essentially a more efficient and faster VM, due to the fact that a container does not simulate a separate kernel and hardware. You can read more about `Linux containers here <https://linuxcontainers.org/>`_.

.. _prereqlabel:

Prerequisites
_____________

You have the `Git VPP repo <https://github.com/FDio/vpp>`_ cloned locally on your machine. 


This guide will refer to the following files from that repo: *Vagrantfile, build.sh, env.sh, and update.sh*.







