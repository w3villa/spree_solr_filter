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
			unless params[:search].blank? 
				p '#'*100
				@facet = Sunspot.search(Spree::Product) do
					dynamic(:product_property_ids) do
				p '====================================='
				@facet_pro = Sunspot.search(Spree::Product) do
					fulltext "*#{params[:search]}*"
				end.results
			
		        @facet_pro.collect{|x| x.properties.where(filterable: true)}.flatten.uniq.each do |property|
		          facet(property.id)
       	 		end
		    	end
				end
			
			else
				p '@'*100
				@facet = Sunspot.search(Spree::Product) do
					if params[:q] && params[:q][:product_property_name]
						params[:q][:product_property_name].each do |product_property_name|
				        with(:product_property_name, product_property_name[1])
				     end
					end	
					unless params[:search]
						 fulltext "*#{params[:search]}*"
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
end