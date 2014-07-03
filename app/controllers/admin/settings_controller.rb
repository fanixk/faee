class Admin::SettingsController < Admin::BaseController
  
  def index
    @settings = Setting.order(:key)
    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @settings }
    end
  end

  def edit
    @setting = Setting.find(params[:id])
  end

  def update
    @setting = Setting.find(params[:id])
    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        set_locale(@setting.value) if @setting.key == 'locale'
        format.html  { redirect_to(admin_settings_path,
                      :notice => I18n.t('.Setting was successfully updated')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json   => @setting.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

end
