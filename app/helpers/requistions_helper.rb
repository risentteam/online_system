module RequistionsHelper
    def transcript_of_the_messages(message)
      case message
        when 'Э'
          'АВАРИЯ (ЦО/ГВС/ХВС/Канализация)'
        when 'Г'
          'РЕМОНТ (ЦО/ГВС/ХВС/Канализация)'
        when 'X'
          'АВАРИЯ (ЭЛЕКТРОСЕТИ)'
        when 'К'
          'РЕМОНТ (ЭЛЕКТРОСЕТИ)'
        when 'О'
          'АВАРИЯ (ВЕНТИЛЯЦИЯ/ДЫМОУДАЛЕНИЕ/ТС)'
        when 'П'
           'РЕМОНТ (ВЕНТИЛЯЦИЯ/ДЫМОУДАЛЕНИЕ/ТС)'
        when 'У'
            'АВАРИЯ СЛАБОТОЧНЫХ СИСТЕМ (АПС, СТРЕЛЕЦ, КТС, ДОМОФОН, ВИДЕО)'
        when 'В'
            'ТО СЛАБОТОЧНЫХ СИСТЕМ (АПС, СТРЕЛЕЦ, КТС, ДОМОФОН, ВИДЕО)'
        when 'C'
            'ТО ВЕНТИЛЯЦИИ/ВОЗД.ОТОПЛЕНИЯ'
        when 'Д'
            'ТО АУУ (ОТОПЛЕНИЕ)'
        when 'А'
            'ТО СИСТЕМ КОНДИЦИОНИРОВАНИЯ'
        when 'Д'
            'ТО ВОДОПОДГОТОВКИ БАССЕЙНОВ'
        when 'Т'
            "ОПРЕССОВКА ТРУБОПРОВОДОВ"
        when 'Р'
            "ГАРАНТИЙНОЕ ОБСЛУЖИВАНИЕ"
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
