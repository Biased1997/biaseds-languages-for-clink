#!/usr/bin/env python3
"""Build a Clink .cime input-method table from a simple tab-separated file.

Usage: python3 tools/build-ime-table.py ja source/ja-ime.tsv
Input: one reading, then one or more candidates, separated with TABs.
"""
import pathlib
import sys
import unicodedata

if len(sys.argv) != 3:
    raise SystemExit("Usage: python3 tools/build-ime-table.py <code> <readings.tsv>")
code, source = sys.argv[1], pathlib.Path(sys.argv[2])
if not code or not code.replace("_", "").replace("-", "").isalnum():
    raise SystemExit("Use a short language code such as ja or zh.")

rows = {}
for number, raw in enumerate(source.read_text(encoding="utf-8").splitlines(), 1):
    if not raw.strip() or raw.lstrip().startswith("#"): continue
    fields = [unicodedata.normalize("NFC", part.strip()) for part in raw.split("\t")]
    reading, candidates = fields[0].lower(), [value for value in fields[1:] if value]
    if not reading or not candidates:
        raise SystemExit(f"Line {number}: write a reading, then at least one candidate, separated by TABs.")
    # Keep the first occurrence of a candidate while preserving the author’s
    # order, because the keyboard shows earlier candidates first.
    rows[reading] = list(dict.fromkeys(candidates))[:16]

if not rows: raise SystemExit("No usable input-method rows found.")
destination = pathlib.Path("Lexicons") / f"{code}.cime"
destination.parent.mkdir(exist_ok=True)
with destination.open("w", encoding="utf-8", newline="\n") as output:
    for reading in sorted(rows): output.write("\t".join([reading, *rows[reading]]) + "\n")
print(f"Built {destination} with {len(rows):,} readings.")
