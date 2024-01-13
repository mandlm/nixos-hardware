{ lib, pkgs, ... }:
let ivsc-firmware = with pkgs; stdenv.mkDerivation rec {
  pname = "ivsc-firmware";
  version = "main";

  src = pkgs.fetchFromGitHub {
    owner = "intel";
    repo = "ivsc-firmware";
    rev = "main";
    sha256 = "sha256-kEoA0yeGXuuB+jlMIhNm+SBljH+Ru7zt3PzGb+EPBPw=";
  };

  installPhase = ''
    mkdir -p $out/lib/firmware/vsc/soc_a1_prod
    cp firmware/ivsc_pkg_ovti01a0_0.bin $out/lib/firmware/vsc/soc_a1_prod/ivsc_pkg_ovti01a0_0_a1_prod.bin
    cp firmware/ivsc_skucfg_ovti01a0_0_1.bin $out/lib/firmware/vsc/soc_a1_prod/ivsc_skucfg_ovti01a0_0_1_a1_prod.bin
    cp firmware/ivsc_fw.bin $out/lib/firmware/vsc/soc_a1_prod/ivsc_fw_a1_prod.bin
  '';
};
in
{
  imports = [
    ../../../common/cpu/intel
    ../../../common/pc/laptop
    ../../../common/pc/ssd
  ];

  hardware.enableRedistributableFirmware = true;

  # enable finger print sensor.
  # this has to be configured with `sudo fprintd-enroll <username>`.
  services.fprintd.enable = true;
  services.fprintd.tod.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-goodix;

  # enable webcam
  hardware = {
    ipu6 = {
      enable = true;
      platform = "ipu6ep";
    };

    firmware = [ ivsc-firmware ];
  };

  # Allows for updating firmware via `fwupdmgr`.
  services.fwupd.enable = true;
}
