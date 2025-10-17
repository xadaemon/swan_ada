#!/usr/bin/env sh

ADA_LIB_PATH=$(alr exec -- gnatls -v 2>&1 | grep adalib | xargs)
eval "$(alr printenv)"
echo "-L$ADA_LIB_PATH -lgnat -L$GPR_PROJECT_PATH/lib -LSwan"
