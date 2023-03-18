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
          set -l cmd_status $status

          if set -q DEVBOX
            echo -n "📦 "
          end

          echo -n "$(set_color blue)$(prompt_pwd)"

          if test $cmd_status -ne 0
            echo -n " $(set_color red)$cmd_status"
          end

          set_color -o

          if fish_is_root_user
            echo -n " $(set_color red)#"
          else
            echo -n " $(set_color green)\$"
          end

          echo -n " "

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

      ns = {
        body = ''
          for package in $argv
            set -a packages "nixpkgs#$package"
          end

          if not set -q packages
            echo "Error: no packages were specified"
            return 1
          end

          nix shell $packages
        '';
      };

      nr = {
        body = ''
          if not set -q argv[1]
            echo "Error: no command was specified"
            return 1
          end

          nix run nixpkgs#$argv[1] -- $argv[2..]
        '';
      };
    };
  };
}
