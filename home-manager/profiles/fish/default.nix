let
  try = file: command: args: ''
    if test -f "${file}"
      if type -q "${command}"
        ${command} ${args}
        return 0
      else
        echo "${file} exists but ${command} is not installed"
      end
    end
  '';
in
{
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      bind \ep tf
    '';

    functions = {
      fish_prompt = {
        body = ''
          if set -q DEVBOX
            echo -n "📦 "
          end

          echo -n "$(set_color blue)$(prompt_pwd)"

          set_color -o

          if fish_is_root_user
            echo -n " $(set_color red)# "
          end

          echo -n " $(set_color red)❯$(set_color yellow)❯$(set_color green)❯"

          echo -n " "

          set_color normal
        '';
      };

      fish_right_prompt = {
        body = ''
          set -l cmd_status $status

          if test $cmd_status -ne 0
            echo -n (set_color red)"[$cmd_status]"
          end

          if not command -sq git
            set_color normal
            return
          end

          if not set -l git_dir (command git rev-parse --git-dir 2>/dev/null)
            set_color normal
            return
          end

          set -l commit ""
          if set -l action (fish_print_git_action "$git_dir")
            set commit (command git rev-parse HEAD 2> /dev/null | string sub -l 7)
          end

          set -l branch_detached 0
          if not set -l branch (command git symbolic-ref --short HEAD 2>/dev/null)
            set branch_detached 1
            set branch (command git describe --contains --all HEAD 2>/dev/null)
          end

          set_color -o

          if test -n "$branch"
            if test $branch_detached -ne 0
              set_color brmagenta
            else
              set_color green
            end
            echo -n " $branch"
          end

          if test -n "$commit"
            echo -n " $(set_color yellow)$commit"
          end

          if test -n "$action"
            set_color normal
            echo -n "$(set_color white):$(set_color -o brred)$action"
          end

          set_color normal
        '';
      };

      r = {
        body = ''
          ${try "Cargo.lock" "cargo" "run"}
          ${try "pnpm-lock.yaml" "pnpm" "start"}
          ${try "yarn.lock" "yarn" "start"}
          ${try "package-lock.json" "npm" "start"}
          echo "Failed to determine run command"
          return 1
        '';
      };

      d = {
        body = ''
          ${try "Cargo.lock" "cargo-watch" "-cx run"}
          ${try "pnpm-lock.yaml" "pnpm" "run dev"}
          ${try "yarn.lock" "yarn" "dev"}
          ${try "package-lock.json" "npm" "run dev"}
          echo "Failed to determine dev command"
          return 1
        '';
      };

      c = {
        body = ''
          ${try "Cargo.lock" "cargo-clippy" ""}
          ${try "Cargo.lock" "cargo" "check"}
          echo "Failed to determine check command"
          return 1
        '';
      };

      t = {
        body = ''
          ${try "Cargo.lock" "cargo" "test"}
          ${try "pnpm-lock.yaml" "pnpm" "test"}
          ${try "yarn.lock" "yarn" "test"}
          ${try "package-lock.json" "npm" "test"}
          echo "Failed to determine test command"
          return 1
        '';
      };

      b = {
        body = ''
          ${try "Cargo.lock" "cargo" "build"}
          ${try "pnpm-lock.yaml" "pnpm" "run build"}
          ${try "yarn.lock" "yarn" "build"}
          ${try "package-lock.json" "npm" "run build"}
          echo "Failed to determine build command"
          return 1
        '';
      };
    };
  };
}
