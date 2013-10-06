module ApplicationHelper

  # Returns the full title on a per-page basis.
  def full_title(page_title)
    base_title = "Carla and Chris 2014"
    if page_title.empty?
      base_title.html_safe
    else
      "#{base_title} | #{page_title}".html_safe
    end
  end

  def human_boolean(boolean)
  	boolean ? "Yes" : "No"
  end
end
