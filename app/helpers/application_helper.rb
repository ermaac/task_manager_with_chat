# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = '')
    base_title = 'Trellogram'
    return "#{page_title} | #{base_title}" unless page_title.empty?
    base_title
  end
end
