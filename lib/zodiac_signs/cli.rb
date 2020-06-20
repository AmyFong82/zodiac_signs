class ZodiacSigns::CLI

  BASE_PATH = "https://www.horoscope.com/"

  def call
    greeting
    make_signs
    print_menu
    ask_for_input
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
  end

  def ask_for_input
    puts "Please enter number (1-12) from the list above, or type exit to quit.".colorize(:green)
    input = gets.strip.delete "."
    while input.to_i.between?(1,12)
      sign = ZodiacSigns::Sign.find(input)
      print_sign(sign)
      puts "Would you like to see another sign? Y or N".colorize(:green)
      input = gets.strip.downcase
      until input == "y" or input == "n"
        puts ""
        puts "I don't understand that answer."
        puts "Please type \'Y\' for to see the main menu, or type \'N\' to exit."
        input = gets.strip.downcase
      end
      if input == "y"
        print_menu
      else
        ending
      end
      if input.strip.downcase == "exit"
        puts "Have a great day!"
        puts "See you!"
      else
        ask_for_input
      end
    end

  end

  def add_attributes_to_sign(sign)
      attributes = ZodiacSigns::Scraper.scrape_details_page(sign.url)
      sign.add_sign_attributes(attributes)
  end
  # def add_attributes_to_signs
  #   ZodiacSigns::Sign.all.each do |sign|
  #     attributes = ZodiacSigns::Scraper.scrape_details_page(sign.url)
  #     sign.add_sign_attributes(attributes)
  #   end
  # end

  def print_sign(sign)
    add_attributes_to_sign(sign)
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
    puts ""
  end

  def ending
    puts "Remember to tap into your power and make your day great!".colorize(:green)
    puts "See you!".colorize(:green)
    exit
  end

end
