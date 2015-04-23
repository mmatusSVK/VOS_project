module ApplicationHelper

  def full_title(page_title = '')
    base_title = "VOS_projekt" #TODO name
    if page_title.empty?
      base_title
    else
      "#{page_title} - #{base_title}"
    end
  end

  def root_page?(isRoot = '')
    if isRoot.empty?
      false
    else
      true
    end
  end

  def make_all_current_null
    @current_topic = nil
    @current_question = nil

  end

  def make_current_question_null
    @current_question = nil
  end
end
