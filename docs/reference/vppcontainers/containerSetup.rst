.. _twocontainers:

.. toctree::

=====================================
VPP with two Containers using Vagrant
=====================================

Container prerequisites
_______________________

Lets go into container *cone* and install prerequisites such as VPP, as well as some additional commands:

To enter our container via the shell, type:

.. code-block:: shell
    
    $ sudo lxc-attach -n cone

Which should output:

.. code-block:: console
    
    root@cone:/#

Now run the linux DHCP setup and install VPP: 

.. code-block:: shell
    
    $ sudo bash
    $ resolvconf -d eth0
    $ dhclient
    $ apt-get install -y wget
    $ echo "deb [trusted=yes] https://nexus.fd.io/content/repositories/fd.io.ubuntu.xenial.main/ ./" | sudo tee -a /etc/apt/sources.list.d/99fd.io.list
    $ apt-get update
    $ apt-get install -y --force-yes vpp
    $ sh -c 'echo  \"\\ndpdk {\\n   no-pci\\n}\" >> /etc/vpp/startup.conf'

And lets start VPP in this container as well:

.. code-block:: shell
    
    $ service vpp start

Now repeat this process for the second container, ctwo, and also don't forget to "start" it with **sudo lxc-start --name ctwo**.




