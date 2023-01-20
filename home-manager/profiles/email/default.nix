{ pkgs, ... }:

{
  accounts.email = {
    maildirBasePath = "mail";
    accounts.personal = {
      primary = true;
      flavor = "fastmail.com";
      address = "josh@cooper.dev";
      userName = "josh@cooper.dev";
      realName = "Josh Cooper";
      passwordCommand = "${pkgs.pass}/bin/pass fastmail/app-password";
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
  };
}
