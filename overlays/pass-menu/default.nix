final: prev:

let
  # TODO: make this itself an overlay to be used elsewhere?
  pass = final.pass-nodmenu.withExtensions (e: with e; [ pass-otp ]);
in
{
  pass-menu = prev.writeShellScriptBin "pass-menu" ''
    set -u

    # TODO: Configure the timeout in mako and use urgency here?
    # This depends on how urgency is used by other things, but these kinds of
    # notifications are a response to user action so shouldn't stay around
    # long. The same can be said for brightness / volume notifications.
    notify_copied() {
      ${final.libnotify}/bin/notify-send -t 2000 pass-menu "Copied ''${1:-}"
    }

    notify_failure() {
      ${final.libnotify}/bin/notify-send -t 5000 pass-menu "''${1:-Failed}"
    }

    PASSWORD_STORE_DIR=''${PASSWORD_STORE_DIR:-$HOME/.password-store}

    cd "$PASSWORD_STORE_DIR" || exit

    choice=$(find . -name "*.gpg" -type f | sed -e 's/^\.\///' -e 's/\.gpg$//' | ${final.bemenu}/bin/bemenu -i -l 10)

    [ -z "$choice" ] && exit

    export PINENTRY_USER_DATA=bemenu

    case "$choice" in
      *otp*) ${pass}/bin/pass otp -c "$choice" ;;
      *) ${pass}/bin/pass -c "$choice" ;;
    esac

    status="$?"

    case "$status" in
      0) notify_copied "$choice" ;;
      1) notify_failure "$choice is not in the password store" ;;
      2) notify_failure "Incorrect password" ;;
      *) notify_failure ;;
    esac

    exit "$status"
  '';
}
