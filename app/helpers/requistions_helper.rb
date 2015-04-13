module RequistionsHelper
    def transcript_of_the_messages(message)
      case message
        when 'Э'
          'Электроснабжение'
        when 'С'
          'Слаботочка'
        when 'Б'
          'Бассеины'
        when 'О'
           'Вентиляция и воздушное отоплание'
        when 'П'
            'Пожаротушение'
        when 'Р'
            'Роснефть'
        when 'В'
            'Водоснабжение, канализация и водяное отоплание'
        else
          ''
      end
    end

    def transcript_of_the_messages_category(message)
      case message
        when 1
          'Авария'
        when 2
          'Неисправность'
        when 3
          'Коррекция режима работы'
        when 4
          'Иные работы'
      end
    end

  def return_str(x)
    if x.nil?
      return ''
    else
      return x
    end 
  end

end
