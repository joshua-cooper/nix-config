{
  programs.tmux = {
    enable = true;
    sensibleOnTop = true;
    baseIndex = 1;
    escapeTime = 16;
    historyLimit = 100000;
    keyMode = "vi";
    prefix = "C-Space";
    terminal = "tmux-256color";
    extraConfig = ''
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ag terminal-overrides ",alacritty:RGB"

      set -g status-keys emacs
      set -g status-left "[#{=18:session_name}] "
      set -g status-left-length 21
      set -g status-right ""
      set -g mouse on
      set -g renumber-windows on
      set -g set-titles on

      bind s choose-tree -sZO time
      bind b set status
      bind -r P swap-window -t -1 \; select-window -t -1
      bind -r N swap-window -t +1 \; select-window -t +1
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"
    '';
  };
}
