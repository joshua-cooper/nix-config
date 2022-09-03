{
  services.resolved = {
    enable = true;
    dnssec = "true";
    extraConfig = ''
      DNSOverTLS=yes
    '';
  };
}
