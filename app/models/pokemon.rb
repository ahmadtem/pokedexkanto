class Pokemon < ApplicationRecord
  def self.search(search)
    if search
      search = '%'+search+'%'
      Pokemon.where('name LIKE ?', search).all
    else
      Pokemon.all
    end
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |item|
        csv << item.attributes.values_at(*column_names)
      end
    end
  end
end
