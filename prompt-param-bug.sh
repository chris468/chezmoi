#!/usr/bin/env bash

mkdir -p ~/.local/share/chezmoi

cat > .local/share/chezmoi/.chezmoi.toml.tmpl <<EOF
{{- \$email := promptStringOnce . "email" "Email address" -}}

[data]
    email = {{ \$email | quote }}
EOF

curl -fsLS get.chezmoi.io | sh
export PATH="$HOME/bin:$PATH"

chezmoi execute-template --init --promptString email="me@home.org" < ~/.local/share/chezmoi/.chezmoi.toml.tmpl

chezmoi init --promptString email="me@home.org"
