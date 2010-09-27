#!/bin/sh
killall synergyc
killall ssh
ssh -f -N -L localhost:24800:mjbk.csn.tu-chemnitz.de:24800 mjbk.csn.tu-chemnitz.de
synergyc -f localhost
