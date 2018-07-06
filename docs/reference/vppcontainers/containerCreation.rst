.. _containerCreation:

.. toctree::

Creating Containers
___________________


The system configuration is located at /etc/lxc/lxc.conf or ~/.config/lxc/lxc.conf for unprivileged containers.

This configuration file is used to set values such as default lookup paths and storage backend settings for LXC. It can be found in each container's **/sys/class/net** directory.

The command below configures the LXC (Linux container) networks to create an interface for a Linux bridge and an unconsumed second interface to be used by each container.

For more information on linux containers with Ubuntu, visit the `lxc server guide <https://help.ubuntu.com/lts/serverguide/lxc.html>`_.

.. code-block:: shell

    echo -e "lxc.network.name = veth0\nlxc.network.type = veth\nlxc.network.name = veth_link1"  | sudo tee -a /etc/lxc/default.conf


This next command will create an Ubuntu Xenial container named "cone".

.. code-block:: shell

      $ sudo lxc-create -t download -n cone -- --dist ubuntu --release xenial --arch amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80


If successful, you'll get an output similar to this:

.. code-block:: console
    
    root@localhost:~# You just created an Ubuntu xenial amd64 (20180625_07:42) container.

    To enable SSH, run: apt install openssh-server
    No default root or user password are set by LXC.


You can make another container "ctwo".

.. code-block:: shell

     $ sudo lxc-create -t download -n ctwo -- --dist ubuntu --release xenial --arch amd64 --keyserver hkp://p80.pool.sks-keyservers.net:80


Afterwards, you can list your containers:


.. code-block:: shell

     $ sudo lxc-ls

.. code-block:: console

    root@localhost:~# cone ctwo


Here are some `lxc container commands <https://help.ubuntu.com/lts/serverguide/lxc.html.en-GB#lxc-basic-usage>`_ you may find useful:


.. code-block:: shell

      sudo lxc-ls --fancy
      sudo lxc-start --name u1 --daemon
      sudo lxc-info --name u1
      sudo lxc-stop --name u1
      sudo lxc-destroy --name u1


Lets start the first container:

.. code-block:: shell
    
    $ sudo lxc-start --name cone

Verify its running:

.. code-block:: shell
    
    $ sudo lxc-ls --fancy

.. code-block:: console

    NAME STATE   AUTOSTART GROUPS IPV4 IPV6 
    cone RUNNING 0         -      -    -    
    ctwo STOPPED 0         -      -    -  
