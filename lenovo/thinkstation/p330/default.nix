{ pkgs, lib, ... }:

{
  imports = [
    ../../../common/pc
    ../../../common/pc/laptop/ssd
    ../../../common/cpu/intel
  ];

  hardware.enableRedistributableFirmware = lib.mkDefault true;

  boot.initrd.availableKernelModules = [ "xhci_pci" "ahci" "nvme" "usbhid" "usb_storage" ];
  boot.kernelModules = [ "kvm-intel" ];
}
