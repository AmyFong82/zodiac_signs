class ZodiacSigns::CLI

  BASE_PATH = "https://www.horoscope.com/zodiac-signs"

  def call
    greeting
    print_menu
    ending
  end

  def greeting
    puts "Welcome! Discover your strength and get ready for the day!"
  end

  def make_signs
    signs_array = ZodiacSigns::Scraper.scrape_index_page(BASE_PATH)
    ZodiacSigns::Sign.create_from_collection(signs_array)
  end

  def add_attributes_to_signs
    ZodiacSigns::Sign.all.each do |sign|
      attributes = ZodiacSigns::Scraper.scrape_details_page(BASE_PATH + sign.url)
      sign.add_sign_attributes(attributes)
    end
  end


  def print_menu
    make_signs
    counter = 
    puts ""
    puts "Please enter the number of your zodiac sign from the list above:"
    input = nil
    while input != "exit"
      input = gets.strip.delete "."
      zodiac = ZodiacSigns::Sign.find(input)
      print_sign(sign)
      puts "Would you like to see another sign? Y or N"
      input = gets.strip.downcase
      if input == "y"
        print_menu
      elsif input == "n"
        ending
      elsif input == "exit"
        ending
      else
        puts ""
        puts "I don't understand that answer."
        puts "Please type \'Y\' for to see the main menu, or type \'N\' to exit."
      end
    end
  end

  def ending
    puts "Remember to tap into your power and make your day great!"
    puts "See you!"
  end

end
