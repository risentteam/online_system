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
  
def self.import(file_path)
#  spreadsheet = Roo::Spreadsheet.open(file, extension: :xls)
    flash[:info] = "Начал обработку файла"
    spreadsheet = open_spreadsheet(file_path)
    spreadsheet.default_sheet = spreadsheet.sheets[0]
    (1..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      if not row[1].nil? and row[1]!='ИТОГО' and Contract.where("name_contract = ? ", row[1].to_s).empty?
      	if not row[2].nil?
          company = row[2]
        else
          company = row[3]
        end
        btime= case row[5]
          when 'с января' then '01.01.2015'
          when 'c февраля' then '01.02.2015'
          when 'с марта' then '01.03.2015'
          when 'с апреля' then '01.03.2015'
          when 'с мая' then '01.04.2015'
          when 'c июня' then '01.05.2015'
          when 'c июля' then '01.07.2015'
          when 'с августа' then '01.08.2015'
          when 'с сентября' then '01.09.2015'
          when 'с октября' then '01.10.2015'
          when 'с ноября' then '01.11.2015'
          when 'c декабря' then '01.12.2015'
          else row[5]
        end
        etime= case row[8]
          when 12 then '31.12.2015'
          when 11 then '30.11.2015'
          when 10 then '31.10.2015'
          when 9 then '30.9.2015'
          when 8 then '31.8.2015'
          when 7 then '31.7.2015'
          when 6 then '30.6.2015'
          when 5 then '31.5.2015'
          when 4 then '30.4.2015'
          when 3 then '31.3.2015'
          when 2 then '28.2.2015'
          when 1 then '31.1.2015'
        end
        contract = Contract.create(name_contract: row[1].to_s, date_of_signing: row[6], description: row[7], begin_time: btime, end_time: etime, comment: row[9])
        adress = row[4].split(';')
      	adress.each do |address|
      		  address.squeeze!(' ')
            address.strip!
          if Building.where("arrival_address = ? ", address).empty?
      			building = Building.create(arrival_address: address, name: company)
      		else  
      			building = Building.where("arrival_address = ? ", address).first
      		end
      		if Buildingscontract.where("building_id = ? and contract_id = ?", building.id, contract.id).empty?
            Buildingscontract.create(building_id: building.id, contract_id: contract.id)
          end
      	end
     end
    if not row[1].nil? and row[1]!='ИТОГО' and not Contract.where("name_contract = ?", row[1].to_s).empty?
        contract = Contract.where("name_contract = ? ", row[1].to_s).first
        if not row[2].nil?
          company = row[2]
        else
          company = row[3]
        end
        btime= case row[5]
          when 'с января' then '01.01.2015'
          when 'c февраля' then '01.02.2015'
          when 'с марта' then '01.03.2015'
          when 'с апреля' then '01.03.2015'
          when 'с мая' then '01.04.2015'
          when 'c июня' then '01.05.2015'
          when 'c июля' then '01.07.2015'
          when 'с августа' then '01.08.2015'
          when 'с сентября' then '01.09.2015'
          when 'с октября' then '01.10.2015'
          when 'с ноября' then '01.11.2015'
          when 'c декабря' then '01.12.2015'
          else row[5]
        end
        etime= case row[8]
          when 12 then '31.12.2015'
          when 11 then '30.11.2015'
          when 10 then '31.10.2015'
          when 9 then '30.9.2015'
          when 8 then '31.8.2015'
          when 7 then '31.7.2015'
          when 6 then '30.6.2015'
          when 5 then '31.5.2015'
          when 4 then '30.4.2015'
          when 3 then '31.3.2015'
          when 2 then '28.2.2015'
          when 1 then '31.1.2015'
        end
        contract.update_attributes(name_contract: row[1].to_s, date_of_signing: row[6], description: row[7], begin_time: btime, end_time: etime, comment: row[9])
        adress = row[4].split(';')
        adress.each do |address|
          address.squeeze!(' ')
          address.strip!
          if Building.where("arrival_address = ? ", address).empty?
            building = Building.create(arrival_address: address, name: company)
          else
            building = Building.where("arrival_address = ? ", address).first
          end
          if Buildingscontract.where("building_id = ? and contract_id = ?", building.id, contract.id).empty?
            Buildingscontract.create(building_id: building.id, contract_id: contract.id)
          end
          end
     end
#    Contract.new()
#    product = find_by_id(row["id"]) || new
#    product.attributes = row.to_hash.slice(*accessible_attributes)
#    product.save!
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
