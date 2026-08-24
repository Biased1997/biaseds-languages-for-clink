[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

# Publish a new immutable language-pack release from the assets in Lexicons/.
Set-Location -LiteralPath $PSScriptRoot

$branch = (& git branch --show-current).Trim()
if ($LASTEXITCODE -ne 0) {
    throw 'Could not determine the current Git branch.'
}

if ([string]::IsNullOrWhiteSpace($branch)) {
    throw 'Cannot publish from a detached HEAD.'
}

& git add -A
if ($LASTEXITCODE -ne 0) {
    throw 'Failed to stage changes.'
}

& git diff --cached --quiet
if ($LASTEXITCODE -eq 1) {
    & git commit -m 'Update language packs'
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to commit staged changes.'
    }
} elseif ($LASTEXITCODE -ne 0) {
    throw 'Failed to inspect staged changes.'
}

$tag = 'v' + [DateTime]::UtcNow.ToString('yyyy.MM.dd.HHmmss')
$suffix = 1
while ($true) {
    & git rev-parse -q --verify "refs/tags/$tag" *> $null
    if ($LASTEXITCODE -ne 0) {
        break
    }

    $tag = ('v{0}.{1}' -f [DateTime]::UtcNow.ToString('yyyy.MM.dd.HHmmss'), $suffix)
    $suffix++
}

& git tag $tag
if ($LASTEXITCODE -ne 0) {
    throw "Failed to create tag $tag."
}

& git push origin "HEAD:refs/heads/$branch" "refs/tags/$tag"
if ($LASTEXITCODE -ne 0) {
    throw 'Failed to push the branch and tag.'
}

Write-Host "Published $tag"
