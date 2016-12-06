#!/bin/bash

function install_package {
  local package_location
  package_location=$1
  echo "remove"
  rm -rf "$HOME/.cache/atom" "$HOME/.atom/" "$HOME/.icons" "$HOME/.themes"
  echo "extract"
  tar --xz --extract --file "$package_location" --directory "$HOME"
  echo "install"
  bash "$HOME/.cache/main.bash"
}

package_name="home_package.tar.xz"
package_location="$HOME/.cache/$package_name"
package_version_location="$HOME/.cache/home_package_version"

if [ -f "$package_name" ]; then
  package_location="$(realpath "$package_name")"
  echo "install: $package_location"
  install_package "$package_location"
  echo "$package_location" > "$package_version_location"
  exit
fi

package_installed_version="$(cat "$HOME/.cache/home_package_version")"
if [ "$package_installed_version" ]; then
  echo "package_installed_version: $package_installed_version"
else
  echo "package_installed_version: not found"
fi

package_latest_version="$(git ls-remote --tags "https://github.com/L0L022/config_iut" | sed "s|.*refs/tags/\(.*\)$|\1|g" | sort -V | tail -n 1)"
if [ "$package_latest_version" ]; then
  echo "package_latest_version: $package_latest_version"
else
  echo "package_latest_version: not found (https://github.com/L0L022/config_iut)"
fi

if [[ "$package_latest_version" && "$package_installed_version" != "$package_latest_version" ]]; then
  echo "install: $package_latest_version"
  echo "download"
  if [ -f "$package_location" ]; then
    rm "$package_location"
  fi
  curl -sL -o "$package_location" https://github.com/L0L022/config_iut/releases/download/"$package_latest_version"/"$package_name"
  install_package "$package_location"
  echo "$package_latest_version" > "$package_version_location"
fi

if [[ "$package_latest_version" && "$package_installed_version" == "$package_latest_version" ]]; then
  echo "no install"
  echo "update atom packages"
  "$HOME/.cache/atom/resources/app/apm/bin/apm" upgrade --no-confirm
fi
