# encoding: utf-8

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

    def transcript_of_the_messages(message)
      case message
        when 'Э'
          'Электрика'
        when 'Г'
          'Сантехника ГВС'
        when 'Х'
          'Сантехника ХВС'
        when 'К'
          'Канализация'
        when 'О'
          'Отопление'
        when 'Д'
          'Другое'
        else
          'Данные не введены'
      end
    end

  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}
  end

end
