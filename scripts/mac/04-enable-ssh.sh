#!/bin/bash

sudo systemsetup -setremotelogin on
systemsetup -getremotelogin


ifconfig | grep "inet " | grep -v 127.0.0.1
