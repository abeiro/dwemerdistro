# DwemerDistro Core

DwemerDistro provides the shared WSL runtime used by the Dwemer Dynamics game servers and optional voice, speech, and utility components.

Fresh distribution payloads do not include HerikaServer, StobeServer, or DialecticServer. Users choose the servers they want in the launcher Quickstart or install them later from Mods.

## Optional server manager

`bin/ddistro_server` is the supported lifecycle interface:

```bash
ddistro_server status all --json
ddistro_server install herika --branch main
ddistro_server update stobe --branch dev
ddistro_server repair dialectic --branch main
ddistro_server uninstall herika --confirm PURGE-HERIKA
```

Supported products are `herika`, `stobe`, and `dialectic`. Supported branch channels are `main` and `dev`; the manager maps them to each repository's actual production and development branch.

Uninstall permanently removes only the selected server's canonical files, retained manager backups, Apache site, runtime processes, and PostgreSQL database. It does not remove shared components or another server's data.

`update_gws` updates only servers that are already installed. A missing server is skipped and is never installed as an update side effect. `start_env` similarly starts and reports only installed servers.

## System release version

`system-release.json` is the release signal for DwemerDistro core and shared components. Increment its semantic version whenever users need to run **Update System** for a core or shared-component release.

The launcher compares this published version with `/var/lib/dwemerdistro/system-release.json`. It replaces the installed marker only after the core update and shared-component update both succeed, so an interrupted or failed update remains visible to the user.

The legacy `.version.txt` file remains unchanged for older launchers and is not the authoritative system-release version.

## Distribution payload rule

Release payloads must report all three products as `not-installed` with no application databases. Build and validate them with the installer repository's `scripts/Prepare-EmptyDistroPayload.ps1`; do not distribute a tar exported directly from a development distro.
