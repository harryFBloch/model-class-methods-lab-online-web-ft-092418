class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    catamarans = Boat.catamarans
    self.where(id: catamarans.select(:captain_id))
  end

  def self.sailors
    self.where(id: Boat.sailboats.select(:captain_id))
  end

  def self.talented_seafarers
    sailboats = Boat.sailboats.map {|boat| boat.captain_id}
    motorboats = Boat.motorboats.map {|boat| boat.captain.id}
    captains = []
    sailboats.each {|captain_id|
      #binding.pry
      captains << captain_id if motorboats.include?(captain_id)
    }
    self.where(id: captains)
  end

  def self.non_sailors
    sailboats = Boat.sailboats.map {|boat| boat.captain_id}
    self.where.not(id: sailboats)
  end
end
