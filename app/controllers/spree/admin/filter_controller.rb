module Spree
	module Admin
		class FilterController < Spree::Admin::BaseController
			before_action :properties , only: [:update]

			def index
				@properties = Spree::Property.all
			end

			def update
				unless @get_properties.blank? && params[:property].blank?
					p '5'*100
					@other_properties = @all_properties - @get_properties
					@get_properties.each do |prop|
						prop.update_attributes(filterable: true)
					end
					@other_properties.each do |other|
						other.update_attributes(filterable: false)
					end
				else
					@all_properties.each do |all|
						all.update_attributes(filterable: true)
					end
				end
					redirect_to :back
			end

			
			def properties
				p '________________________0'
				unless params[:property] && params[:property].blank?
					@get_properties= Spree::Property.find(params[:property])
				end			
					@all_properties= Spree::Property.all
			end

		end
	end
end
