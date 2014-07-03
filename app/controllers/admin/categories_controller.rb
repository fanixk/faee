class Admin::CategoriesController < Admin::BaseController
  def index
    @categories_all = Category.order("categories.name")
    @search = @categories_all.search(params[:q])
    @categories = @search.result.paginate(params[:page])
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @categories }
    end
  end

  def new
    @category = Category.new
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @category }
    end
  end

  def create
    @category = Category.new(params[:category])
    respond_to do |format|
      if @category.save
        format.html  { redirect_to(admin_categories_path,
                      :notice => I18n.t('.Category was successfully created')) }
        format.json  { render :json     => @category,
                              :status   => :created, 
                              :location => @category }
      else
        format.html  { render :action => "new" }
        format.json  { render :json   => @category.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html  { redirect_to(admin_categories_path,
                      :notice => I18n.t('.Category was successfully updated')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json   => @category.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    respond_to do |format|
      format.html { redirect_to(admin_categories_path,
                      :notice => I18n.t('.Category was successfully deleted')) }
      format.json { head :no_content }
    end
  end
  
end
