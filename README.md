# update-nvidia-mkinitrd
~~~
Buld the package and install
~~~

# edit your partition file extention 
~~~
automaticall finds your file table extention 
~~~

# Not for legacy drivers
~~~
Downloads the "latest.txt"
reads it and downloads the kernel for your arch.
It reads your new /boot/config file.

Uninstalls the old NVidia driver 
Then builds the NVidia driver that is 
installed. Since it reads the config. 
It builds the driver for it.

If you have upgraded you linux kernel it 
will read  the new /boot/config
and build the initrd.gz for your drive.
~~~
# Note on the mkinitrd

~~~
reads the  the new kernel config in /boot 
then builds nvidia module and initrd.img for that version
you can edit it to your system use
Alien bob's /usr/share/mkinitrd/mkinitrd_command_generator.sh
then edit your system. As you may want.
This is for a generic sytstem.
It will find your /dev/root and the kernel modules installed.
~~~
For my use and ease. 
