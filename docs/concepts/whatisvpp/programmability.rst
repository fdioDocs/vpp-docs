.. _programmability:

.. toctree::

Programmability
***********************************

Local Programmability
---------------------

.. figure:: /_images/VPP_App_as_vSwitch_with_local_programmability_x260.jpg
   :alt: VPP Communication Through Low Level API
   :align: right

   FD.io VPP Communication Through Low Level API

One approach is to implement a FD.io VPP application to communicate with an
external application within a local environment (Linux host or
container). The communication would occur through a low level API. This
approach offers a complete, feature rich solution that is simple yet
high performance. For example, it is reasonable to expect performance
yields of 500k routes/second.

This approach takes advantage of using a shared memory/message queue.
The implementation is on a local on a box or container. All CLI tasks
can be done through API calls.

The current implementation of the FD.io VPP platform generates Low Level
Bindings for C clients and for Java clients. It's possible for future
support to be provided for bindings for other programming languages.

Remote Programmability
----------------------

Another approach is to use a Data Plane Management Agent through a High
Level API. As shown in the figure, a Data Plane Management Agent can
speak through a low level API to the FD.io VPP App (engine). This can run
locally in a box (or VM or container). The box (or container) would
expose higher level APIs through some form of binding.

.. figure:: /_images/VPP_as_vSwitch_or_vRouter_supporting_remote_programmability_x260.jpg
   :alt: Figure: API Through Data Plane Management Agent

   Figure: API Through Data Plane Management Agent

This is a particularly flexible approach because the FD.io VPP platform does
not force a particular Data Plane Management Agent. Furthermore, the FD.io VPP
platform does not restrict communication to only \*one\* high level API.
Anybody can bring a Data Plane Management Agent. This allows you to
match the high level API/Data Plane Management Agent and implementation
to the specific needs of the FD.io VPP app.
