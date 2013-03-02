# 
# Copyright (c) 2012-2013 by Lifted Studios.  All Rights Reserved.
# 

require 'html/pipeline'

module HTML
  class Pipeline
    # An `HTML::Pipeline` filter class that detects wiki-style links and converts them to HTML links.
    class WikiLinkFilter < Filter
      # Performs the translation and returns the updated text.
      # 
      # @return [String] Updated text with translated wiki links.
      def call
        text = html.gsub(/\[\[(.*)\|(.*)\]\]/) do |match|
          link = $1
          desc = $2

          link.gsub!(/\s+/, '_')
          desc.gsub!(/\s+/, ' ')

          "<a href=\"/#{link}\">#{desc}</a>"
        end

        text.gsub(/\[\[(.*)\]\]/) do |match|
          desc = $1
          
          link = desc.gsub(/\s+/, '_')
          desc.gsub!(/\s+/, ' ')

          "<a href=\"/#{link}\">#{desc}</a>"
        end
      end
    end
  end
end
