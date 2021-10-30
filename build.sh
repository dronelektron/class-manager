#!/bin/bash

PLUGIN_NAME="class-manager"

spcomp scripting/$PLUGIN_NAME.sp scripting/modules/*.sp -i scripting/include -o plugins/$PLUGIN_NAME.smx
