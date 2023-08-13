final: prev:

{
  pass-menu = prev.writeShellScriptBin "pass-menu" ''
    die() {
      if [ -n "$1" ]; then
        printf "ERROR: %s\n" "$1"
      fi
      exit 1
    }

    notify() {
      ${prev.libnotify}/bin/notify-send -u low "pass-menu" "$1"
    }

    get_choice() {
      find . -name "*.gpg" -type f | sed -e "s/^\.\///" -e 's/\.gpg$//' | ${prev.bemenu}/bin/bemenu
    }

    get_password() {
      export PINENTRY_USER_DATA=gnome

      case "$1" in
        *otp*) ${prev.pass}/bin/pass otp "$choice" ;;
        *) ${prev.pass}/bin/pass "$choice" ;;
      esac
    }

    get_first_line() {
      printf "%s" "$1" | head -n1 | tr -d "\n"
    }

    main() {
      cd "''${PASSWORD_STORE_DIR:-$HOME/.password-store}" || die "No password store found"

      choice=$(get_choice)
      [ -z "$choice" ] && die "No password selected"

      password=$(get_password "$choice")

      case "$?" in
        0) get_first_line "$password" | ${prev.wtype}/bin/wtype - ;;
        1) notify "$choice is not in the password store"; die ;;
        2) notify "Incorrect password"; die ;;
        *) notify "Failed to get password"; die ;;
      esac
    }

    main "$@"
  '';
}
