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

### Create a repository

1. Create a public GitHub repository with a `Lexicons/` directory.
2. Add a compiled `<language-code>.clex` file for every language you publish. Use short, lowercase codes, with `_` for regional codes such as `pt_br`.
3. Add optional files beside it when you have them: `.cngm`, `.lmvocab`, `.bpevocab`, `.mlmodelc`, and `.cime`.
4. Copy the release workflow from [this repository](.github/workflows/release.yml). It records every file's byte count and SHA-256 hash, then publishes the manifest and assets together.
5. Push a version tag beginning with `v`, for example `v2026.09.01`. GitHub Actions publishes:

   ```text
   https://github.com/OWNER/REPOSITORY/releases/latest/download/manifest.json
   ```

6. In Clink, open **General → Repositories**, add `https://github.com/OWNER/REPOSITORY`, then visit **Languages** to find its packs under **Community**.

### What Clink verifies

Clink only accepts public HTTPS GitHub release manifests. It derives the manifest address from the repository URL, so a repository cannot point the app at an unrelated host. Every download must come from that same GitHub repository's release, use an approved language-pack file type, stay within size limits, match the manifest's byte count, and match its SHA-256 hash.

Files are downloaded into a staging directory. Clink activates a pack only after every file has passed verification and the required `.clex` file exists. If a release fails at any point, the previous verified pack remains active.

Adding a repository is still a trust decision. Only add repositories run by people or communities you trust to publish language data.
