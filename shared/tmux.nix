{ pkgs, ...}:
{
  programs.tmux = {
    enable = true;
    terminal = "tmux-direct";
    extraConfigBeforePlugins = ''
      set -g @catppuccin_flavor "mocha"
    '';
    plugins = with pkgs; [
      tmuxPlugins.catppuccin
    ];
    extraConfig = ''
      set -g mouse on
      set-option -sa terminal-overrides ",xterm-256color:Tc"
      set-option -ga terminal-features ",xterm-256color:RGB"
    '';
  };
}
