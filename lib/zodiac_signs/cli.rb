class ZodiacSigns::CLI

  def call
    greeting
    menu
    ending
  end

  def greeting
    puts "Welcome! Discover your strength and get ready for the day!"
    puts "Please choose your zodiac sign by entering the number from the list below:"
  end

  def menu(from scraper)
    puts "list of 12 zodiac signs"
    input

  end

  def ending
    puts "Tap into your power and make your day great!"
  end

end
