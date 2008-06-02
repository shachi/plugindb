# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  #tag 補助
  def tag_input
    tag_text = "<div class='tags_title'>"
    tags = Tag.find(:all, :conditions => ['taggings_count != 0'])
    tags.each do |tag|
      tag_text << %Q{<a href="#" onclick="javascript:inj_c('#{tag.name} '); return false;">#{tag.name}</a>&nbsp;\n}
    end
    return tag_text << "\n</div>\n"
  end
  
  #==tag_lists(userid)
  def tag_lists
    tag_text = "<ul class='tag_list'>\n"
    tagitems = Item.find(:all, :order => "created_at desc", :conditions => ['flags = true'])
    if tagitems != []
      tags = tagitems[0].tags
    else
      tags = []
    end
    tagitems.each_index do |idx|
      tags += tagitems[idx].tags if idx != 0
    end
    tags.uniq!
    tags.each do |tag|
      if tag.taggings_count != 0
        tag_text << "<li"
        if tag.taggings_count == 1
          tag_text << ' class="one" '
        elsif  tag.taggings_count <= 9
          tag_text << ""
        elsif  tag.taggings_count <= 49
          tag_text << ' class="ten" '
        elsif  tag.taggings_count <= 99
          tag_text << ' class="five" '
        else
          tag_text << ' class="milion" '
        end
        tag_text << ">"
        tag_text << link_to_remote_fu( h(tag.name), :url => {:action => 'tag', :id => tag.name})
        tag_text << "</li>\n"
      end
    end
    return tag_text << "</ul>"
  end
  
  def link_to_remote_fu(name, options = {}, html_options = {})
    options[:method]    ||= 'get'
    html_options[:href] ||=  url_for(options[:url])
    link_to_function(name, remote_function(options), html_options)
  end
end
