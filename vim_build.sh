#! /bin/bash

./configure \
 --enable-multibyte \
 --with-features=huge \
 --enable-luainterp \
 --enable-pythoninterp \
 --with-python-config-dir=/usr/lib64/python2.6/config \
 --enable-rubyinterp \
 --with-ruby-command=/usr/bin/ruby \
 --enable-terminal \

 make clean

 make

