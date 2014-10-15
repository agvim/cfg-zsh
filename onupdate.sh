#!/bin/bash
# pull prezto
currdir=`pwd`
cd $HOME/.zprezto && git pull origin master
cd $currdir
