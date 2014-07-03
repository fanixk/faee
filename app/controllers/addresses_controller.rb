class AddressesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_cart

  def index
    @addresses = Address.where("user_id = ?", current_user.id).order("addresses.label").paginate(params[:page])
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address].merge :user_id => current_user.id)
    respond_to do |format|
      if @address.save
        format.html  { redirect_to(addresses_path,
                      :notice => I18n.t('.Address was successfully created')) }
        format.json  { render :json     => @address,
                              :status   => :created, 
                              :location => @address }
      else
        format.html  { render :action => "new" }
        format.json  { render :json   => @address.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html  { redirect_to(addresses_path,
                      :notice => I18n.t('.Address was successfully updated')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json   => @address.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.html { redirect_to(addresses_path,
                      :notice => I18n.t('.Address was successfully deleted')) }
      format.json { head :no_content }
    end
  end

  private
    def find_cart
      @cart = current_cart
    end
end
