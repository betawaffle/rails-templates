run 'curl -L http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/screen.css > public/stylesheets/screen.css'
run 'curl -L http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/print.css > public/stylesheets/print.css'
run 'curl -L http://github.com/joshuaclayton/blueprint-css/raw/master/blueprint/ie.css > public/stylesheets/ie.css'

file 'app/views/shared/_blueprint.html.erb', <<-CODE
<!-- Styles -->
<%= stylesheet_link_tag 'screen', :media => 'screen, projection' %>
<%= stylesheet_link_tag 'print', :media => 'print' %>
<!--[if IE]>
  <%= stylesheet_link_tag 'ie', :media => 'screen, projection' %>
<![endif]-->
CODE

git_commit 'Installed Blueprint'