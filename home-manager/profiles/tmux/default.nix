{
  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
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
      set -g status-right '#(git -C #{pane_current_path} rev-parse --abbrev-ref HEAD)'
      set -g mouse on
      set -g renumber-windows on
      set -g set-titles on
      set -g focus-events on

      bind s choose-tree -sZO time
      bind b set status
      bind -r P swap-window -t -1 \; select-window -t -1
      bind -r N swap-window -t +1 \; select-window -t +1
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind -n M-H swap-pane -s "{left-of}"
      bind -n M-J swap-pane -s "{down-of}"
      bind -n M-K swap-pane -s "{up-of}"
      bind -n M-L swap-pane -s "{right-of}"
    '';
  };
}
