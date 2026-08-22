<p align="center">
  <img src="icon-1024.png" width="96" alt="Clink app icon">
</p>

<h1 align="center">Clink Language Packs</h1>

<p align="center">Open language resources for Clink keyboards.</p>

Clink ships English in the app, then downloads the languages you choose. A pack contains its lexicon, prediction data, and where available its neural model or input-method tables. Everything stays on the device once installed.

## Supported languages

| | | |
|---|---|---|
| 🇿🇦 Afrikaans | 🇸🇦 Arabic | 🇦🇲 Armenian |
| 🇧🇬 Bulgarian | 🇨🇳 Chinese | 🇭🇷 Croatian |
| 🇨🇿 Czech | 🇳🇱 Dutch | 🇺🇸 English |
| 🇪🇪 Estonian | 🇫🇷 French | 🇩🇪 German |
| 🇬🇷 Greek | 🇮🇳 Hindi | 🇭🇺 Hungarian |
| 🇮🇩 Indonesian | 🇮🇹 Italian | 🇯🇵 Japanese |
| 🇰🇷 Korean | 🇱🇺 Luxembourgish | 🇱🇹 Lithuanian |
| 🇲🇾 Malay | 🇲🇽 Mexican Spanish | 🇳🇵 Nepali |
| 🇨🇼 Papiamento | 🇵🇱 Polish | |
| 🇵🇹 Portuguese | 🇧🇷 Brazilian Portuguese | 🇷🇴 Romanian |
| 🇷🇺 Russian | 🇷🇸 Serbian | 🇪🇸 Spanish |
| 🇹🇷 Turkish | 🇺🇦 Ukrainian | 🇻🇳 Vietnamese |

## Make your first pack

You do **not** need to understand machine learning, binary files, or GitHub releases to publish a useful language. Start with the dictionary. It is the only required asset.

1. Fork this repository. Name your copy something clear, such as `toki-pona-clink`.
2. Create `source/tok.txt`. `tok` is the language code used everywhere below. Use short lowercase codes. Regional variants use an underscore, such as `pt_br`.
3. Put one word on each line. This is a complete, valid starting list:

   ```text
   jan
   pona
   suli
   toki
   ```

4. In the repository folder on your Mac, run:

   ```sh
   python3 build-pack.py tok source/tok.txt
   python3 tools/validate-pack.py tok
   ```

   You now have `Lexicons/tok.clex`. That is Clink's compact dictionary. You never write a `.clex` file yourself.
5. Run `./update.sh` when you are ready to publish. It commits your changes, creates a version tag, and pushes it. GitHub Actions builds the release manifest, calculates every SHA-256 hash and file size, then publishes the files.
6. In Clink, open **General → Repositories**, add your public GitHub URL, then visit **Languages**. Your language appears under **Community**.

That is enough to ship. Add the optional assets below only when you have the data and a reason to use them.

## Which files do I need?

| File | What it gives people | Do I need it? |
|---|---|---|
| `<code>.clex` | Dictionary words, completions, spelling help | Yes |
| `<code>.cngm` | Better next-word suggestions from real sentences | Recommended when you have a sentence corpus |
| `<code>.bpevocab` + `<code>.mlmodelc` | Neural ranking that uses more of the sentence context | Optional and advanced |
| `<code>.cime` | Reading-to-character conversion, such as Pinyin → Hanzi | Only for an IME language |

Everything lives in `Lexicons/`. The filename must begin with the same code: a Japanese pack uses `ja.clex`, `ja.cngm`, and, if applicable, `ja.cime`.

## Add next-word prediction

A dictionary knows individual words. A next-word model learns that after “thank” people often type “you”. It needs real sentences, not a list of isolated words.

1. Create `source/tok.sentences.txt` and put one complete sentence on each line. Punctuation is fine.

   ```text
   jan li toki.
   mi toki e toki pona.
   sina pona.
   ```

2. Run this exact command:

   ```sh
   python3 tools/build-next-word.py tok source/tok.txt source/tok.sentences.txt
   python3 tools/validate-pack.py tok
   ```

It makes `Lexicons/tok.cngm`. The tool only includes pairs made from words already in `source/tok.txt`, which keeps the model matched to its dictionary. Use a corpus you are allowed to redistribute or process. More varied, natural sentences make better suggestions.

## Add an input method table

Use this only when people type a phonetic reading and choose a different written form. Japanese kana-to-Kanji and Chinese Pinyin-to-Hanzi are the common examples. It is not needed for ordinary alphabetic languages.

1. Create `source/ja-ime.tsv`. Each line is a reading, followed by one or more choices. Press the **Tab** key between columns, not spaces. Put the most likely choice first.

   ```text
   とうきょう	東京
   かんじ	漢字	感じ
   ```

2. Build it:

   ```sh
   python3 tools/build-ime-table.py ja source/ja-ime.tsv
   python3 tools/validate-pack.py ja
   ```

This makes `Lexicons/ja.cime`. Clink shows at most the first 16 choices per reading, in the order you give them.

## Add a neural model

This is optional. Do it only after the dictionary and `.cngm` model feel good. Training needs a Mac, Xcode command-line tools, Python 3, a large sentence corpus, free disk space, and usually hours of processing. The output is two matching assets: the compiled Core ML model folder and its vocabulary. Never copy a vocabulary from one training run beside a model from another.

1. Put one sentence per line in `source/tok_sentences.tsv`. The filename has an underscore here because it is the neural trainer's convention. The file can be plain sentences; a Tatoeba-style tab-separated export also works because the final column is treated as the sentence.
2. Install the training requirements once:

   ```sh
   python3 -m pip install torch coremltools
   ```

3. Train a small test model first. This checks your setup without waiting for the entire corpus:

   ```sh
   python3 tools/train-neural.py --lang tok --bpe 8000 --epochs 1 --max-lines 10000
   ```

4. When that succeeds, train the real model. `12000` is a sensible choice for a large corpus; `8000` is safer for a small one.

   ```sh
   python3 tools/train-neural.py --lang tok --bpe 12000 --epochs 3
   python3 tools/validate-pack.py tok
   ```

The tool writes `Lexicons/tok.mlmodelc/` and `Lexicons/tok.bpevocab`. Keep both. Do not rename, edit, or mix them. If the training step is too much for your project, skip it: Clink still works with the dictionary and next-word model.

## Community repositories

Community language repositories are for languages that Clink does not maintain itself, including conlangs and regional projects. Clink never bundles, recommends, or silently adds them. Someone chooses a repository in the app, then chooses which of its languages to install.

### What Clink verifies

Clink only accepts public HTTPS GitHub release manifests. It derives the manifest address from the repository URL, so a repository cannot point the app at an unrelated host. Every download must come from that same GitHub repository's release, use an approved language-pack file type, stay within size limits, match the manifest's byte count, and match its SHA-256 hash.

Files are downloaded into a staging directory. Clink activates a pack only after every file has passed verification and the required `.clex` file exists. If a release fails at any point, the previous verified pack remains active.

Adding a repository is still a trust decision. Only add repositories run by people or communities you trust to publish language data.
