#!/usr/bin/env bash

set -eux -o pipefail

builtin cd "$(dirname "${BASH_SOURCE[0]}")"

ARGS=()
FLAGS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        (--watch) FLAGS+=(-pvc) ;;
        (*) ARGS+=("$1") ;;
    esac
    shift
done

if [[ ${#ARGS[@]} -ne 1 ]]; then
    echo "Usage: $0 [--watch] <dir>" >&2
    exit 1
fi

DIR="${ARGS[0]}"
if [[ ! -d "${DIR}" ]]; then
    echo "Directory not found: ${DIR}" >&2
    exit 1
fi

OUTDIR="${DIR}/_out/"
mkdir -p "${OUTDIR}"

exec latexmk -pdf -outdir="${OUTDIR}" ${FLAGS+"${FLAGS[@]}"} "${DIR}/solution.tex"
