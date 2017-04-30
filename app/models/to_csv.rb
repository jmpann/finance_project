class ToCsv < ApplicationRecord

  def self.create_csv_file
    # attributes = %w{Holding Amount}
    # all
    #
    # CSV.generate(headers: true) do |csv|
    #   csv << attributes
    #
    #   all.each do |user|
    #     csv << attributes.map{ |attr| user.send(attr) }
    #   end
    # end
  end

end
