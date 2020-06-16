class ZodiacSigns::Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    signs = []

    doc.css(".swipe-container.text-center a").each do |sign|
      sign_hash= {}
      sign_hash[:name] = sign.css("h3").text.strip.split(/\s/)[0]
      sign_hash[:dates] = sign.css("p").first.text.strip
      sign_hash[:url] = sign.css("a")
      binding.pry

      sign_hash[:traits] = sign.css("a").first['href']
      signs << sign_hash
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student_profile = {}
    social_links = doc.css(".social-icon-container a")

    counter = 0
    while student_profile.length < social_links.length do
      if social_links[counter]["href"].include?("twitter")
        student_profile[:twitter] = social_links[counter]["href"]
      elsif social_links[counter]["href"].include?("linkedin")
        student_profile[:linkedin] = social_links[counter]["href"]
      elsif social_links[counter]["href"].include?("github")
        student_profile[:github] = social_links[counter]["href"]
      else
        student_profile[:blog] = social_links[counter]["href"]
      end
      counter += 1
    end

    student_profile[:profile_quote] = doc.css(".profile-quote").text.strip
    student_profile[:bio] = doc.css(".bio-content.content-holder p").text.strip.first(p)
    student_profile
  end

end
