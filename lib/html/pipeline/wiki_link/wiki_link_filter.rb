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

          link = convert_whitespace(link)
          desc = collapse_whitespace(desc)

          "<a href=\"/#{link}\">#{desc}</a>"
        end

        text.gsub(/\[\[(.*)\]\]/) do |match|
          desc = $1
          
          link = convert_whitespace(desc)
          desc = collapse_whitespace(desc)

          "<a href=\"/#{link}\">#{desc}</a>"
        end
      end

      private

      # Collapses multiple whitespace characters into a single space.
      # 
      # @param text Text within which to collapse whitespace.
      # @return Text with collapsed whitespace.
      def collapse_whitespace(text)
        text.gsub(/\s+/, ' ')
      end

      # Converts spaces to underscores in the given text.
      # 
      # @param text Text within which to replace spaces.
      # @return Text with spaces replaced with underscores.
      def convert_whitespace(text)
        text.gsub(/\s+/, '_')
      end
    end
  end
end
