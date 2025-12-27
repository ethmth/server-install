{ pkgs, ... }:

{
  home.file.".local/bin/nightlight" = {
    source = ./nightlight;
    executable = true;
  };
}
