#!/bin/sh

mc config host add dev http://minio:9000 secret secretsecret
mc mb --ignore-existing dev/public
mc policy public dev/public
