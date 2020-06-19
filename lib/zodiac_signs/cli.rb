class ZodiacSigns::CLI

  BASE_PATH = "https://www.horoscope.com/"

  def call
    greeting
    make_signs
    print_menu
  end

  def greeting
    puts "Welcome to Horoscope.com!".colorize(:green)
    puts "Discover your strength and get ready for the day!".colorize(:green)
  end

  def make_signs
    signs_array = ZodiacSigns::Scraper.scrape_index_page(BASE_PATH + "zodiac-signs")
    ZodiacSigns::Sign.create_from_collection(signs_array)
  end

  def print_menu
    ZodiacSigns::Sign.all.each.with_index(1) do |sign, index|
      puts "#{index.to_s.rjust(2)}. #{sign.name}: #{sign.dates}"
    end
    puts ""
    puts "Please enter the number of your zodiac sign from the list above.".colorize(:green)
    input = nil
    while input != "exit"
      input = gets.strip.delete "."
      sign = ZodiacSigns::Sign.find(input)
      print_sign(sign)
      puts "Would you like to see another sign? Y or N".colorize(:green)
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

  def add_attributes_to_signs
    ZodiacSigns::Sign.all.each do |sign|
      attributes = ZodiacSigns::Scraper.scrape_details_page(sign.url)
      sign.add_sign_attributes(attributes)
    end
  end

  def print_sign(sign)
    add_attributes_to_signs
    puts ""
    puts "---------------------- Dear #{sign.name} ----------------------".colorize(:red)
    puts ""
    puts "Symbol: #{sign.symbol} | #{sign.dates}"
    puts ""
    puts "You are #{sign.traits}.".colorize(:red)
    puts ""
    puts "Your Motto:".colorize(:green)
    puts "#{sign.motto}"
    puts ""
    puts "Your Greatest Gifts:".colorize(:green)
    puts "#{sign.gifts}"
    puts ""
    puts "Today's Horoscope:".colorize(:green)
    puts "#{sign.horoscope}"
  end

  def ending
    puts "Remember to tap into your power and make your day great!".colorize(:green)
    puts "See you!".colorize(:green)
    exit
  end

end
