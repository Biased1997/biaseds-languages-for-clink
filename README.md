<p align="center">
  <img src="https://raw.githubusercontent.com/anti-ltd/Clink-iOS/main/Resources/Assets.xcassets/AppIcon.appiconset/icon-1024.png" width="96" alt="Clink app icon">
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

## What is in a pack?

Every language has a `.clex` lexicon. Packs can also include a `.cngm` next-word model, neural vocabularies and model files, or a `.cime` input method table. The release workflow builds one immutable release, writes a manifest, and publishes every file needed by that manifest.

## Community repositories

Community language repositories are for languages that Clink does not maintain itself, including conlangs and regional projects. Clink never bundles, recommends, or silently adds them. Someone chooses a repository in the app, then chooses which of its languages to install.

### Before you start

You do **not** write a `.clex` file by hand. It is Clink's compact dictionary format. Start with the thing you probably already have: a plain UTF-8 word list. Put one word on each line, or use `word<TAB>frequency` when you know which words are more common.

The pack builder turns that list into the `.clex` file Clink reads. A next-word model, neural model, and input-method table are all optional. A good first community pack is just a clean word list and its compiled dictionary.

### Publish your first language

1. Create a public GitHub repository. Give it a clear name such as `toki-pona-clink`.
2. Add your source word list to the repository. Keep it human-readable, so your community can review and improve it.
3. Run the Clink pack builder for your language. It creates `<language-code>.clex` in `Lexicons/`. Language codes are short and lowercase. Use `_` for a regional code such as `pt_br`.
4. Copy the release workflow from [this repository](.github/workflows/release.yml). The workflow gathers the compiled files, records each file's byte count and SHA-256 hash, then publishes the manifest and assets together.
5. Push a version tag beginning with `v`, for example `v2026.09.01`. GitHub Actions publishes:

   ```text
   https://github.com/OWNER/REPOSITORY/releases/latest/download/manifest.json
   ```

6. In Clink, open **General → Repositories**, add `https://github.com/OWNER/REPOSITORY`, then visit **Languages** to find its packs under **Community**.

If you only have a word list today, that is enough to begin. Do not worry about neural models or prediction corpora until the basic dictionary feels good.

### What Clink verifies

Clink only accepts public HTTPS GitHub release manifests. It derives the manifest address from the repository URL, so a repository cannot point the app at an unrelated host. Every download must come from that same GitHub repository's release, use an approved language-pack file type, stay within size limits, match the manifest's byte count, and match its SHA-256 hash.

Files are downloaded into a staging directory. Clink activates a pack only after every file has passed verification and the required `.clex` file exists. If a release fails at any point, the previous verified pack remains active.

Adding a repository is still a trust decision. Only add repositories run by people or communities you trust to publish language data.
