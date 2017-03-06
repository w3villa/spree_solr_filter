module Spree
	ProductsController.class_eval do
		before_action :facet
		


		def index
			@products = Sunspot.search(Spree::Product) do
				if params[:q] && params[:q][:product_property_name]
					params[:q][:product_property_name].each do |product_property_name|
	          with(:product_property_name, product_property_name.last)
	        end
				end	
				unless params[:keywords].blank?
					keywords "#{params[:keywords]}"
				end
				paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 15)
			end.results
		end

		# def facetfilter
		# 	p '------'
		# 		@products = Sunspot.search(Spree::Product) do
		# 			if params[:q] && params[:q][:product_property_name]
		# 				params[:q][:product_property_name].each do |product_property_name|
		#           with(:product_property_name, product_property_name[1])
		#         end
		# 			end	
		# 			paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 15)
		# 		end.results
	 #      		@taxonomies = Spree::Taxonomy.includes(root: :children)
		# 	render 'spree/products/index'
		# end

	private
		def facet
			unless params[:keywords].blank? 
				p '#'*100
				@facet = Sunspot.search(Spree::Product) do
					dynamic(:product_property_ids) do
						@facet_pro = Sunspot.search(Spree::Product) do
							keywords "#{params[:keywords]}"
						end.results
			
		        @facet_pro.collect{|x| x.properties.where(filterable: true)}.flatten.uniq.each do |property|
		          facet(property.id)
       	 		end
		    	end
				end
			else
				p '@'*100
				@facet = Sunspot.search(Spree::Product) do
						dynamic(:product_property_ids) do
			        Spree::Property.where(filterable: true).each do |property|
			          facet(property.id)
	       	 		end
			    	end
				end 
			end
				
		end
	end
end