xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title h("pluginDB")
    xml.link url_for(:only_path => false, :controller => 'homes', :action => 'index')
    xml.description h("pluginDB")
    @items.each do |item|
      xml.item do
        xml.title item.name
        xml.link url_for(:only_path => false, :controller => 'homes', :action => 'show', :id => item.id)
        xml.description simple_format(item.description)
        xml.pubDate CGI.rfc1123_date(item.created_at)
        xml.guid url_for(:only_path => false, :controller => 'homes', :action => 'show', :id => item.id)
      end
    end
  end
end