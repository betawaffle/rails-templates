file '.gitignore', <<-END
.DS_Store
config/database.yml
db/*.sqlite3
log/*.log
tmp/**/*
END

run 'cp config/database.yml config/database.example.yml'
run 'touch tmp/.gitignore log/.gitignore vendor/.gitignore'
run 'find . -type d -empty | grep -v "vendor" | grep -v ".git" | grep -v "tmp" | xargs -I xxx touch xxx/.gitignore'

git :init

def git_commit(message)
  git :add => '.', :commit => "-a -m '#{message}'"
end