class Admin::AddressesController < Admin::BaseController
  before_filter :find_address, only: [:show, :edit, :update, :destroy]

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(params[:address].merge(user_id: params[:user_id]))
    respond_to do |format|
      if @address.save
        format.html  { redirect_to(admin_user_path(@address.user),
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
  end

  def show
    respond_to do |format|
        format.html # show.html.erb
        format.js # show.js.erb
        format.json { render json: @address }
    end
  end

  def update
    respond_to do |format|
      if @address.update_attributes(params[:address])
        format.html  { redirect_to(admin_user_path(@address.user),
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
    @address.destroy
    respond_to do |format|
      format.html { redirect_to(admin_user_path(@address.user),
                      :notice => I18n.t('.Address was successfully deleted')) }
      format.json { head :no_content }
    end
  end

  private
    def find_address
      @address = Address.find(params[:id])
    end
end
