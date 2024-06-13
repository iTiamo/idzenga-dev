# Install Ruby for Rusy LSP plugin
rbenv install <.ruby-version

# .gitconfig is copied from Windows to the container, this can cause issues with
# regards to the commit signing program not being found. Unsetting the signing
# program will fix this issue.
git config --global --unset gpg.ssh.program
