class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    self.limit(5)
  end

  def self.dinghy
    self.where("length < 20")
  end

  def self.ship
    self.where("length >= 20")
  end

  def self.last_three_alphabetically
    self.order(name: :desc).limit(3)
  end

  def self.without_a_captain
    self.where(captain_id: nil)
  end

  def self.sailboats
    classification = Classification.where(name: "Sailboat")
    #binding.pry
    boats = BoatClassification.select(:boat_id).where(classification_id: classification.first.id)
    self.where(id: boats)
  end

  def self.catamarans
    classification = Classification.where(name: "Catamaran")
    #binding.pry
    boats = BoatClassification.select(:boat_id).where(classification_id: classification.first.id)
    self.where(id: boats)
  end

  def self.motorboats
    classification = Classification.where(name: "Motorboat")
    #binding.pry
    boats = BoatClassification.select(:boat_id).where(classification_id: classification.first.id)
    self.where(id: boats)
  end

  def self.with_three_classifications
    self.where(id: self.all.map{|boat| boat.id if boat.classifications.length >= 3})
  end
end
