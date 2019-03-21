---
category: Bash Style
---
# Bash Style

Where possible, we want to be consistent with our use of Bash so engineers switching betwen projects

## Do Use

These are practises we encourage

### Use `#!/usr/bin/env`

This makes  the shell more portable, not everyone has their bash shell under

```bash
#!/bin/bash
```

Allowing env to control this is preferred.

### set

On the second line of your Bash file set any bash modes you require e.g.

```bash
#!/usr/bin/env bash
set -eu
```

## Do Not Use

These are syntax or stlye recommendations to *avoid*

### `set -x`

The use of `-x` makes output, espeically in CI unreadable. It is only recommended for use when debugging.

## Set on the shebang

The following isn't as readable, and purely for stlye.

```bash
#!/usr/bin/env bash -e
```
