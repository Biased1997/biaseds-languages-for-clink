# Clink language packs

Language resources for Clink’s downloadable keyboards.

## Covered languages

Afrikaans, Arabic, Bulgarian, Czech, German, Greek, English, Spanish,
Mexican Spanish, Estonian, French, Hindi, Croatian, Hungarian, Armenian,
Indonesian, Italian, Japanese, Korean, Luxembourgish, Lithuanian, Malay,
Nepali, Dutch, Papiamento, Polish, Portuguese, Brazilian Portuguese, Romanian,
Russian, Serbian, Turkish, Ukrainian, Vietnamese, and Chinese.

Releases contain the prediction data used by each language: lexicons, n-gram
models, neural-language-model vocabularies and models where available, and IME
tables. Clink keeps English in the initial app download and retrieves the rest
as needed.

Every release includes a manifest with file sizes and SHA-256 hashes. Packs are
verified before becoming available to the keyboard.

## Community repositories

Any public GitHub repository can publish language packs for Clink. Keep the
same `Lexicons/` layout and release workflow used here: each release must expose
`manifest.json` at `releases/latest/download/manifest.json`, with every asset's
SHA-256 hash and byte count. Clink accepts only HTTPS GitHub release manifests;
all assets must come from that same repository, use approved language-pack file
types, and pass verification before installation.

In Clink, open **General → Repositories**, add the repository's GitHub URL, and
choose the languages to download. Community repositories are never bundled or
recommended by Clink; adding one is an explicit trust decision by the user.
