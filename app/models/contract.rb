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
            '01.01.2015'
          when 'c февраля'
            '01.02.2015'
          when 'с марта'
            '01.03.2015'
          when 'с апреля'
            '01.03.2015'
          when 'с мая'
            '01.04.2015'
          when 'c июня'
            '01.05.2015'
          when 'c июля'
            '01.07.2015'
          when 'с августа'
            '01.08.2015'
          when 'с сентября'
            '01.09.2015'
          when 'с октября'
            '01.10.2015'
          when 'с ноября'
            '01.11.2015'
          when 'c декабря'
            '01.12.2015'
          else begin_time_in_russian
    end
  end

  def self.parse_end_time(end_month)
    case end_month
          when 12
            '31.12.2015'
          when 11
            '30.11.2015'
          when 10
            '31.10.2015'
          when 9
            '30.9.2015'
          when 8
            '31.8.2015'
          when 7
            '31.7.2015'
          when 6
            '30.6.2015'
          when 5
            '31.5.2015'
          when 4
            '30.4.2015'
          when 3
            '31.3.2015'
          when 2
            '28.2.2015'
          when 1
            '31.1.2015'
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
          address_without_special_symbol = a.gsub(/([\-\/,.;: ])/, '')
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
