if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Machine-local overrides
if [ -f "$HOME/.profile.local" ]; then
    . "$HOME/.profile.local"
fi
