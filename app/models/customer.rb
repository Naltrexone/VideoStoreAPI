class Customer < ApplicationRecord
  validates :name, presence: true
  validates :registered_at, presence: true
  validates :address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :postal_code, presence: true
  validates :phone, presence: true

  has_many :rentals

  def movies_checked_out_count
    total = 0
    num_out = 0
    num_in = 0
    self.rentals.each do |rental|
     if rental.status == "out"
       num_out += 1
     elsif rental.status == "in"
       num_in += 1
     end
    end
    return (movies_count = num_out - num_in)
 end
end
