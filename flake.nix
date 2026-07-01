{
  # TODO: ワークショップ名に置き換える
  description = "AWS CDK Coding Beginner Workshop - dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.hugo
            pkgs.nodejs_24
            pkgs.git
          ];

          shellHook = ''
            # TODO: ワークショップ名に置き換える
            echo "AWS CDK Coding Beginner Workshop dev shell"
            echo "  hugo : $(hugo version | head -n1)"
            echo "  node : $(node --version)"
            echo ""
            echo "ローカルプレビュー: hugo server -D --source workshop"
          '';
        };
      });
}
