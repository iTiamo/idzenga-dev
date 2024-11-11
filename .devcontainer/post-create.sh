# Install Ruby for Rusy LSP plugin
rvm install "ruby-$(</workspaces/idzenga.dev/.ruby-version)"

# Install dependencies for project
cd /workspaces/idzenga.dev/
bundle install

# Run project
# bundle exec jekyll serve --force_polling
