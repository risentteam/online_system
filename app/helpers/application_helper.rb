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
		{ received: "получено",
		done: "сделано",
		worker_sended: "рабочие отправлены",
		worker_arrived: "рабочие прибыли",
		worker_gone: "рабочие ушли"}
	end
end
