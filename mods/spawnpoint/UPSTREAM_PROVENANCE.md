# SpawnPoint provenance

This directory incorporates the public `octacian/spawnpoint` Luanti mod:

- Source: <https://github.com/octacian/spawnpoint>
- Upstream commit: `e428ced` (latest upstream fix at integration time)
- Copyright: Elijah Duffy (2017)
- License: MIT, preserved verbatim in `LICENSE`

The source and media are retained under the upstream MIT terms. StelluAsuna
adds `mod.conf` metadata for game packaging and fixes the upstream
`type(player) == string` typo in the teleport helper; no upstream license text
or copyright notice has been removed. It also queues the configured spawn
teleport after respawn callbacks so StelluAsuna's static point takes priority
over optional bed-spawn integrations.
