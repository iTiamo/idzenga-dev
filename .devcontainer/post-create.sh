# Install Ruby for Rusy LSP plugin
rvm install "ruby-$(<.ruby-version)"

# Install dependencies for project
bundle install

# Run project
# bundle exec jekyll serve --force_polling
