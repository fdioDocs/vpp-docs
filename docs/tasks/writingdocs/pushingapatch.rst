.. _pushingapatch:

===============================================
Pushing your changes to the VPP Docs Repository
===============================================

This section will cover how to fork your own branch of the `fdioDocs/vpp-docs <https://github.com/fdioDocs/vpp-docs>`_ repository, clone that repo locally to your computer, make changes to it, see those changes on `Read the Docs <https://readthedocs.org/>`_, and how to issue a pull request when you want your changes to be reflected on the main repo.
 

.. toctree::

Forking your own branch 
------------------------
In your browser, navigate to the repo you want to branch off of. In this case, the `fdioDocs/vpp-docs <https://github.com/fdioDocs/vpp-docs>`_ repo. At the top right of the page you should see this:

.. image:: pictures/forkoptions.png
   :align: center
   :scale: 50%

Click on "Fork", and then a pop-up should appear where you should then click your Github username. Once this is done, it should automatically take you to the Github page where your new branch is located, just like in the image below.

.. image:: pictures/usernameforked.png
   :align: center
   :scale: 35%

Now your **own branch** can be **cloned** to your computer using the URL (https://github.com/YOURUSERNAME/vpp-docs) of the Github page where your branch is located.


Creating a local repository
---------------------------

Now that you have our own branch of the repo on Github, you can store it locally on our computer. In your shell, navigate to the directory where you want to store your branch/repo. Then execute:

.. code-block:: shell

   $ git clone https://github.com/YOURUSERNAME/vpp-docs

This will create a directory on your computer named **vpp-docs**, the name of the repo. If you want the directory to be named something other than vpp-docs, you can add your own directory name at the end of the command, shown below:

.. code-block:: shell

   $ git clone https://github.com/YOURUSERNAME/vpp-docs OTHERNAME


Now that your branch is on your computer, you can modify files and make changes however you wish.

**REMEMBER,** commit often to save your work. Now that you have your own branch and local repo, you can **git add** your modified files, **git commit** them, and **git push** them to your branch. Even just **committing** your files saves a Snapshot of them in Git, so it's very hard to lose your work!


Modifying and building files
----------------------------

Since we use **.rst** files, **Sphinx**, and **Read the docs** for documenting, you should install `Sphinx <http://www.sphinx-doc.org/en/master/usage/installation.html>`_, and follow their `getting started guide <http://www.sphinx-doc.org/en/master/usage/quickstart.html>`_.

Building these files will generate an **index.html** file, which you can then view in your browser to verify and see your file changes.

Make sure your Sphinx-build directory is **not** the directory of your local repo, or else Git will think you want to stage and commit your build files (which will show up as "Untracked files" when you try to commit). To ensure this, create a new empty directory which will store your build files.

If you're in your local repository, change to the parent directory and create a new directory:


.. code-block:: shell

   $ cd ..
   $ mkdir NEWDIRECTORYNAME

Now you can build your repo files into the newly created directory.

You must specify the source directory, the directory where your **conf.py** is located. In this case, it's located in **vpp-docs/docs**. 
You must also specify the build directory, which is the name of newly created directory from the previous step.

.. code-block:: shell

   $ sphinx-build -b html vpp-docs/docs NEWDIRECTORYNAME

If there are no errors during the build process, an **index.html** file will now be generated inside NEWDIRECTORYNAME (I named mine vpp-docs-build), which you can then open up in your browser.

.. image:: pictures/screenshotdirectory.png
   :align: center
   :scale: 35%


Viewing your changes on Read the docs (Optional)
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
**Read the docs** looks at repositories on Github and hosts it's own standalone page by generating and displaying your **index.html** file, so others users can view it without having to download and build your repo. 

Sign up for a Read the docs account. When brought to this page,

.. image:: pictures/screenshotreadthedocs.png
   :align: center
   :scale: 35%


Click "request", and then a dialog will pop-up asking for request approval from fdioDocs. Then click "Request approval from owners."

!!!!!!!!!!TO DO!!!!!!!!!!!!!!! (waiting for request approval).


Adding, committing, and pushing your changes
--------------------------------------------

When you're satisfied with the additions and changes you've made to your local repo, and now you want your changes to be reflected in the main vpp-docs repo, you must add the main repo as a remote repository for the merging process to begin.

First, change directories to your local repo.

.. code-block:: shell

   $ cd vpp-docs

You can view current repositories with:

.. code-block:: shell

   $ git remote -v

At this point, it should only show us the repo of the branch you created from previous steps.

.. image:: pictures/screenshotremotes.png
   :align: left
   :scale: 45%

|
|
|
|

Now you want to create a remote repository of the main vpp-docs repo (naming it upstream), so we can merge our repo and the main repo together.

.. code-block:: shell

   $ git remote add upstream https://github.com/fdioDocs/vpp-docs


You can verify that you have added a remote repo using the previous **git remote -v** command.

.. image:: pictures/screenshotbothremotes.png
   :align: left
   :scale: 45%

|
|
|
|


If there has been any changes to the main repo since you've started working and modifying your own branch (hopefully not the same files as the ones you were working on!), you want to keep them in sync, so merge the main repo into your own (). 





Initiating a pull request
-------------------------


Getting the Latest Sources
--------------------------

.. code-block:: console

    git reset --hard origin/master
    git checkout master

.. _fdioDocs: https://github.com/fdioDocs/vpp-docs

