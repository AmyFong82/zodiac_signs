require_relative "./zodiac_signs/version"
require_relative "./zodiac_signs/cli"
require_relative "./zodiac_signs/sign"
require_relative "./zodiac_signs/scraper"

require 'nokogiri'
require 'open-uri'
require 'pry'

module ZodiacSigns
  class Error < StandardError; end
  # Your code goes here...
end
