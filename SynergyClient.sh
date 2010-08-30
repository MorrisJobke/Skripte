#!/bin/sh
ssh -f -N -L localhost:24800:mjbk.csn.tu-chemnitz.de:24800 mjbk.csn.tu-chemnitz.de
synergyc -f localhost
