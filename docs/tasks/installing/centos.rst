.. _centos:

.. toctree::

The fd.io repo
--------------------
From the following choose one of the releases to install.

CentOS 7.3 - VPP Release RPMs (Latest)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a file **/etc/yum.repos.d/fdio-release.repo** with contents:

.. code-block:: console

   [fdio-release]
   name=fd.io release branch latest merge
   baseurl=https://nexus.fd.io/content/repositories/fd.io.centos7/
   enabled=1
   gpgcheck=0

CentOS 7.3 - VPP stable/1804 branch RPMs
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a file **/etc/yum.repos.d/fdio-release.repo** with contents:

.. code-block:: console

   [fdio-stable-1804]
   name=fd.io stable/1804 branch latest merge
   baseurl=https://nexus.fd.io/content/repositories/fd.io.stable.1804.centos7/
   enabled=1
   gpgcheck=0

CentOS 7.3 - VPP master branch RPMs (in development)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Create a file **/etc/yum.repos.d/fdio-release.repo** with contents:

.. code-block:: console

   [fdio-master]
   name=fd.io master branch latest merge
   baseurl=https://nexus.fd.io/content/repositories/fd.io.master.centos7/
   enabled=1
   gpgcheck=0

Install VPP RPMs
-------------------

.. code-block:: console

   sudo yum install vpp

Install the optional RPMs
----------------------------

.. code-block:: console

   sudo yum install vpp-plugins vpp-devel vpp-api-python vpp-api-lua vpp-api-java

Uninstall the VPP RPMs
------------------------

.. code-block:: console

   sudo yum autoremove vpp*

