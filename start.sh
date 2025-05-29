#!/bin/sh

/app/tailscaled --state=/var/lib/tailscale/tailscaled.state --socket=/var/run/tailscale/tailscaled.sock &
/app/tailscale up --auth-key=${TAILSCALE_AUTHKEY} --hostname=fly-app

npx tiddlywiki /data/tiddlers/ --listen host=0.0.0.0 port=3000 username=$TWUSER password=$TWPASS root-tiddler=$:/core/save/lazy-images
