class Contract < ActiveRecord::Base
  belongs_to :user
  has_many :requistions
  has_many :buildingscontracts
  has_many :buildings, through: :buildingscontracts

  def begin_time_safe
    time = read_attribute(:begin_time)
    time = time ? time.strftime("%d.%m.%Y") : "Нет данных"
  end

  def end_time_safe
    time = read_attribute(:end_time)
    time = time ? time.strftime("%d.%m.%Y") : "Нет данных"
  end
  
  def self.parse_begin_time(begin_time_in_russian)
    case begin_time_in_russian
          when 'с января'
            Date.new(2015, 1)
          when 'c февраля'
            Date.new(2015, 2)
          when 'с марта'
            Date.new(2015, 3)
          when 'с апреля'
            Date.new(2015, 4)
          when 'с мая'
            Date.new(2015, 5)
          when 'c июня'
            Date.new(2015, 6)
          when 'c июля'
            Date.new(2015, 7)
          when 'с августа'
            Date.new(2015, 8)
          when 'с сентября'
            Date.new(2015, 9)
          when 'с октября'
            Date.new(2015, 10)
          when 'с ноября'
            Date.new(2015, 11)
          when 'c декабря'
            Date.new(2015, 12)
          else Date.parse(begin_time_in_russian)
    end
  end

  def self.parse_end_time(btime, duration)
    if duration
      btime.next_month(duration)
    else end_month
    end
  end

  def self.import(file_path)
    spreadsheet = open_spreadsheet(file_path)
    spreadsheet.default_sheet = spreadsheet.sheets[0]
    (1..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      if not row[1].nil? and row[1]!='ИТОГО'
        if not row[2].nil?
          company = row[2]
        else
          company = row[3]
        end
        company.squeeze!(' ,.')
        company.strip!
        btime = parse_begin_time(row[5])
        etime = parse_end_time(row[8])
        if Contract.where("name_contract = ? ", row[1].to_s).empty?
          contract = Contract.create(name_contract: row[1].to_s, date_of_signing: row[6], description: row[7], begin_time: btime, end_time: etime, comment: row[9])
        else
          contract = Contract.where("name_contract = ? ", row[1].to_s).first
          contract.update_attributes(name_contract: row[1].to_s, date_of_signing: row[6], description: row[7], begin_time: btime, end_time: etime, comment: row[9])
        end        
        adress = row[4].split(';')
        adress.each do |address|
      		address.squeeze!(' ,.')
          address.strip!
          address_without_special_symbol = address.gsub(/([\-\/,.;: ])/, '')
          if Building.where("address_without_special_symbol = ? ", address_without_special_symbol).empty?
            building = Building.create(arrival_address: address, name: company, address_without_special_symbol: address_without_special_symbol)
      		else  
      			building = Building.where("address_without_special_symbol = ? ", address_without_special_symbol).first
      		end
      		if Buildingscontract.where("building_id = ? and contract_id = ?", building.id, contract.id).empty?
            Buildingscontract.create(building_id: building.id, contract_id: contract.id)
          end
        end
     end
    end
  end

  def self.open_spreadsheet(file_path)
  #  case File.extname(file.original_filename)
  #  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
  #  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    Roo::Excel.new(file_path, nil, :ignore)
  #  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  #  else raise "Unknown file type: #{file.original_filename}"
  #  end
  end

end
