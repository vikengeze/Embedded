#! /bin/bash

/bin/bash -c "sudo qemu-system-arm -M vexpress-a9 -kernel vmlinuz-3.16.84 -initrd initrd.img-3.16.84 -drive if=sd,file=debian_wheezy_armhf_standard.qcow2 -append "root=/dev/mmcblk0p2" -net nic -net user,hostfwd=tcp:127.0.0.1:22223-:22"
