# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; 
then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ];
then
    PATH="$HOME/.cargo/bin:$PATH"
fi

export PATH
export MOZ_USE_XINPUT2=1
