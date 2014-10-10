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

    def link_to_add_fields(name, f, association)
      new_object = f.object.class.reflect_on_association(association).klass.new
      fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
        render(association.to_s.singularize + "_fields", :f => builder)
      end
      link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")")
    end

end
