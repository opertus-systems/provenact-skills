# Architecture

## Scope

- Store signed, immutable skill bundles.
- Publish a lockfile with digests and signer expectations.
- Provide deterministic verification automation.

## Out of Scope

- Agent loops, planning, scheduling, memory.
- Runtime policy decisions at execution time.

## Trust Model

- `manifest.json` and `signatures.json` are the signed control plane for each bundle.
- `skills.lock.json` pins expected artifact hash, manifest hash, and trusted key-file digest.
- Verification is delegated to `inactu-cli` using pinned key material.
