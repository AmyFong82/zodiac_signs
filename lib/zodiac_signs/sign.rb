class ZodiacSigns::Sign
  attr_accessor :name, :dates, :traits, :url, :symbol, :motto, :gifts, :horoscope

  @@all = []

  def initialize(sign_hash)
    sign_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(signs_array)
    signs_array.each do |sign|
      ZodiacSigns::Sign.new(sign)
    end
  end

  def add_sign_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
    self
  end

  def self.all
    @@all
  end

  def self.find(id)
    index = id.to_i - 1
    self.all[index]
  end


end
