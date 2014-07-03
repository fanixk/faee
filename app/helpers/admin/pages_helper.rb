module Admin::PagesHelper
  def nested_pages(pages)
    pages.map do |page, sub_pages|
      content_tag :li, id: 'page_' + page.id.to_s do
        concat inner_page_div(page)
        concat content_tag(:ul, nested_pages(sub_pages), class: 'unstyled nested-pages')
      end
    end.join.html_safe
  end

  def inner_page_div(page)
    content_tag :div, page.name, class: 'pageDiv' do
      concat page_drag
      concat render page
    end
  end

  def page_drag
    content_tag :i, nil, class: 'icon-move icon-move-custom', :title => I18n.t('.Move')
  end
end