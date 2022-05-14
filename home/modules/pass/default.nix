{ pkgs, ... }:

{
  programs.password-store = {
    enable = true;
    package = pkgs.pass-nodmenu.withExtensions (e: with e; [ pass-otp ]);
  };
}
