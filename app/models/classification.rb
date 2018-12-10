class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications


  def self.my_all
    self.where("")
  end

  def self.longest
    longest_boat = Boat.order(length: :desc).limit(1).first
    longest_boat.classifications
  end
end
