# yide — in-browser IDE variants

Four self-hosted web IDEs, each an isolated Docker Compose stack on its
own fixed port. Pick one, start it, open it in the browser.

| Variant       | Image                                              | URL                    |
|---------------|----------------------------------------------------|------------------------|
| `codercom`    | `codercom/code-server`                             | http://localhost:3010  |
| `linuxserver` | `lscr.io/linuxserver/code-server`                  | http://localhost:3020  |
| `openvscode`  | `lscr.io/linuxserver/openvscode-server`            | http://localhost:3030  |
| `theia`       | `ghcr.io/eclipse-theia/theia-ide/theia-ide`        | http://localhost:3040  |

## Quick start

```bash
./yide.sh codercom          # start (detached), prints the URL
./yide.sh codercom logs     # tail logs
./yide.sh codercom down     # stop
```

Or run a variant directly:

```bash
cd openvscode && docker compose up -d
```

## Data persistence

Each variant writes its runtime state (settings, extensions, workspace)
to its own gitignored `<variant>/.docker/` directory. Reset a variant
with:

```bash
cd codercom && docker compose down && rm -rf .docker/
```

## Security

All variants run **without authentication** — they are meant for local
use. Put a reverse proxy with auth in front before exposing any of them
beyond localhost.

See `AGENTS.md` for the full variant reference and contributor rules.
