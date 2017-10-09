module ApplicationHelper

  # Provides a full title depending on whether a page specific title is given
  def full_title(page_title = '')
    if page_title.empty?
      "Gossip.io"
    else
      "#{page_title} | Gossip.io"
    end
  end
end
