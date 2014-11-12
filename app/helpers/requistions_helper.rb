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
        when 'П'
           'АПС'
        when 'У'
            'АУУ'
        when 'В'
            'Видеокамера'
        when 'C'
            'Системы дымоудаления'
        when 'Д'
            'Видеодомофон'
        when 'А'
            'Аварийное обслуживание'
        when 'Д'
          'Другое'
        else
          'Данные не введены'
      end
    end
end
