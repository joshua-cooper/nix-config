{
  description = "Rust Binary";

  path = ./content;

  welcomeText = ''
    # Rust Binary Template

    A simple Rust binary template with `nix` integration.

    ## Using Nix

    Running `nix develop` will install all required tooling to get started,
    including:

    - `cargo`
    - `rustfmt`
    - `clippy`
    - `rust-analyzer`

    It's also possible to build the binary using `nix build` and to run it
    using `nix run`.

    ### Checks

    Running `nix flake check`, will perform various checks:

    - Check code formatting with `cargo fmt`.
    - Lint with `cargo clippy`.
    - Run tests with `cargo test`.
  '';
}
