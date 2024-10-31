{ pkgs ? import <nixpkgs> {} }:
let
  # Needs to be synced past
  # https://github.com/NixOS/nixpkgs/pull/321786
  local-pico-sdk = pkgs.pico-sdk.override {
     withSubmodules = true;
  };
in
pkgs.mkShell {
  buildInputs = with pkgs;
    [
      gcc-arm-embedded
      local-pico-sdk
      picotool

      cmake python3   # build requirements for pico-sdk
      udisks          # Interact with bootloader filesystem
      tio             # terminal program to interface with serial
    ];
  shellHook = ''
   export PICO_SDK_PATH=${local-pico-sdk}/lib/pico-sdk
  '';
}
