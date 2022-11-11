#!/bin/bash
# pull prezto
currdir=`pwd`
cd $HOME/.config/zsh/.zprezto && git pull origin master
cd $currdir
