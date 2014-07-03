class Admin::PagesController < Admin::BaseController
  before_filter :find_page, only: [:edit, :update, :destroy]
  cache_sweeper :page_sweeper

  def index
    @pages_all = Page.order('ancestry desc', :position)
    @search = @pages_all.search(params[:q])
    @pages = @search.result.paginate(params[:page])
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?
    
    @nested_pages = Page.arrange(:order => :position)
    
    respond_to do |format|

      format.html # index.html.erb
      format.json { render json: @pages }
    end
  end

  def new
    @page = Page.new
    @page.parent_id = params[:parent] if params[:parent]
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @page }
    end
  end

  def edit
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        format.html { redirect_to admin_pages_path, 
          :notice => I18n.t('Page was successfully created') }
        format.json { render json: @page, status: :created, location: @page }
      else
        format.html { render action: "new" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update_attributes(params[:page])
        format.html { redirect_to admin_pages_path,
        :notice => I18n.t('Page was successfully updated') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    begin
      @page.destroy

      respond_to do |format|
        format.html { redirect_to admin_pages_path,
          :notice => I18n.t('.Page was successfully deleted') }
        format.json { head :no_content }
      end
    rescue Ancestry::AncestryException => exc
      @pages = Page.scoped
      redirect_to admin_pages_path, alert: "#{exc.message}"
    end
  end

  def sort
    Page.transaction do
      params[:page].each_with_index do |id, index|
        Page.find(id).update_attributes({ position: index + 1 })
      end
    end
    render nothing: true
  end

  private
    def find_page
      @page = Page.find_by_slug!(params[:id].split('/').last)
    end

end