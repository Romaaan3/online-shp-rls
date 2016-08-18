module ApplicationHelper
	def show_title(block)
		if block.title.blank?
			"#{block.name} :: SWAP.com.by"
		else
			"#{block.title} :: SWAP.com.by"
		end
	end
	def show_description(block)
		if block.description.blank?
			"#{block.name} :: SWAP.com.by - Онлайн сервис по продаже запчастей для мобильных устройств и планшетов"
		else
			"#{block.description}"
		end
	end
end
