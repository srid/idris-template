{
  description = "idris-template's description";
  inputs = {
    idris2-pkgs.url = "github:claymager/idris2-pkgs";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };
  outputs = inputs@{ self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" "aarch64-darwin" ] (system:
      let
        pkgs = import nixpkgs { inherit system; overlays = [ inputs.idris2-pkgs.overlay ]; };
        inherit (pkgs.idris2-pkgs._builders) idrisPackage devEnv;
        mypkg = idrisPackage ./. { };
        runTests = idrisPackage ./test { extraPkgs.mypkg = mypkg; };
        shell =
          pkgs.mkShell {
            buildInputs = [ (devEnv mypkg) ];
            packages = with pkgs; [
              nixpkgs-fmt
              entr
              foreman
            ];
          };
      in
      {
        defaultPackage = mypkg;
        packages = { inherit mypkg runTests; };

        devShell = shell;
      });
}
