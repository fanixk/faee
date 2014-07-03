class PagesController < ApplicationController
  layout 'pages'
  
  def show
    page = Page.published.find_by_slug!(params[:slug].split('/').last) #bang method raises ActiveRecordNotFound(404) error
    full_slug = page.full_slug
    @page = page if full_slug == params[:slug]

    raise ActiveRecord::RecordNotFound if @page.nil?
    @cart = current_cart
  end

  # private
  #   def get_path(page)
  #     (page.ancestors + [page]).map(&:to_param).join("/")
  #   end
end