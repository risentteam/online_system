class Contract < ActiveRecord::Base
  belongs_to :user
  has_many :requistions
  has_many :buildingscontracts
  has_many :buildings, through: :buildingscontracts


def self.import(file)
#  spreadsheet = Roo::Spreadsheet.open(file, extension: :xls)
  if not file.nil?
    spreadsheet = open_spreadsheet(file)
    spreadsheet.default_sheet = spreadsheet.sheets[1]
    header = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = spreadsheet.row(i)
      if not row[0].nil? and Contract.where("name_contract = ? ", row[0]).empty?
      	contract = Contract.create(name_contract: row[0], company: row[2], date_of_signing: row[6], description: row[7], begin_time: row[8], end_time: row[9], comment: row[10])
      	user = User.create()
        adress = row[3].split(';')
      	adress.each do |address|
      		if Building.where("arrival_address = ? ", address).empty?
      			building = Building.create(arrival_address: address)
      		else
      			building = Building.where("arrival_address = ? ", address).first
      		end
      		Buildingscontract.create(building_id: building.id, contract_id: contract.id)
      	end
     end
#    Contract.new()
#    product = find_by_id(row["id"]) || new
#    product.attributes = row.to_hash.slice(*accessible_attributes)
#    product.save!
  	end
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::Csv.new(file.path, nil, :ignore)
  when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
end

end