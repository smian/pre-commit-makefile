#!/usr/bin/env bash

cd ../

./makefile-doc.sh test/.

# Test if output from 'make help' was inserted
if grep -qc "\<install\>" test/README.md
then
   echo "SUCCESS: Found 'install' string in README.md"
   exit 0;
else
   echo "FAIL: Did not find 'install' string in README.md"
   exit 1;
fi
