{
  description = "React + Storybook visual regression testing tool dev shell";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nodejs_22
            pkgs.yarn

            # Nix-patched playwright browsers so Chromium actually runs on NixOS.
            # Used both by Storybook's vitest browser tests and by lost-pixel.
            pkgs.playwright-driver.browsers
          ];

          shellHook = ''
            # Point Playwright at the Nix-provided browsers and skip downloads.
            export PLAYWRIGHT_BROWSERS_PATH="${pkgs.playwright-driver.browsers}"
            export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
            export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=true

            echo "node  $(node --version)"
            echo "yarn  $(yarn --version)"
          '';
        };
      });
}
