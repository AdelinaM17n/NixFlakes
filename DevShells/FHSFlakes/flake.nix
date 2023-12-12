{
  inputs.nixpkgs.url = "nixpkgs/nixos-unstable";

  outputs = {nixpkgs, ...}: let
    systems = ["x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin"];
    perSystem = f: nixpkgs.lib.genAttrs systems (system:
      f (import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      })
    );
  in {
    devShells = perSystem (pkgs: {
      default = (pkgs.buildFHSEnv {
      name = "holy-fhs-temple";
      targetPkgs = pkgs: (with pkgs; [
        jetbrains.idea-ultimate
        adoptopenjdk-hotspot-bin-8
        # JDK gui deps
        xorg.libXext
        xorg.libX11
        xorg.libXrender
        xorg.libXtst
        xorg.libXi
        #lwjgl deps
        xorg.libXcursor
        xorg.libXrandr
        xorg.libXxf86vm
        libGL
        # jdk deps
        alsa-lib
        fontconfig
        freetype
        stdenv.cc.cc
        #sdkman
        zip
        curl
        unzip
      ]);
      runScript = ''
      idea-ultimate
      '';
    }).env;
  });
  };
}
