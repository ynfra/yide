# yide — Agent Reference

In-browser IDE variants. Four self-hosted editors runnable via Docker Compose,
each on its own port. Use `yide.sh` to start a specific variant.

## Variants

| Variant      | Image                                        | Port | Auth                          |
|--------------|----------------------------------------------|------|-------------------------------|
| `codercom`   | `codercom/code-server:latest`                 | 3010 | none (`--auth none`)  |
| `linuxserver`| `lscr.io/linuxserver/code-server:latest`      | 3020 | none (no PASSWORD set)|
| `openvscode` | `lscr.io/linuxserver/openvscode-server:latest`| 3030 | none (no token set)   |
| `theia`      | `theiaide/theia:latest`                       | 3040 | none                  |

## Layout

```
yide/
  codercom/   docker-compose.yml  .gitignore
  linuxserver/ docker-compose.yml  .gitignore
  openvscode/  docker-compose.yml  .gitignore
  theia/       docker-compose.yml  .gitignore
  yide.sh      chooser script
  Makefile
```

Each variant is an isolated stack — its own `docker-compose.yml` and `.docker/` data dir.

## Usage

```bash
# Start a variant (detached)
./yide.sh codercom
./yide.sh openvscode

# Stop or tail logs
./yide.sh codercom down
./yide.sh theia logs

# Or run directly inside a variant dir
cd codercom && docker compose up -d
```

## Data persistence

Runtime state is written to `<variant>/.docker/` (gitignored). To reset a variant:

```bash
cd codercom && docker compose down && rm -rf .docker/
```

## Rules for Agents

1. Each variant is fully isolated — no shared networks or volumes between them.
2. Never commit `.docker/` or `.env` — gitignored per variant.
3. Port assignments are fixed: 3010 / 3020 / 3030 / 3040. Do not change them.
4. No auth is set by default — add a reverse proxy with auth for any public exposure.
