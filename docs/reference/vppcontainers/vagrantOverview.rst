.. _vagrantOverview:

.. toctree::

Overview
^^^^^^^^

This section will describe how to install a Virtual Machine (VM) for Vagrant, and install containers inside that VM. Finally, it will conclude with connecting these two containers together and pinging between them. 

Containers are environments similar to VM's, but are known to be faster since they do not simulate  separate kernels and hardware, as VM's do. You can read more about `Linux containers here <https://linuxcontainers.org/>`_.


In this section, we'll use Vagrant to run our VirtualBox VM. **Vagrant** automates the configuration of virtual environments by giving you the ability to create and destroy VM's (wrapped in *Vagrant boxes*) quick and seemlessly.

.. _prereqlabel:

Prerequisites
_____________

You have the `Git VPP repo <https://github.com/FDio/vpp>`_ cloned locally on your machine. 


This guide will refer to the following files from that repo: *Vagrantfile, build.sh, env.sh, and update.sh*.

.. note::

   While you *can* just blindly run every command/script, understanding how the Vagrantfile and scripts interact with each other are vital to customizing your own VM's that have your specific configuration options and packages installed.






