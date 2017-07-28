# update-nvidia-mkinitrd
~~~
Place the update-nvidia-mkinitrd.sh 
/usr/local/bin or where you like. 
As root in runlevel 3 or init 3
type update-nvidia-mkinitrd.sh
use this to upgrade the nvidia driver after a kernel upgrade
will also build the initrd image of the new installed kernel.
~~~

# edit your partition file extention 
~~~
#edit for my system
EXT=ext4 #to what your drive is formated to. 
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
you can edit it to your system use
Alien bob's /usr/share/mkinitrd/mkinitrd_command_generator.sh
then edit your system. As you may want.
This is for a generic sytstem.
It will find your /dev/root and the kernel modules installed.
~~~
For my use and ease. 
