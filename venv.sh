#!/bin/bash

# variable for the virtualenv
VIRTUALENV=venv

# if venv exists use and if not, create it
if [ -e "$VIRTUALENV" ]
then
    echo "Re-using existing virtualenv"
    . $VIRTUALENV/bin/activate
else
    virtualenv --no-site-packages $VIRTUALENV || { echo "Virtualenv failed"; exit -1; }
    . $VIRTUALENV/bin/activate
    easy_install -U setuptools
    easy_install pip
    rm -f md5.requirements.last
fi

# get a hash for the requirements
cat requirements.txt | md5sum > current.md5

# diff the two together
diff current.md5 previous.md5

# assign return of last command to variable
REQUIREMENTS_DIFF=$?

# if there was a diff reinstall the requirements
if [ "$REQUIREMENTS_DIFF" -ne 0 ]
then

    # install the requiremnts or fail
    pip install -r requirements.txt --timeout=100 --use-mirrors || { echo "pip fail"; exit -1; }

    # mv the current md5 to previous
    mv current.md5 previous.md5
fi

# now delete all .pyc files
find . -name "*.pyc" -exec rm {} \;
