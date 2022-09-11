{
  description = "Rust!";

  path = ./content;

  welcomeText = ''
    # Rust Binary Template

    A basic rust project skeleton has been set up including a Nix package and CI.

    You can run the code with either `cargo run` or `nix run`.

    CI uses nix via `nix flake check`, which can also be run locally! It will do
    the following:

    - Build the project.
    - Check the formatting of all rust files with `rustfmt`.
    - Check for any warnings when running `cargo clippy`
    - Run all tests and check that they pass.
  '';
}
