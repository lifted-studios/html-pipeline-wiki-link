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
        text = html.gsub(/\[\[(.*)\|(.*)\]\]/, '<a href="/\1">\2</a>')
        text.gsub(/\[\[(.*)\]\]/, '<a href="/\1">\1</a>')
      end
    end
  end
end
