# 
# Copyright (c) 2012-2013 by Lifted Studios.  All Rights Reserved.
# 

require 'html/pipeline'

module HTML
  class Pipeline
    # An `HTML::Pipeline` filter class that detects wiki-style links and converts them to HTML links.
    class WikiLinkFilter < Filter
      # Initializes a new instance of the `WikiLinkFilter` class.
      #
      # @param doc     Document to filter.
      # @param context Parameters for the filter.
      # @param result  Results extracted from the filter.
      def initialize(doc, context = nil, result = nil)
        super(doc, context, result)

        @base_url = '/'
        @space_replacement = '_'
        
        if context
          @base_url = context[:base_url] if context[:base_url]
          @space_replacement = context[:space_replacement] if context[:space_replacement]
        end
      end

      # Performs the translation and returns the updated text.
      # 
      # @return [String] Updated text with translated wiki links.
      def call
        html.gsub(/\[\[([^|]*)(\|(.*))?\]\]/) do
          link = $1
          desc = $3 ? $3 : $1

          link = convert_whitespace(link)
          desc = collapse_whitespace(desc)

          "<a href=\"#{@base_url}#{link}\">#{desc}</a>"
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
        text.gsub(/\s+/, @space_replacement)
      end
    end
  end
end
