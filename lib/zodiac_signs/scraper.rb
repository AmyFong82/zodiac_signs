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

    # doc.css("main").each do |sign|
        sign_details = {}
        sign_details[:symbol] = doc.css("main .header .title h4")[0].text.split(/\s[[:space:]]\|/)[0]
        sign_details[:moto] = doc.css("blockquote").text.strip
        # sign_details[:gifts] = sign.css("h3")
        # Nokogiri::HTML(doc).xpath("//h3").each do |h3|
        #   if h3.text.include? ("Greatest Gifts")
        #     sign_details[:gifts] = h3.xpath("following-sibling::p").text
        #   end
        # end

        # results = []
        #
        # Nokogiri::HTML(doc).xpath("//h3").each do |header|
        #   p = header.xpath("following-sibling::p").text
        #   results << [p]
        # end
        # gift_h3 = doc.css("h3").select{|this| this.text.include? ("Greatest Gifts")}
        doc.css("h3").each do |this|
          if this.text.include? ("Greatest Gifts")
            sign_details[:gifts] = this.next_element.text
          end
        end
        # gift_h3 = doc.xpath("//h3").select{|this| this.text.include? ("Greatest Gifts")}
        # sign_details[:gifts] = gift_h3.xpath("following-sibling::p").text

        # sign_details[:gifts] = sign.css(gift_h3).text.strip
        # news_links = page.css("a").select{|link| link['data-category'] == "news"}
        binding.pry

        sign_details[:horoscope] = sign.css(".no-events p")[1].text.strip
        signs << sign_hash
      signs
  end


    # social_links = doc.css(".social-icon-container a")
    #
    # counter = 0
    # while student_profile.length < social_links.length do
    #   if social_links[counter]["href"].include?("twitter")
    #     student_profile[:twitter] = social_links[counter]["href"]
    #   elsif social_links[counter]["href"].include?("linkedin")
    #     student_profile[:linkedin] = social_links[counter]["href"]
    #   elsif social_links[counter]["href"].include?("github")
    #     student_profile[:github] = social_links[counter]["href"]
    #   else
    #     student_profile[:blog] = social_links[counter]["href"]
    #   end
    #   counter += 1
    # end

    # student_profile[:profile_quote] = doc.css(".profile-quote").text.strip
    # student_profile[:bio] = doc.css(".bio-content.content-holder p").text.strip.first(p)
    # student_profile
  end
