# TiddlyWiki5 on FlyIO

## Installation

- [Install FlyIO](https://fly.io/docs/flyctl/install/)[^NIX]

[^NIX]: I use [`nix`](https://github.com/DeterminateSystems/nix-installer) ...

    ```sh
    nix-shell -p flyctl
    ```

- Edit `fly.toml` for your domain name, region etc.

- Deploy

```sh
fly deploy
```

---

## Tutorials

See [JavaScript on Fly.io](https://fly.io/docs/js/)

---

## To Do

- [ ] [Access via WireGuard](https://fly.io/docs/blueprints/private-applications-flycast/)

---

## Footnotes
