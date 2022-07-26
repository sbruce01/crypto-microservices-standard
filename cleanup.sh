#!/bin/bash

BASE_DIRECTORY=$(cd $(dirname $0) && pwd)

rm ${BASE_DIRECTORY}/kdb-tick/data/tplogs/*
rm -r -v ${BASE_DIRECTORY}/data/db/*
rm -r -v ${BASE_DIRECTORY}/data/tplogs/*
