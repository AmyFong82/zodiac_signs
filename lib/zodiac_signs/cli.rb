class ZodiacSigns::CLI

  def call
    greeting
    menu
    ending
  end

  def greeting
    puts "Welcome! Discover your strength and get ready for the day!"
  end

  def menu()
    puts "12 Zodiac Signs"
    puts "Please enter the number of your zodiac sign from the list above:"
    input = nil
    while input != "exit"
      input = gets.strip.delete "."
      case input
      when "1"
        puts "Aries"
      when "2"
        puts "Taurus"
      when "3"
        puts "Gemini"
      when "4"
        puts "Cancer"
      when "5"
        puts "Leo"
      when "6"
        puts "Virgo"
      when "7"
        puts "Libra"
      when "8"
        puts "Scorpio"
      when "9"
        puts "Sagittarius"
      when "10"
        puts "Capricorn"
      when "11"
        puts "Aquarius"
      when "12"
        puts "Pisces"
      else
        puts "Please enter 1 - 12, or type exit."
      end
    end
  end

  def ending
    puts "Tap into your power and make your day great!"
  end

end
