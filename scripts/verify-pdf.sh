#!/usr/bin/env bash
set -euo pipefail

pdf="${1:-resume.pdf}"
log="${2:-resume.log}"

for command in pdfinfo pdftotext; do
  command -v "$command" >/dev/null 2>&1 || {
    echo "Required command not found: $command" >&2
    exit 1
  }
done

[[ -s "$pdf" ]] || {
  echo "PDF was not created or is empty: $pdf" >&2
  exit 1
}

info="$(pdfinfo "$pdf")"
pages="$(awk '/^Pages:/ {print $2}' <<<"$info")"
[[ "$pages" == "1" ]] || {
  echo "Resume must remain one page; generated PDF has ${pages:-unknown} pages." >&2
  exit 1
}

grep -Fq '(A4)' <<<"$info" || {
  echo "Resume must be rendered on A4 paper." >&2
  exit 1
}

text_file="$(mktemp)"
trap 'rm -f "$text_file"' EXIT
pdftotext -layout "$pdf" "$text_file"

required_text=(
  'Yu Shao Pang'
  'Platform Engineer'
  'Capula Investment Management'
  'Squarepoint Capital'
  'GovTech Singapore'
  'Nanyang Technological University'
)

for text in "${required_text[@]}"; do
  grep -Fq "$text" "$text_file" || {
    echo "PDF text extraction is missing expected text: $text" >&2
    exit 1
  }
done

if [[ -f "$log" ]] && grep -Eq 'Overfull \\[hv]box' "$log"; then
  echo "LaTeX reported an overfull box; inspect $log before publishing." >&2
  grep -E 'Overfull \\[hv]box' "$log" >&2 || true
  exit 1
fi

echo "Validated $pdf: one-page A4 PDF with clean text extraction."
