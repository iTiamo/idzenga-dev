To get started: open this repository using the supplied devcontainer. For the first time usage, run `rvm install "ruby-3.2.2"`. To serve the blog with hot reload enabled, run `bundle exec jekyll serve` and navigate to http://localhost:4000/blog/ to see the blog.

## Known issues

- `.gitconfig` is copied over from the host operating system, which can lead to issues with commit signing, if you encounter any issues unset the signing executable with: `git config --global --unset gpg.ssh.program`
