if $IS_WSL; then
  alias clip="clip.exe"

  export BROWSER="wslview"
  export LIBGL_ALWAYS_INDIRECT=1
elif [[ $OSTYPE == "linux-gnu"* ]]; then
  alias clip="wl-copy"
elif [[ $OSTYPE == "darwin"* ]]; then
  alias clip="pbcopy"
else
  echo "Unknown OS. No clip handler"
fi