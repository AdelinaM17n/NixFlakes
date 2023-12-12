{
    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    outputs = { nixpkgs, ... }: let
        system = "x86_64-linux";
        pkgs = import nixpkgs {
            inherit system;
            config.allowUnfree = true;
        };

    in {
        devShells.${system}.default = pkgs.mkShell {

            packages = (with pkgs; [
                python311Full
            ]) ++ (with pkgs.python311Packages; [
                mypy
            ]);

            # Enter the venv automatically
            shellHook = ''source .venv/bin/activate'';
        };
    };
}
