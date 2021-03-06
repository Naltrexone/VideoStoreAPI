class Movie < ApplicationRecord
  validates :title, presence: true
  validates :overview, presence: true
  validates :release_date, presence: true
  validates :inventory, presence: true, numericality: { only_integer: true, greater_than: -1 }

  has_many :rentals

  def available_inventory
    num_out = 0

    self.rentals.each do |rental|
      if rental.status == "out"
        num_out += 1
      end
    end
    return self.inventory - num_out
  end

end
