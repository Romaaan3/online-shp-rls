module Cp::AdminHelper
	def new_orders_count
		Order.where(complete: false).count
	end
end
