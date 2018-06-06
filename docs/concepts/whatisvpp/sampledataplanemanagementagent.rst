.. _sampledataplanemanagementagent:

.. toctree::

Sample Data Plane Management Agent
***********************************

One example of using a high hevel API is to implement the FD.io VPP platform
as an app on a box that is running a local ODL instance (Honeycomb). You
could use a low level API over generated Java Bindings to talk to the
FD.io VPP App, and expose Yang Models over netconf/restconf NB.

.. figure:: /_images/VPP_sample_data_plane_management_agent_x260.jpg
   :alt: VPP Using ODL Honeycomb as a Data Plane Management Agent

   FD.io VPP Using ODL Honeycomb as a Data Plane Management Agent

This would be one way to implement Bridge Domains.

