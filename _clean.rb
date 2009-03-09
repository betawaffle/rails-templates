run 'rm README'
run 'rm doc/README_FOR_APP'
run 'rm public/index.html'
run 'rm public/favicon.ico'
run 'rm public/robots.txt'

%w(pids sessions sockets cache).each do |f|
  run "rmdir tmp/#{f}"
end