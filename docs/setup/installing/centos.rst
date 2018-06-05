.. _centos:

.. toctree::

Setup the fd.io Repository (Centos 7.3)
=======================================

From the following choose one of the releases to install.


Update the OS
-------------

It is probably a good idea to update and upgrade the OS before starting

.. code-block:: console

    yum update


Point to the Repository
-----------------------

Create a file **"/etc/yum.repos.d/fdio-release.repo"** with the contents that point to
the version needed. The contents needed are shown below.


VPP latest Release
^^^^^^^^^^^^^^^^^^

Create the file "/etc/yum.repos.d/fdio-release.repo".

.. code-block:: console

   [fdio-release]
   name=fd.io release branch latest merge
   baseurl=https://nexus.fd.io/content/repositories/fd.io.centos7/
   enabled=1
   gpgcheck=0


VPP stable/1804 Branch
^^^^^^^^^^^^^^^^^^^^^^

Create the file "/etc/yum.repos.d/fdio-release.repo".

.. code-block:: console

   [fdio-stable-1804]
   name=fd.io stable/1804 branch latest merge
   baseurl=https://nexus.fd.io/content/repositories/fd.io.stable.1804.centos7/
   enabled=1
   gpgcheck=0


VPP master Branch
^^^^^^^^^^^^^^^^^

Create the file "/etc/yum.repos.d/fdio-release.repo".

.. code-block:: console

   [fdio-master]
   name=fd.io master branch latest merge
   baseurl=https://nexus.fd.io/content/repositories/fd.io.master.centos7/
   enabled=1
   gpgcheck=0


Install VPP RPMs
================

.. code-block:: console

   sudo yum install vpp


Install the optional RPMs
=========================

.. code-block:: console

   sudo yum install vpp-plugins vpp-devel vpp-api-python vpp-api-lua vpp-api-java


Uninstall the VPP RPMs
======================

.. code-block:: console

   sudo yum autoremove vpp*
