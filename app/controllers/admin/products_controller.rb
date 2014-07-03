class Admin::ProductsController < Admin::BaseController

  def index
    @products_all = Product.includes(:category).order("categories.name, products.name")
    @search = @products_all.search(params[:q])
    @products = @search.result.paginate(params[:page])
    @search.build_condition if @search.conditions.empty?
    @search.build_sort if @search.sorts.empty?

    respond_to do |format|
      format.html  # index.html.erb
      format.json  { render :json => @products }
    end
  end

  def new
    @product = Product.new
    respond_to do |format|
      format.html  # new.html.erb
      format.json  { render :json => @product }
    end
  end

  def create
    @product = Product.new(params[:product])
    respond_to do |format|
      if @product.save
        format.html  { redirect_to(admin_products_path,
                      :notice => I18n.t('.Product was successfully created')) }
        format.json  { render :json     => @product,
                              :status   => :created, 
                              :location => @product }
      else
        format.html  { render :action => "new" }
        format.json  { render :json   => @product.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product = Product.find(params[:id])
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html  { redirect_to(admin_products_path,
                      :notice => I18n.t('.Product was successfully updated')) }
        format.json  { head :no_content }
      else
        format.html  { render :action => "edit" }
        format.json  { render :json   => @product.errors,
                              :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to(admin_products_path,
                        :notice => I18n.t('.Product was successfully deleted')) }
        format.json { head :no_content }
      else
        format.html { redirect_to admin_products_path, 
                      alert: "Couldn' t delete product. #{@product.errors.full_messages.first }." }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def pdf
    @products = Product.includes(:category).order("categories.name, products.name")

    respond_to do |format|
      format.pdf do
        pdf = Admin::OrderPdf.new(@products, view_context)
        send_data pdf.render
      end
    end
  end
  
end
