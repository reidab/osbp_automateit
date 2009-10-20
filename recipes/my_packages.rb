# Setup many favorite packages

package_manager.install <<-HERE
  # Console helpers
  vim exuberant-ctags
  screen elinks w3m htop telnet mc ncdu dtach
  time pcregrep
  man-db
  tofrodos

  # Network tools
  rsync curl apache2-utils httperf host dnsutils
HERE
