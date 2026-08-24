# Create a Clink language pack

You are contributing one on-device language pack. Read `README.md`, inspect `build-pack.py`, `tools/validate-pack.py`, and the relevant files in `Lexicons/` before editing. Start with the smallest useful pack: a word list and its generated `.clex` dictionary. Do not hand-author binary pack files.

Choose a short lowercase language code; use an underscore for a regional variant (for example `pt_br`). Put source words in `source/<code>.txt`, one word per line, using legal and appropriately licensed data. Build and validate it:

```sh
python3 build-pack.py <code> source/<code>.txt
python3 tools/validate-pack.py <code>
```

Only add optional assets when the request and source data justify them: build a `.cngm` from genuine sentence data, use `.cime` only for reading-to-writing input methods, and add a neural model only with its matching vocabulary from the same training run. Keep every asset under `Lexicons/` and use the same code prefix. Never mix model and vocabulary files from different builds.

Do not change release tooling or fabricate a manifest. Run `./update.sh` only when explicitly asked to commit, tag, and publish. Finish by listing the generated assets, their source/licensing status, the commands run, and any optional capabilities deliberately omitted.
