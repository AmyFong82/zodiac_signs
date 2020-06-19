class ZodiacSigns::Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    signs = []

    doc.css(".swipe-container.text-center a").each do |sign|
        sign_hash= {}
        sign_hash[:name] = sign.css("h3").text.split(/\s/)[0]
        sign_hash[:dates] = sign.css("p").first.text.strip
        sign_hash[:url] = sign.attributes["href"].value
        sign_hash[:traits] = sign.css(".no-events p")[1].text.strip
        signs << sign_hash
      end
      signs
    end

  def self.scrape_details_page(details_url)
    doc = Nokogiri::HTML(open(details_url))

    sign_details = {}
    sign_details[:symbol] = doc.css("main .header .title h4")[0].text.split(/\s[[:space:]]\|/)[0]
    sign_details[:motto] = doc.css("blockquote").text.strip

    doc.css("h3").each do |this|
      if this.text.include? ("Greatest Gifts")
        sign_details[:gifts] = this.next_element.text
      end
    end

    doc.css(".btn-skin.btn-purple").each do |link|
      if link.text.include? ("today's horoscope")
         horoscope_page = Nokogiri::HTML(open(ZodiacSigns::CLI::BASE_PATH + link["href"]))
         sign_details[:horoscope] = horoscope_page.css(".main-horoscope p")[0].text
      end
    end

    sign_details
  end
end
