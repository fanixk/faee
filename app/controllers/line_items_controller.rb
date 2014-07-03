class LineItemsController < ApplicationController
  before_filter :find_cart

  def create
    product = Product.find(params[:product_id])
    @line_item = @cart.add_product(product.id)
    respond_to do |format| 
      if @line_item.save
        format.html { redirect_to store_index_url }
        format.js { @current_item = @line_item }
        format.json { render json: @line_item, status: :created, location: @line_item }
      else
        format.html { render action: "new" } 
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @line_item = @cart.remove_product(params[:id])
      if @line_item.quantity > 0
        @line_item.save
      else
        @line_item.destroy
      end
    rescue
      logger.info "Attempt to delete invalid line item #{params[:id]}"
      redirect_to store_index_url, :notice => I18n.t('.Invalid product')
    end

    respond_to do |format|
      format.html { redirect_to store_index_url }
      format.js
      format.json { render json: @line_item }
    end
  end

  private
    def find_cart
      @cart = current_cart
    end
  
end
