{ pkgs, ... }:

let
  window-names = pkgs.writeShellScriptBin "window-names" ''
    case "$1" in
      sh | bash | zsh | fish) echo  ;;
      tmux) echo  ;;
      git) echo  ;;
      vi | vim | nvim) echo  ;;
      docker | docker-compose | podman) echo  ;;
      cargo | cargo-* ) echo  ;;
      node) echo  ;;
      *) echo "$1" ;;
    esac
  '';

  tf = pkgs.writeShellScriptBin "tf" ''
    project=$(cat ~/projects | ${pkgs.fzf}/bin/fzf --reverse)

    [ -z "$project" ] && exit 1

    session=$(echo "$project" | cut -d " " -f 1 | sed "s/\.\|:/_/g")
    dir=$(echo "$project" | cut -d " " -f 2)
    repo=$(echo "$project" | cut -d " " -f 3)

    if [ ! -d "$dir" ]; then
      mkdir -p "$dir" || exit 1
    fi

    if ! tmux has -t "=$session" 2> /dev/null; then
      tmux new -d -s "$session" -c "$dir"
    fi

    if [ -n "$repo" ] && [ -z "$(ls -A "$dir")" ]; then
      tmux new-window -n "clone" -t "$session" git clone --recurse-submodules -j8 "$repo" "$dir"
    fi

    if [ -z "$TMUX" ]; then
      tmux attach -t "$session" > /dev/null
    else
      tmux switch -t "$session"
    fi
  '';
in
{
  home.packages = [ tf ];

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
      set -g mouse on
      set -g renumber-windows on
      set -g set-titles on
      set -g set-clipboard on
      set -g focus-events on
      set -g detach-on-destroy off

      set -g status-interval 2
      set -g status-style "bg=default"

      set -g status-left-length 20
      set -g status-left "#[fg=default,bold]#S "

      set -g status-right-length 20
      set -g status-right "#[fg=default,bold]#(git -C #{pane_current_path} rev-parse --abbrev-ref HEAD)"

      set -g popup-border-lines rounded

      # set -g automatic-rename-format "#(${window-names}/bin/window-names #{pane_current_command})"

      bind s choose-tree -sZO time
      bind b set status
      bind -r P swap-window -t -1 \; select-window -t -1
      bind -r N swap-window -t +1 \; select-window -t +1
      bind '"' split-window -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      bind -n M-p popup -E -w 90% -h 75% -T "#[align=centre] Project " "${tf}/bin/tf"

      bind -n M-l switch -l

      bind -n M-1 select-window -t 1
      bind -n M-2 select-window -t 2
      bind -n M-3 select-window -t 3
      bind -n M-4 select-window -t 4
      bind -n M-5 select-window -t 5
      bind -n M-6 select-window -t 6
      bind -n M-7 select-window -t 7
      bind -n M-8 select-window -t 8
      bind -n M-9 select-window -t 9
    '';
  };
}
