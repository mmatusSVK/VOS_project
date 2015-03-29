module ApplicationHelper

  def full_title(page_title = '')
    base_title = "VOS_projekt" #TODO name
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def show_header(header_on = '')
    if header_on.empty?
      false
    else
      true
    end
  end

end
