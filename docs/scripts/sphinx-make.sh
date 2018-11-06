#!/bin/bash -ex

if [ "$1" == "venv" ]
then
    python -m pip install --user virtualenv
    python -m virtualenv $VENV_DIR
    source $VENV_DIR/bin/activate;
    pip install -r $DOCS_DIR/etc/requirements.txt
else
    source $VENV_DIR/bin/activate;
    VERSION=`source $WS_ROOT/src/scripts/version`
    sed -ie "s/version = .*/version = u'$VERSION'/" $DOCS_DIR/conf.py
    rm $DOCS_DIR/conf.pye
    make -C $DOCS_DIR $1
fi

deactivate
