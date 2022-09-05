{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      with nixpkgs.legacyPackages.${system}; {
        devShell =
          let
            devtools = {
              goreturns = buildGoModule {
                name = "goreturns";
                src = fetchFromGitHub {
                  owner = "nafiz1001";
                  repo = "goreturns";
                  rev = "bc4af210ec8f1989a40ba85276b89a12b1776037";
                  sha256 = "sha256-c55tnhSAM9AXAWvizTBjPHFMiGRRmhavnqbMR5t083w=";
                };
                doCheck = false;
                vendorSha256 = "sha256-x2cz8bvvS6ozroum33VsCR74B6azC6myzLmm8Tn0QDA=";
              };
              gotools = buildGoModule {
                name = "gotools";
                src = fetchFromGitHub {
                  owner = "dominikh";
                  repo = "go-tools";
                  rev = "v0.3.3";
                  sha256 = "sha256-Yli+8gMoRRyNqOgFRv/uyFBVXdIlDH0tfZzvfTYBPyU=";
                };
                doCheck = false;
                subPackages = [ "cmd/staticcheck" ];
                vendorSha256 = "sha256-19uLCtKuuZoVwC4SUKvYGWi2ryqAQbcKXY1iNjIqyn8=";
              };
            };
          in
          with pkgs; mkShell {
            buildInputs = [
              go
              devtools.gotools
              gocode
              gocode-gomod
              go-outline
              godef
              gogetdoc
              # goimports (in gotools)
              devtools.goreturns
              # staticcheck (in gotools)
              golangci-lint
              revive
              gopls
              delve
            ];
          };
      });
}
