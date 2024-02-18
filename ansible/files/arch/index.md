---
abstract: Unofficial ArchLinux install guide that will be useful to no one.
authors: Xander Harris
date: 2024-01-20
title: Archlinux Installation
---

There are two processes described here. The first describes how to install
ArchLinux from a LiveUSB installation medium. The second describes how
to install a portable ArchLinux onto a USB stick.

```{toctree}
install-to-usb
```

## Filesystem

Use [btrfs](https://wiki.archlinux.org/title/Btrfs) because it is, in fact
a better filesystem, unless you've got mmcblk devices in which case you
should stick to `ext4`.

Things to know in order to do this are that you need to format the partition
you're installing to with `mkfs.btrfs` and you need to add `btrfs-progs` to
your `pacstrap` command.

## Installation Notes (Initial)

1. Set locale and keymap at LiveUSB shell.

    ```{code-block} shell
    localectl list-keymaps
    loadkeys us
    ```

2. Verify Internet connection.

    ```{code-block} shell
    ip link
    ```

    1. This shows the connection is down, which means the Wifi
        password needs to be entered to connect. Sadly for us,
        that's 63 random characters. Happily for us, we can save
        it to a different USB key, mount that in the
        Live USB environment, then copy it over to connect
        to the network.

    2. To do this, we'll mount a different USB key into the
        Mac that we're taking these notes on, then copy the
        wifi password out of our password manager onto the
        USB key. We might like to copy our ssid as well.
        Once that's done, we'll mount it on the
        Live USB environment and use `iwctl` to connect.

        ```{code-block} shell
        echo "$your_pass" > /Volumes/UNTITLED/wlan0
        echo "$your_ssid" > /Volumes/UNTITLED/ssid
        ```

        Then eject the drive and connect it to the
        router we're installing.

    3. With the storage key we just made connected to the
        router we're setting up, we can mount it and copy
        the information we need into the connect command.

        ```{code-block} shell
        :caption: find out which disk to mount with `fdisk`

        fdisk -l
        ```

        This will most likely give you {file}`/dev/sdc` as the
        device to mount.
    4. Now that we know what to mount, let's mount it.

        ```{code-block} shell
        mount /dev/sdc1 /mnt
        ```

    5. With that mounted, we can connect to the internet.

        ```{code-block} shell
        iwctl --passphrase=$(cat /mnt/wlan0) station wlan0 connect $(cat /mnt/ssid)
        ```

    6. Copy the wifi connection info to the Live USB.

        ```{code-block} shell
        cp /mnt/wlan0 /root/wlan0
        cp /mnt/ssid /root/ssid
        ```

3. Now that we're connected to the internet, we can save some time
   on future installations by installing some utilities to our
   storage USB key.

    1. This we will do with pacstrap, but first let's make some
        updates to that new key.

        ```{code-block} shell
        umount -R /mnt
        fdisk /dev/sdc
        ```

        1. Delete the existing partition.

            {menuselection}`m -> d -> 1`
        2. Create an EFI partition.

            {menuselection}`n -> 2048 -> +1G -> t -> 1`
        3. Create a Linux filesystem partition

            {menuselection}`n -> enter -> enter -> enter -> t -> 21`

        4. Save the changes and exit.

            {menuselection}`w`

        5. Now, mount the drives as if we were installing Arch onto
           this USB key.

            ```{code-block} shell
            :caption: sata device mounts

            mount /dev/sdc2 /mnt
            mount --mkdir /dev/sdc1 /mnt/boot
            ```

            ```{code-block} shell
            :caption: mmc device mounts

            mount /dev/mmcblk0p2 /mnt
            mount --mkdir /dev/mmcblk0p1 /mnt/boot
            ```

    2. With these mounted, let's install some utilities.

        ```{code-block} shell
        pacstrap -K /mnt base base-devel linux linux-firmware openssh vim
        ```

        1. You may get some errors about invalid packages when you use pacstrap.
           This is caused by an incorrect, or corrupt pacman GPG keyring.
        2. You can fix it by updating the pacman.conf on the LiveUSB so that it
           looks like this one.
        3. You'll also need to initialize the keyring in the new directory.
        4. Then populate it with the archlinux keys.

    3. Once that's done, copy the connection information
        back from the Live USB to the drive we just
        finished installing.

        ```{code-block} shell
        cp /root/wlan0 /mnt/root/
        cp /root/ssid /mnt/root
        ```

        With our connection info safe and sound, we can
        move on with the regular installation guide.
4. The next stage in the regular installation process is checking
   the time.

    ```{code-block} shell
    timedatectl
    ```

    This will produce output similar to this.

    ```{code-block} shell
    Local time: Sun 2024-01-21 14:15:34 PST
    Universal time: Sun 2024-01-21 22:15:34 UTC
    RTC time: Sun 2024-01-21 22:15:34
    Time zone: America/Los_Angeles (PST, -0800)
    System clock synchronized: yes
    NTP service: inactive
    RTC in local TZ: no
    ```

    The important bit is that `System clock synchronized` is set to
    `yes`.

5. Now, let's partition the disks we're actually installing Arch to.

    1. Check the current partitions.

        ```{code-block} shell
        fdisk -l
        ```

    2. It's usually `/dev/sda`, so we'll go with that, but use
        whatever is appropriate for your system.

        ```{code-block} shell
        fdisk /dev/sda
        ```

    3. We'll do this in stages.

        {menuselection}`d -> enter`$*n$ where $n$ is the number
        of existing partitions

        {menuselection}`w`

    4. With the partitions removed, let's start fresh with GPT.

        ```{code-block} shell
        fdisk /dev/sda
        ```

        {menuselection}`g -> w`
    5. Now that we have a blank partition table, let's add the ones
        we need.

        ```{code-block} shell
        fdisk /dev/sda
        ```

        {menuselection}`n -> 1 -> enter -> +1G -> enter -> t -> 1`

        {menuselection}`n -> 2 -> enter -> enter -> t -> 21 -> w`

    6. This should result in something like the following.

        ```{code-block} shell
        :caption: input
        fdisk -l
        ```

        ```{code-block} shell
        :caption: output
        Disk /dev/sda: 476.94 GiB, 512110190592 bytes, 1000215216 sectors
        Disk model: GN-512-2242
        Units: sectors of 1 * 512 = 512 bytes
        Sector size (logical/physical): 512 bytes / 512 bytes
        I/O size (minimum/optimal): 512 bytes / 512 bytes
        Disklabel type: gpt
        Disk identifier: D1AE48DF-8B15-4E04-85FD-F35F954E1822

        Device       Start        End   Sectors   Size Type
        /dev/sda1     2048    2099199   2097152     1G EFI System
        /dev/sda2  2099200 1000214527 998115328 475.9G Linux root (x86-64)
        ```

6. With those partitioned, we'll format them.

    ```{code-block} shell
    mkfs.fat -F 32 /dev/sda1
    mkfs.btrfs /dev/sda2
    ```

7. After they're formatted, we can mount them.

    ```{code-block} shell
    mount /dev/sda2 /mnt
    mount --mkdir /dev/sda1 /mnt/boot
    ```

8. Once they're mounted, we can use `pacstrap` to install some basics.

    ```{code-block} shell
    pacstrap -K /mnt base base-devel btrfs-progs iwd \
        linux linux-firmware man-db man-pages \
        networkmanager openssh texinfo vim
    ```

9. And, once they've been bootstrapped we'll need them to have an fstab.

    ```{code-block} shell
    genfstab -U /mnt >> /mnt/etc/fstab
    ```

10. With the fstab safely in place we can chroot to the new system.

    ```{code-block} shell
    arch-chroot /mnt
    ```

11. First thing in the new container is to set the timezone.

    ```{code-block} shell
    ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime
    ln -sf /usr/bin/vim /usr/bin/vi
    ```

12. Then set the system clock to the hardware clock.

    ```{code-block} shell
    hwclock --systohc
    ```

13. Now, we're ready to localize.
    1. First, edit locale.gen to uncomment the line with your locale.

        ```{code-block} shell
        sed -i 's/^#en_US.UTF-8/en_US.UTF-8/g' /etc/locale.gen
        ```

    2. Then, generate the locale.

        ```{code-block} shell
        locale-gen
        ```

    3. Create the {file}`/etc/locale.conf`

        ```{code-block} shell
        echo "LANG=en_US.UTF-8" > /etc/locale.conf
        ```

14. Set your keyboard layout.

    ```{code-block} shell
    echo "KEYMAP=us" > /etc/vconsole.conf
    ```

15. Set your hostname.

    ```{code-block} shell
    echo "router.your.domain" > /etc/hostname
    ```

16. Finish setting up [the network](https://wiki.archlinux.org/title/Network_configuration)
    in the new environment.

    1. We'll use [NetworkManager](https://wiki.archlinux.org/title/Network_configuration#Network_managers)
    2. This doesn't require much configuration other than to set the [wifi backend to iwd](https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend).

        ```{code-block} shell
        printf "[device]\nwifi.backend=iwd\n" > /etc/NetworkManager/conf.d/wifi_backend.conf
        ```

        1. If you plan to use openresolv, install it.

            ```{code-block} shell
            pacman -S openresolv
            ```

        2. Then configure it.

            ```{code-block} ini
            :caption: /etc/NetworkManager/conf.d/rc-manager.conf

            [main]
            rc-manager=resolvconf
            ```

    3. Once that's set we can enable and start NetworkManager.

        ```{code-block} shell
        systemctl enable NetworkManager
        systemctl start NetworkManager
        ```

17. Once that's done we need to install and configure a boot manager.
    1. We'll use [grub](https://wiki.archlinux.org/title/Arch_boot_process#Feature_comparison),
        we also need to install efibootmgr,
        amd-ucode, and intel-ucode.

        ```{code-block} shell
        pacman -Syuu grub efibootmgr amd-ucode intel-ucode
        ```

    2. Once it's installed, we'll need to [install it again](https://wiki.archlinux.org/title/GRUB#Installation).

        ```{code-block} shell
        grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
        ```

    3. Then [make the config](https://wiki.archlinux.org/title/GRUB#Generate_the_main_configuration_file)
        that will allow our system to boot.

        ```{code-block} shell
        grub-mkconfig -o /boot/grub/grub.cfg
        ```

18. Now we can double check the mkinitcpio.conf and make the init cp io even though it's already been made.

    ```{code-block} shell
    mkinitcpio -P
    ```

19. After that's done, set a root password.

    ```{code-block} shell
    passwd
    ```

20. Now, exit the chroot environment.

    {menuselection}`ctrl-d`

21. Unmount the drives.

    ```{code-block} shell
    umount -R /mnt
    ```

22. And reboot your new installation.

    ```{code-block} shell
    shutdown -r now
    ```

## Post-installation Notes

### Create an fstab

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

### Some possibly helpful links

- [iwd](https://wiki.archlinux.org/title/NetworkManager#Using_iwd_as_the_Wi-Fi_backend)
- [NetworkManager](https://wiki.archlinux.org/title/NetworkManager)
- [List of Applications](https://wiki.archlinux.org/title/List_of_applications)
- [Bash](https://wiki.archlinux.org/title/Bash)
- [Color output](https://wiki.archlinux.org/title/Color_output_in_console)
- [ble.sh](https://github.com/akinomyoga/ble.sh/wiki/Manual-%C2%A71-Introduction)
- [completion](https://man.archlinux.org/man/bash.1#Programmable_Completion)
- [fast completion](https://wiki.archlinux.org/title/Readline#Faster_completion)
- [cli](https://wiki.archlinux.org/title/Bash#Command_line)
- [shell](https://wiki.archlinux.org/title/Command-line_shell)
- [General Recommendations](https://wiki.archlinux.org/title/General_recommendations#Tab-completion_enhancements)
- [UEFI](https://wiki.archlinux.org/title/GRUB/Tips_and_tricks#UEFI_further_reading)
- [Installation Guide](https://wiki.archlinux.org/title/Installation_guide)
