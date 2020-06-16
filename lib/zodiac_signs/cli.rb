class ZodiacSigns::CLI

  BASE_PATH = "https://www.horoscope.com/zodiac-signs"

  def call
    greeting
    menu
    ending
  end

  def greeting
    puts "Welcome! Discover your strength and get ready for the day!"
  end

  def print_menu
    zodiac_signs = ZodiacSigns::Sign.scrape_index_page(BASE_PATH)
    puts "Please enter the number of your zodiac sign from the list above:"
    input = nil
    while input != "exit"
      input = gets.strip.delete "."

      zodiac = ZodiacSigns::Sign.find(input)

      print_sign(sign)

      puts "Would you like to see today's horoscope? Enter Y or N"

      input = gets.strip.downcase
      if input == "y"
        menu
      elsif input == "n"
        puts ""
        puts "Type \'menu\' to see other signs or type \'exit\' to end the app?"
          input = gets.strip.downcase
          if input == "menu"
            menu
          elsif input == "exit"
            ending
          else
            puts ""
            puts "I don't understand that answer."
            start
          end
      end

        puts "Please enter 1 - 12, or type exit."
      end
    end
  end

  def ending
    puts "Remember to tap into your power and make your day great!"
    puts "See you!"
  end

end
