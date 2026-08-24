# ynfra / yide

Four self-hosted in-browser IDEs, each an isolated Docker Compose stack on its
own fixed port. Pick one, start it, open it in the browser.

## Usage

```bash
./yide.sh codercom          # start (detached), prints the URL
./yide.sh codercom logs     # tail logs
./yide.sh codercom down     # stop

cd openvscode && docker compose up -d    # or run a variant directly
```

## Variants

| Variant | URL | Image |
|---|---|---|
| `codercom` | http://localhost:3010 | `codercom/code-server` |
| `linuxserver` | http://localhost:3020 | `lscr.io/linuxserver/code-server` |
| `openvscode` | http://localhost:3030 | `lscr.io/linuxserver/openvscode-server` |
| `theia` | http://localhost:3040 | `ghcr.io/eclipse-theia/theia-ide/theia-ide` |

## Notes

- All variants run **without authentication** — meant for local use; put a
  reverse proxy with auth in front before exposing any of them beyond
  localhost.
- Runtime state (settings, extensions, workspace) lives in each variant's
  gitignored `.docker/` dir — reset with
  `cd <variant> && docker compose down && rm -rf .docker/`.

See [AGENTS.md](AGENTS.md) for the full variant reference and contributor
rules.
