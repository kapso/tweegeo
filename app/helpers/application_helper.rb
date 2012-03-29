module ApplicationHelper

  def nbsp (count = 1)
    s = ''
    count.times { s << '&nbsp;' }
    s.html_safe
  end

  def placeholder (dimension, options = {})
    options.update alt: ''
    image_tag "http://placehold.it/#{dimension}", options
  end
  
end