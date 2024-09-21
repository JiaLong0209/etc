distro=$1

if [[ -z $distro ]]; then
  echo "Usage: $0 <DISTRO>"
  exit 0
fi

proot-distro login  --isolated --fix-low-ports $distro --user user 

# proot-distro login  --termux-home --fix-low-ports --termux-home --shared-tmp $distro
