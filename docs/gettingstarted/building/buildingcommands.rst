.. _buildingcommands:

.. toctree::

Building VPP Commands
=====================

.. _setupproxies:

Set up Proxies
--------------

Depending on the environment, proxies may need to be set. 
You may run these commands:

::

    $ export http_proxy=http://<proxy-server-name>.com:<port-number>
    $ export https_proxy=https://<proxy-server-name>.com:<port-number>


Build VPP Dependencies
----------------------

Before building, make sure there are no FD.io VPP or DPDK packages installed by entering the following commands:

::

    dpkg -l | grep vpp 
    dpkg -l | grep DPDK

Run this to install the dependency packages for FD.io VPP. 
If it hangs during downloading at any point, make sure :ref:`proxies <setupproxies>` were set first.

::

    # make install-dep

    *Output should look like this*
    ...
    ...

    Update-alternatives: using /usr/lib/jvm/java-8-openjdk-amd64/bin/jmap to provide /usr/bin/jmap (jmap) in auto mode
    Setting up default-jdk-headless (2:1.8-56ubuntu2) ...
    Processing triggers for libc-bin (2.23-0ubuntu3) ...
    Processing triggers for systemd (229-4ubuntu6) ...
    Processing triggers for ureadahead (0.100.0-19) ...
    Processing triggers for ca-certificates (20160104ubuntu1) ...
    Updating certificates in /etc/ssl/certs...
    0 added, 0 removed; done.
    Running hooks in /etc/ca-certificates/update.d...

    done.
    done.

Build VPP (Debug Mode)
----------------------

This build version contains debug symbols which is useful to modify VPP. The command below will build debug version of VPP. 
This build will come with /build-root/vpp_debug-native.

::

    # make build

You may ignore the following warning if encountered after running the *make build* command:

::

    libtool: warning: remember to run 'libtool --finish /none'


Build VPP (Release Version)
---------------------------

To build release version of VPP.
This is package is for those who will not be debugging in VPP.
This build will come with /build-root/build-vpp-native

::

    # make release


Building Debian Packages
------------------------

After running the previous commands, it is still necessary to build the debian packages.

Execute one of the two commands below depending on the system:

For most operating systems (including Ubuntu)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

::

    # make pkg-deb 


For CentOS
^^^^^^^^^^

::

    # make pkg-rpm

.. note::

    Please follow the commands that the Operating System prompts, after running one of the commands above

The packages will be found in the build-root directory.

:: 
    
    # ls *.deb

    If packages built correctly, this should be the Output

    vpp_18.07-rc0~456-gb361076_amd64.deb             vpp-dbg_18.07-rc0~456-gb361076_amd64.deb
    vpp-api-java_18.07-rc0~456-gb361076_amd64.deb    vpp-dev_18.07-rc0~456-gb361076_amd64.deb
    vpp-api-lua_18.07-rc0~456-gb361076_amd64.deb     vpp-lib_18.07-rc0~456-gb361076_amd64.deb
    vpp-api-python_18.07-rc0~456-gb361076_amd64.deb  vpp-plugins_18.07-rc0~456-gb361076_amd64.deb

Packages built installed end up in build-root directory. Finally, the command below installs all built packages.

:: 

   # dpkg -i *.deb