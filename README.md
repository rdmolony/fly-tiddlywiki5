# TiddlyWiki5 on FlyIO

## Deploy

- [Clone me](https://github.com/firstcontributions/first-contributions)

- Clone my submodules (so `TiddlyWiki5` is fetched too)

```sh
git submodule update --init --recursive
```

- [Install `flyctl`](https://fly.io/docs/flyctl/install/)[^NIX]

- (Optional) [Install `Node`](https://nodejs.org/en)[^NIX]

- Create `fly.toml`

```sh
sh example.fly.toml fly.toml
```

- Run ...

```sh
fly launch --no-deploy
```

... and accept the option to **"tweak the settings before proceeding"** to edit the configuration.

- Deploy

```sh
fly deploy
```

You should see -

![](./images/tiddlywiki-default-startup.png)


---


## Create a Wiki

This `TiddlyWiki` setup stores tiddlers as one file on disk per tiddler.

By default, `Fly` apps do not store files so every time the app restarts all tiddlers are lost.

To persist files, `Fly` recommends using either "volumes" or "object storage".

In any case, let's first create a scaffold.

- Create an empty scaffold

```sh
npx tiddlywiki ./tiddlers --init server
```

- Or [convert a pre-existing single `html` file to `Node`](https://talk.tiddlywiki.org/t/migration-from-single-html-file-to-node-js/3585)

```sh
tiddlywiki --load ./mywiki.html --savewikifolder ./tiddlers
```

### Volumes

If we specify ...

```toml
[[mounts]]
  source = 'tiddlywiki_data'
  destination = '/data'
```

... in `fly.toml` then `Fly` creates a new folder `/data` **after the app has been deployed**

If we want to copy our tiddlers to the app we can copy it via `sftp` ...

```sh
tar -cf tiddlers.tar tiddlers/
fly ssh sftp shell
put tiddlers.tar /data/tiddlers.tar
fly ssh console
cd /data
tar -xf tiddlers.tar
rm tiddlers.tar
```

`Fly` automatically backs up this volume via snapshots


---

## Authenticate

Add basic authentication by creating secrets (or environment variables) on the server ...

```sh
fly secrets set TWUSER="<username>"
fly secrets set TWPASS="<password>"
```

> [!NOTE]
> The `Dockerfile` startup command `node tiddlywiki.js /path/to/tiddlers --listen ...` instructs the `Node` server to use the environment variables `TWUSER` & `TWPASS` as credentials. Changing either environment variable will update the credentials.

---


## Auto-stop Server when Idle

Just add ...

```toml
[http_service]
  ...
  auto_stop_machines = true
  auto_start_machines = true
```

... to `fly.toml`


---


## Explore

- Launch a server

```sh
npx tiddlywiki ./TiddlyWiki5/editions/empty
```


---


## Tutorials

- [`JavaScript` on `Fly.io`](https://fly.io/docs/js/)
- [Add volume storage to a Fly Launch app](https://fly.io/docs/launch/volume-storage/) - to persist tiddlers on disk


---


## To Do

- [x] [Persist tiddlers via `Tigris`](https://fly.io/docs/reference/tigris/)[^TIGRIS]
- [ ] [Access via WireGuard](https://fly.io/docs/blueprints/private-applications-flycast/)

---

## Footnotes

[^NIX]: I use [`nix`](https://github.com/DeterminateSystems/nix-installer) ...

    ```sh
    # Via flakes which leverage `flake.nix` & `flake.lock` ...
    nix develop
    # ... or individually via ...
    nix-shell -p nodejs flyctl
    ```

[^TIGRIS]: I need a 3rd party library to watch the filesystem & sync it with an object store. Volumes work out of the box.
