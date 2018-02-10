#!/bin/bash
# Init
FILE="/tmp/out.$$"
GREP="/bin/grep"
#....
# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root if you install regular user
   please use the another method " 1>&2
   exit 1
fi

# ...
   
 if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i586 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi


if [ "$ARCH" = "i586" ]; then
  SLKCA="Linux-x86"
  KERNH="-smp"
elif [ "$ARCH" = "i686" ]; then
   SLKCA="Linux-x86"
   KERNH="-smp"
elif [ "$ARCH" = "x86_64" ]; then
   SLKCA="Linux-x86_64"
   KERNH=""
else
   SLKCA="Linux-x86_64"
fi

cd /usr/share/update-nvidia-mkinitrd.sh
echo check for updates
git pull

cd /root

# This is nividia's latest stable
filename=latest.txt

wget  https://download.nvidia.com/XFree86/$SLKCA/$filename

# 2 digit ending for nvidia 
GETNV=$(sed "s/\(.\{7\}\).\{0\}//" "${filename}")
RUNNV=$(sed "s/\(.\{14\}\).\{0\}//" "${filename}")
# 3 digit ending for nvidia 
GETNV2=$(sed "s/\(.\{8\}\).\{0\}//" "${filename}")
RUNNV2=$(sed "s/\(.\{16\}\).\{0\}//" "${filename}")


#wget -c  https://download.nvidia.com/XFree86/$SLKCA/$GETNV
URL=https://download.nvidia.com/XFree86/$SLKCA/$GETNV
if wget --spider $URL 2>/dev/null; then
wget -c  https://download.nvidia.com/XFree86/$SLKCA/$GETNV
BRNV=$RUNNV
else
wget -c  https://download.nvidia.com/XFree86/$SLKCA/$GETNV2
BRNV=$RUNNV2
fi
echo down loading $BRNV
#remove for rerun
rm  $filename
#get installed kernel version
KOUT=kernelv.txt
sed -n 3p /boot/config >> koutput.txt
awk '{print($3)}' koutput.txt >>  kernelv.txt

KERNV=$(sed "s/\(.\{10\}\).\{6\}//" "${KOUT}")
#uninstall NVIDIA you are running.

# ...
function pause(){
   read -p "$*"
}

echo -e "\e[1;33m NVidia driver upgrade For kernel installed.\e[0m"
pause 'Press [Enter] key to continue or ctrl c to stop...'
#clean up 
rm koutput.txt
rm kernelv.txt

sh $BRNV --uninstall

#install NVIDIA kernel version for kernel upgrades
sh $BRNV -k $KERNV$KERNH

# ...
function pause(){
   read -p "$*"
}

echo -e "\e[1;33m Make intrid image for new kernel or press ctrl c to stop.\e[0m"
pause 'Press [Enter] key to continue or ctrl c to stop...'
# rest of the script
#

#remove old intrid tree
rm -rf /boot/initrd*
#set drive partition and partition extension
DRTXT=drive.txt
DTEXT=exttype.txt
mount|grep ' / '|cut -d' ' -f 1 >> drive.txt 
DRIVE=$(sed "s/\(.\{9\}\).\{6\}//" "${DRTXT}")
blkid -o export $DRIVE | grep '^TYPE' | cut -d"=" -f2 >> exttype.txt
EXT=$(sed "s/\(.\{9\}\).\{6\}//" "${DTEXT}")
# clean up  for rerun
rm  $DRTXT
rm  $DTEXT
#build the initrd.img
echo -e "\e[1;33m mkinitrd -c -k $KERNV$KERNH -f $EXT -r $DRIVE -m xhci-pci:ohci-pci:ehci-pci:xhci-hcd:uhci-hcd:ehci-hcd:hid:usbhid:i2c-hid:hid_generic:hid-cherry:hid-logitech:hid-logitech-dj:hid-logitech-hidpp:hid-lenovo:hid-microsoft:hid_multitouch:jbd2:mbcache:$EXT  -u -o /boot/initrd.gz \e[0m" 
echo -e "\e[1;33m wait 15 seconds so you can make sure the drive and ext is right hit ctrl c if not \e[0m"
sleep 15
mkinitrd -c -k $KERNV$KERNH -f $EXT -r $DRIVE -m xhci-pci:ohci-pci:ehci-pci:xhci-hcd:uhci-hcd:ehci-hcd:hid:usbhid:i2c-hid:hid_generic:hid-cherry:hid-logitech:hid-logitech-dj:hid-logitech-hidpp:hid-lenovo:hid-microsoft:hid_multitouch:jbd2:mbcache:$EXT  -u -o /boot/initrd.gz
#clean up 
