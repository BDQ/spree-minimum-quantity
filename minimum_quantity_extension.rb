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
	 		validate :must_meet_minimum
			
			private
			def must_meet_minimum
				minimum = variant.is_master? ? variant.product.minimum_quantity : variant.minimum_quantity
				minimum ||= 0
				errors.add(:quantity, "does not meet minimum quantity required") if quantity < minimum
			end
		end
		
  end
end
