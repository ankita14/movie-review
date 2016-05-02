module ApplicationHelper
	def nav_link(link_text, link_path)
	  class_name = current_page?(link_path) ? 'active' : nil

	  content_tag(:li, :class => class_name) do
	    link_to link_text, link_path
	  end
	end


  def description(content)
    sanitize(content.gsub(/<code[^<]*<\/code>/, ""), :tags => %w(), :attributes => %w()).gsub(/[\r\n?]/, " ").squeeze(" ").gsub(/\"/, "'")[0..250].strip
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end


	def resource_class 
	  User 
	end
	
end
