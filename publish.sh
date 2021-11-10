#!/usr/bin/env sh

VERSION=$(git describe --exact-match --abbrev=0 --tags)
TITLE=$(cat document.yaml | yq ".title" | sed 's/"//g')
DOCUMENT="${TITLE}-${VERSION}.pdf"
TAG="${VERSION}"
DOCUMENT_URL="https://github.com/${GITHUB_REPOSITORY}/releases/tag/${VERSION}"

_error(){
  echo "[ error ]: $@"
  exit 1
}

_release(){
  export GITHUB_TOKEN="${INPUT_GH_TOKEN}"
  gh release create "${VERSION}" --title "${VERSION}"  "${DOCUMENT}"
}

_build(){
  qrencode "$DOCUMENT_URL" -o assets/img/qrcode.png -s 4 -m 0
  mkdoc --tag="${TAG}" || _error "could not produce html!"
  weasyprint document.html "${DOCUMENT}" || _error "could not produce document!"
}

_build
_release

