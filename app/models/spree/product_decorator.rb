module Spree
	Product.class_eval do
		
		searchable do
	    text :name
	    string :product_taxon,:multiple => true
			dynamic_string :product_property_ids, :multiple => true do
       product_properties.inject(Hash.new { |h, k| h[k] = [] }) do |map, product_property| 
         map[product_property.property_id] << product_property.value
         map
       end
     	end

			string :product_property_name, references: ProductProperty, multiple: true do
	      product_properties.collect { |p| p.value }.flatten
	    end	
	  end
		
		def product_taxon
    	self.taxons.collect(&:id)
    end  
	end
end