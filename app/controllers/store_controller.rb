class StoreController < ApplicationController
  layout 'store'
  
  def index
    @options = Category.order( 'name ASC' )
    if (params[:category_id].blank? || params[:category_id]=='0')
    	@products = Product.includes(:category).order("categories.name, products.name")
      @category = ''
    else 
    	@products = Product.includes(:category).order("products.name").where(:category_id => params[:category_id])
      @category = Category.where(:id => params[:category_id]).first
    end
    @cart = current_cart
  end

  def show
    @product = Product.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

end
