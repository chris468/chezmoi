#!/usr/bin/env bash

mkdir -p ~/.local/share/chezmoi

cat > .local/share/chezmoi/.chezmoi.toml.tmpl <<EOF
{{- \$email := promptStringOnce . "email" "Email address" -}}

[data]
    email = {{ \$email | quote }}
EOF

echo ".local/share/chezmoi/.chezmoi.toml.tmpl contents:"
cat .local/share/chezmoi/.chezmoi.toml.tmpl
echo

curl -fsLS get.chezmoi.io | sh
export PATH="$HOME/bin:$PATH"

chezmoi --verbose execute-template --init --promptString email="me@home.org" < ~/.local/share/chezmoi/.chezmoi.toml.tmpl

chezmoi --verbose init --promptString email="me@home.org"
