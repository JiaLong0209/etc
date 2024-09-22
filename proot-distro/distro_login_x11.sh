DISTRO=$1
USER=$2


if [[ -z "$DISTRO" ]]; then
  echo "Usage: $0 <DISTRO> [USER]"
  exit 1
fi

if [[ -z "$USER" ]]; then
  USER="user"
fi


proot-distro login $DISTRO --shared-tmp --user $USER

# proot-distro login  --termux-home --fix-low-ports --termux-home --shared-tmp $distro
