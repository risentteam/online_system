module RequistionsHelper
    def transcript_of_the_messages(message)
      case message
        when 'Э'
          'Электрика'
        when 'Г'
          'Сантехника ГВС'
        when 'X'
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
end
