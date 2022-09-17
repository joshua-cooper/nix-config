{ pkgs, ... }:

let
  # TODO: make this global
  pass = pkgs.pass-nodmenu.withExtensions (e: with e; [ pass-otp ]);
in
{
  accounts.email = {
    maildirBasePath = "mail";
    accounts.personal = {
      primary = true;
      flavor = "fastmail.com";
      address = "josh@cooper.dev";
      userName = "josh@cooper.dev";
      realName = "Josh Cooper";
      passwordCommand = "${pass}/bin/pass fastmail/app-password";
      aerc.enable = true;
      msmtp.enable = true;
      mbsync = {
        enable = true;
        create = "both";
        expunge = "both";
      };
    };
  };

  programs = {
    msmtp.enable = true;

    mbsync.enable = true;

    aerc = {
      enable = true;
      extraConfig.general.unsafe-accounts-conf = true;
    };
  };
}
