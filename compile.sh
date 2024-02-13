#!/usr/bin/env bash

set -eux -o pipefail

builtin cd "$(dirname "${BASH_SOURCE[0]}")"

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <dir>" >&2
    exit 1
fi

DIR="${1}"
if [[ ! -d "${DIR}" ]]; then
    echo "Directory not found: ${DIR}" >&2
    exit 1
fi

OUTDIR="${DIR}/_out/"
mkdir -p "${OUTDIR}"

exec pdflatex -output-directory="${OUTDIR}" "${DIR}/solution.tex"
