{ lib, pkgs, ... }: {
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

  # Allows for updating firmware via `fwupdmgr`.
  services.fwupd.enable = true;
}
