#!/bin/sh

set -u

# ruby
export PATH=/usr/local/opt/ruby/bin:$PATH
if which ruby >/dev/null && which gem >/dev/null; then
  PATH="$(ruby -r rubygems -e 'puts Gem.dir')/bin:$PATH"
fi

echo "install gem packages"
gem install git-browse-remote jekyll
