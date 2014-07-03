class Admin::OrderPdf < Prawn::Document
	def initialize(products, view)
		super(top_margin: 70)
		font_families.update("DejaVu" => {
	    :normal => Rails.root.join('app/assets/fonts/dejavu.ttf').to_s,
	    :italic => Rails.root.join('app/assets/fonts/dejavu-italic.ttf').to_s,
	    :bold   => Rails.root.join('app/assets/fonts/dejavu-bold.ttf').to_s
	  })
	  font "DejaVu"
		@products = products
		@view = view
		title
		products_all
	end

	def title
		text Setting.store_title, size: 30, style: :bold
	end

	def products_all
		move_down 20
		table products_rows do
			row(0).font_style = :bold
			columns(2..3).align = :right
			self.column_widths = { 2 => 50, 3 => 100 }
			self.row_colors = ["F9F9F9", "FFFFFF"]
			self.header = true
		end
	end

	def products_rows
		[["Name", "Description", "Price", "Category"]] +
		@products.each.map do |product|
			[product.name, product.description, price(product.price), product.category_name]
		end
	end

	def price(num)
		@view.number_to_currency(num,:unit=>'€')
	end

end