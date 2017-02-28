module Spree
	ProductsController.class_eval do
		before_action :facet
		
		def facetfilter
			p '------'
				@products = Sunspot.search(Spree::Product) do
					if params[:q] && params[:q][:product_property_name]
						params[:q][:product_property_name].each do |product_property_name|
				          with(:product_property_name, product_property_name[1])
				        end
					end	
					paginate(:page => params[:page].blank? ? 1 : params[:page], :per_page => 15)
				end.results
	      		@taxonomies = Spree::Taxonomy.includes(root: :children)
			render 'spree/products/solr_search'
		end

	private
		def facet
			@facet = Sunspot.search(Spree::Product) do
				if params[:q] && params[:q][:product_property_name]
					params[:q][:product_property_name].each do |product_property_name|
		        with(:product_property_name, product_property_name[1])
		      end
				end	

				if params[:data] 
					p '-'*100
						fulltext "*#{params[:data]}*"
				end
					dynamic(:product_property_ids) do
		        Spree::Property.where(filterable: true).each do |property|
		          facet(property.id)
		        end
			    end
			end 
		end
	end
end