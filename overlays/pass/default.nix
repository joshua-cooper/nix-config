final: prev:

{
  pass = prev.pass-nodmenu.withExtensions (extensions: [ extensions.pass-otp ]);
}
