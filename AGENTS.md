# yide — Agent Reference

In-browser IDE variants. Four self-hosted editors runnable via Docker Compose,
each on its own port. Use `yide.sh` to start a specific variant.

## Variants

| Variant      | Image                                        | Port | Auth                          |
|--------------|----------------------------------------------|------|-------------------------------|
| `codercom`   | `codercom/code-server:latest`                | 3010 | password (`coder`)            |
| `linuxserver`| `lscr.io/linuxserver/code-server:latest`     | 3020 | password (`coder`)            |
| `openvscode` | `lscr.io/linuxserver/openvscode-server:latest`| 3030 | token in URL (`?tkn=coder`)  |
| `theia`      | `theiaide/theia:latest`                      | 3040 | none                          |

## Usage

```bash
# Start a specific variant (detached)
./yide.sh codercom
./yide.sh openvscode

# Stop or tail logs
./yide.sh codercom down
./yide.sh theia logs

# Start all variants at once
docker compose up -d
# or
make docker-up
```

## Data persistence

Runtime state is written to `.docker/<variant>/` (gitignored). To reset a variant:

```bash
docker compose stop codercom && docker compose rm -f codercom
rm -rf .docker/codercom/
```

## Rules for Agents

1. All four variants are independent — do not add cross-service dependencies.
2. Never commit `.docker/` or `.env` — they are gitignored.
3. Port assignments are fixed: 3010 / 3020 / 3030 / 3040. Do not change them.
4. Passwords and tokens in `docker-compose.yml` are sandbox defaults — not for production.
