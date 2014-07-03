class CartsController < ApplicationController
  
  def show
    begin
      check_cart(params[:id])
      @cart = Cart.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      logger.error "Attempt to access invalid cart #{params[:id]}"
      redirect_to store_index_url, :notice => I18n.t('.Invalid cart')
    else 
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @cart }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.json
  def destroy
    check_cart(params[:id])
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to store_index_url }
      format.json { head :no_content }
    end
  end

  private
    def check_cart(id)
      raise ActiveRecord::RecordNotFound unless id.to_i == current_cart.id
    end

end
