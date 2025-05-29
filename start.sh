#!/bin/sh

npx tiddlywiki /data/tiddlers/ --listen host=0.0.0.0 port=3000 username=$TWUSER password=$TWPASS root-tiddler=$:/core/save/lazy-images
