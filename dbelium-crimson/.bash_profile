#
# ~/.bash_profile
#

# PATH variables
export PATH=/usr/share/dotnet:$PATH

# Add .NET Core SDK tools
export PATH="$PATH:/home/dbeliq/.dotnet/tools"

export TERMINAL=alacritty

[[ -f ~/.bashrc ]] && . ~/.bashrc

[[ $(fgconsole 2>/dev/null) == 1 ]] && exec startx -- vt1
