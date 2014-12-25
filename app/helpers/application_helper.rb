module ApplicationHelper
	def full_title(page_title)
		base_title = "Заявки"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end
	
	def replacement_empty(page_title)
		if page_title.nil?
			'Данные не обработаны'
		else
			page_title
		end
	end

	def status_names
		{ fresh: 'новая',
		done: 'исполнена',
		assigned: 'назначена',
		adopted_in_work: 'принята в работу',
		running: 'выполняется',
		comleted: 'завершено',
		canceled: 'отменена'}
	end
end