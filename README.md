# TiddlyWiki5 on FlyIO

## Installation

- [Clone me](https://github.com/firstcontributions/first-contributions)

- Clone my submodules (so `TiddlyWiki5` is fetched too)

```sh
git submodule update --init --recursive
```

- [Install `flyctl`](https://fly.io/docs/flyctl/install/)[^NIX]

- (Optional) [Install `Node`](https://nodejs.org/en)[^NIX]

- Edit `fly.toml` for your domain name, region etc.

- Deploy

```sh
fly deploy
```

---

## Explore

- Install `Node` dependencies

```sh
cd TiddlyWiki5
npm install
```

- Launch a server

```sh
node ./tiddlywiki.js ./editions/empty
```

---

## Tutorials

See [JavaScript on Fly.io](https://fly.io/docs/js/)

---

## To Do

- [ ] [Access via WireGuard](https://fly.io/docs/blueprints/private-applications-flycast/)

---

## Footnotes

[^NIX]: I use [`nix`](https://github.com/DeterminateSystems/nix-installer) ...

    ```sh
    # Via flakes ...
    nix develop
    # ... or individually via ...
    nix-shell -p nodejs flyctl
    ```
