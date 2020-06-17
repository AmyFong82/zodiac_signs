class ZodiacSigns::Sign
  attr_accessor :name, :dates, :traits, :url, :symbol, :motto, :acronym, :gifts, :horoscope

  @@all = []

  def initialize(sign_hash)
    sign_hash.each {|key, value| self.send(("#{key}="), value)}
    @@all << self
  end

  def self.create_from_collection(signs_array)
    students_array.each do |student|
      Student.new(student)
    end
  end

  def add_student_attributes(attributes_hash)
    attributes_hash.each {|key, value| self.send(("#{key}="), value)}
    self
  end

  def self.all
    @@all
  end



  def make_students
  students_array = Scraper.scrape_index_page(BASE_PATH + 'index.html')
  Student.create_from_collection(students_array)
end

def add_attributes_to_students
  Student.all.each do |student|
    attributes = Scraper.scrape_profile_page(BASE_PATH + student.profile_url)
    student.add_student_attributes(attributes)
  end
end


end
