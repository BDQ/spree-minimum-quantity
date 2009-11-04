# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class MinimumQuantityExtension < Spree::Extension
  version "1.0"
  description "Requires user purchase a minimum quantity of a specific product"
  url "http://github.com/BDQ/spree-minimum-quantity"

  # Please use minimum_quantity/config/routes.rb instead for extension routes.

  # def self.require_gems(config)
  #   config.gem "gemname-goes-here", :version => '1.2.3'
  # end
  
  def activate
		Variant.additional_fields += [ :name => 'Minimum Quantity', :options => { :size => 4}  ]
		
		LineItem.class_eval do 
	 
			
			alias :core_validate :validate
			def validate
				core_validate
				minimum = variant.is_master? ? variant.product.minimum_quantity : variant.minimum_quantity
				errors.add(:quantity, "does not meet minimum quantity required") if quantity < minimum
			end
		end
		
  end
end
