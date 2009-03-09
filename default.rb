load_template 'http://github.com/betawaffle/rails-templates/raw/master/init.rb'
partial_template :blueprint

initializer 'session_store.rb', <<-CODE
ActionController::Base.session = {
  :session_key => '_#{(1..6).map { |x| (65 + rand(26)).chr }.join}_session',
  :secret => '#{(1..40).map { |x| (65 + rand(26)).chr }.join}'
}
ActionController::Base.session_store = :active_record_store
CODE

initializer 'string_extensions.rb', <<-CODE
class String
  def indent(levels = 1, spaces_per_level = 2)
    this.split("\\n").join("\\n\#{' ' * spaces_per_level * levels}")
  end
end
CODE

file 'app/helpers/application_helper.rb', <<-CODE
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def xhtml_document(type = :strict, lang = :en, html_options = {}, &block)
    lang = lang.to_s
    html_options.stringify_keys!
    html_options.delete('xml:lang')
    html_options.delete('lang')

    attrs = [%( xmlns="http://www.w3.org/1999/xhtml")]
    attrs << %( xml:lang="\#{lang}" lang="\#{lang}")

    html_options.each do |key, value|
      next unless value

      value = value == true ? key : escape_once(value)
      attrs << %( \#{key}="\#{value}")
    end

    concat xhtml_doctype(type.to_s), block.binding
    concat %(<html\#{attrs.join}>), block.binding
    concat capture(&block), block.binding
    concat %(</html>), block.binding
  end
  
  def shared_template(name, locals = {})
    render :template => "shared/\#{name.to_s}", :locals => locals
  end
  
  def shared_partial(name, locals = {})
    render :partial => "shared/\#{name.to_s}", :locals => locals
  end
  
private
  def xhtml_doctype(type = nil)
    type = 'transitional' unless %w(frameset transitional strict).include? type
    
    fpi = "-//W3C//DTD XHTML 1.0 \#{type.capitalize}//EN"
    uri = "http://www.w3.org/TR/xhtml1/DTD/xhtml1-\#{type}.dtd"
    
    %(<!DOCTYPE html PUBLIC \#{fpi} \#{uri}>\n)
  end
end
CODE

git_commit 'Default Template'