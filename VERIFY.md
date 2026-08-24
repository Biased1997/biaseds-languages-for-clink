# Verify this Clink language-packs repository

Read `README.md`, `PROMPT.md`, `build-pack.py`, `tools/validate-pack.py`, and inspect `source/` and `Lexicons/`. Audit without editing unless asked to fix a finding.

Identify every language code represented by `Lexicons/` and run:

```sh
python3 tools/validate-pack.py <code>
```

for each code. Every pack must have the required `<code>.clex` dictionary. Confirm source word lists are one word per line where present, codes are lowercase (with `_` only for regional variants), and generated binary assets were not hand-authored. Optional `.cngm`, `.cime`, `.bpevocab`, and `.mlmodelc` files must share the code prefix; IME tables must be appropriate for reading-to-writing input; and neural models must have the matching vocabulary from the same training run. Check that all source data has a stated or otherwise verifiable lawful licence/provenance.

Also confirm release tooling is unchanged and no fabricated manifest or unrelated binary has been added. Report every code checked, commands and results, asset completeness, provenance/licensing gaps, and exact paths for any failures. Do not run `./update.sh`, commit, tag, or publish.
