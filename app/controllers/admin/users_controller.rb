class Admin::UsersController < Admin::BaseController
  def index
    @users = User.where('id != ?', current_user.id)
    @search = @users.search(params[:q])
    @users = @search.result.paginate(params[:page])
    # @users = @users.sort_by { |user| user.admin ? 0 : 1 }
    
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @users }
    end
  end

  def new
    @user = User.new
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @user }
    end
  end

  def create
    admin = params[:user][:admin]
    params[:user].delete(:admin)
    @user = User.new(params[:user])
    @user.admin = admin

    respond_to do |format|
      if @user.save
        format.html  { redirect_to(admin_users_path,
                      :notice => I18n.t('.User was successfully created')) }
        format.json  { render :json     => @user,
                              :status   => :created, 
                              :location => @user }
      else
        format.html  { render :action => "new" }
        format.json  { render :json   => @user.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    admin = params[:user][:admin]
    params[:user].delete(:admin)

    respond_to do |format|
      @user.admin = admin
      if @user.update_attributes(params[:user])
        set_admin
        format.html  { redirect_to(admin_users_path,
                      :notice => I18n.t('.User was successfully updated')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json   => @user.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to(admin_users_path,
                      :notice => I18n.t('.User was successfully deleted')) }
      format.json { head :no_content }
    end
  end

  private
    def set_admin
      @user.admin = params[:user][:admin] == "1"
    end
end
