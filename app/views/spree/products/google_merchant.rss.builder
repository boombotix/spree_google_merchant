xml.instruct! :xml, :version=>"1.0", :encoding=>"UTF-8"

xml.rss "version" => "2.0", "xmlns:g" => "http://base.google.com/ns/1.0" do
  xml.channel do
    xml.title feed_title
    xml.description feed_description

    xml.link production_domain

    @items.each do |item|
      locals = { variant: (include_variants? ? item : item.master) }
      xml.item do
        xml << render(partial: 'product_attributes', locals: locals)
      end
    end
  end
end
