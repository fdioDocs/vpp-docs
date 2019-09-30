#!/bin/bash

if [ "$1" == "venv" ]
then
    python3 -m pip install --user virtualenv
    python3 -m virtualenv $VENV_DIR
    source $VENV_DIR/bin/activate;
    python3 -m pip install -r $DOCS_DIR/etc/requirements.txt
else
    source $VENV_DIR/bin/activate;
    make -C $DOCS_DIR $1
fi

deactivate
