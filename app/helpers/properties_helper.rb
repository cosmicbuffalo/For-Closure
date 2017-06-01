module PropertiesHelper

  def checkbox_and_label(display_name, prefix)
    data = "<div class='category-row'><input type='checkbox' name='category[#{ prefix + "_" + display_name.delete(" /").underscore}]' value='#{display_name}'> #{display_name}</div>"
    data.html_safe
  end

  def radio_and_label(display_name, field_name)
    data = "<div class='category-row'><input type='radio' name='category[#{field_name}]' value='#{display_name}'> #{display_name}</div>"
    data.html_safe
  end

end
