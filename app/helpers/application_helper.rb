module ApplicationHelper
  
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end
    content_tag("div", attributes, &block)
  end
	
  def split_path
  	if request.path == '/'
  		return 'home'
  	else
  		request.path.split('/').from(1).join(' ') 
  	end
  end

  def full_title(page_title)
    begin
      base_title = Setting.store_title
    rescue
      base_title = 'Faee'
    end

    if page_title.empty?
      base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
