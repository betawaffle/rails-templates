def partial_template(*names)
  names.each do |name|
    load_template "http://github.com/betawaffle/rails-templates/raw/master/_#{name.to_s}.rb"
  end
end

partial_template :clean, :git

git_commit 'Initial Commit'