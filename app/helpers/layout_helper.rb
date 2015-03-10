module LayoutHelper
  def page_title(value)
    @page_title = [@page_title, value].reject(&:blank?).join(' - ')
  end

  def body_class(value)
    @body_class = [@body_class, value].reject(&:blank?).join(' ')
  end

  def stylesheet(source)
    content_for(:stylesheet) { stylesheet_link_tag(source,  media: 'all', 'data-turbolinks-track' => true) }
  end

  def javascript(source)
    content_for(:javascript) { javascript_include_tag(source, 'data-turbolinks-track' => true) }
  end

  def meta(*args)
    content_for(:meta) { tag(:meta, *args) }
  end
end
