if [ -z "$WERCKER_SETUP_GO_WORKSPACE_GOPATH" ]; then
  fail 'No go $GOPATH found. Please make sure there is an $GOPATH available (or specify the gopath property in the wercker.yml)'
fi

debug "Using $WERCKER_SETUP_GO_WORKSPACE_GOPATH as root dir"

package_dir=""
if [ -z "$WERCKER_SETUP_GO_WORKSPACE_PACKAGE_DIR" ]
then
  if [ ! -z "$WERCKER_GIT_REPOSITORY" ]
  then
    package_dir="$WERCKER_SETUP_GO_WORKSPACE_GOPATH/src/$WERCKER_GIT_DOMAIN/$WERCKER_GIT_OWNER/$WERCKER_GIT_REPOSITORY"
    debug "package-dir option not set, will use default: $package_dir"
  else
    fail 'missing package-dir option and no repository info found, please add this the setup-package-dir step in wercker.yml'
  fi
else
  package_dir="$WERCKER_SETUP_GO_WORKSPACE_GOPATH/src/$WERCKER_SETUP_GO_WORKSPACE_PACKAGE_DIR"
  debug "package-dir option set, will use: $package_dir"
fi

mkdir -p $(dirname "$package_dir")
ln -sf "$WERCKER_SOURCE_DIR" "$package_dir"
export WERCKER_SOURCE_DIR="$package_dir"

info "\$WERCKER_SOURCE_DIR now points to: $WERCKER_SOURCE_DIR"
success "Go workspace setup finished"
