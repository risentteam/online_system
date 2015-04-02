module ArrivalsHelper
    def check_in_out_message(message)
      case message
        when '0'
          'Пришел'
        when '1'
          'Ушел'
        else
          'Нет данных'
      end
    end
end
