# Yu Shao Pang — Platform Engineer Resume

[![Resume CI](https://github.com/yushao2/resume/actions/workflows/ci.yml/badge.svg)](https://github.com/yushao2/resume/actions/workflows/ci.yml)
[![PDF](https://img.shields.io/badge/resume-PDF-244A5A)](https://github.com/yushao2/resume/blob/deployments/resume.pdf)

Source for my one-page Platform Engineer resume, written in LaTeX and published automatically after validation.

## Build locally

Requirements:

- TeX Live with LuaLaTeX and `latexmk`
- `poppler-utils` for `pdfinfo` and `pdftotext`

```bash
make verify
```

`make verify` compiles the resume and checks that the result is a non-empty, one-page A4 PDF with extractable text and no LaTeX overfull-box warnings.

```bash
make clean
```

## CI/CD

The GitHub Actions workflow:

1. Builds and validates the PDF for pull requests and relevant pushes.
2. Uploads the validated PDF as a workflow artifact.
3. Deploys that exact artifact to the orphan `deployments` branch only after a successful build on `master`.
4. Uses least-privilege job permissions, path filtering, timeouts and concurrency cancellation.

Dependabot checks the GitHub Actions dependencies monthly.
