# 
# Copyright (c) 2012-2013 by Lifted Studios.  All Rights Reserved.
# 

gem 'minitest'

require 'minitest/spec'
require 'minitest/autorun'

require 'html/pipeline/wiki_link'
require 'nokogiri'

describe HTML::Pipeline::WikiLinkFilter do
  # Creates a new `WikiLinkFilter` object.
  # 
  # @param text Text for the filter to parse.
  # @param context Context object to pass to the constructor. 
  # @return [HTML::Pipeline::WikiLinkFilter] Newly created filter object.
  def new_filter(text, context = {})
    HTML::Pipeline::WikiLinkFilter.new(text, context)
  end

  it 'can be instantiated' do
    filter = new_filter('Just some sample text')

    filter.wont_be_nil
  end

  it 'converts a normal wiki link' do
    filter = new_filter('[[Link]]')

    text = filter.call

    text.must_equal '<a href="/Link">Link</a>'
  end

  it 'converts a wiki link with a description' do
    filter = new_filter('[[Link|Description]]')

    text = filter.call

    text.must_equal '<a href="/Link">Description</a>'
  end

  it 'converts a wiki link with spaces to use underscores in the href' do
    filter = new_filter('[[A Link With Spaces]]')

    text = filter.call

    text.must_equal '<a href="/A_Link_With_Spaces">A Link With Spaces</a>'
  end

  it 'converts a wiki link with spaces in the link to use underscores in the href' do
    filter = new_filter('[[A Link With Spaces|A Description With Spaces]]')

    text = filter.call

    text.must_equal '<a href="/A_Link_With_Spaces">A Description With Spaces</a>'    
  end

  it 'converts a link with multiple spaces into one underscore and coalesces them in the description' do
    filter = new_filter('[[Many       Spaces]]')

    text = filter.call

    text.must_equal '<a href="/Many_Spaces">Many Spaces</a>'    
  end

  it 'coalesces spaces in both link and description' do
    filter = new_filter('[[Many     Spaces|Many     Spaces]]')

    text = filter.call

    text.must_equal '<a href="/Many_Spaces">Many Spaces</a>'
  end

  it 'replaces spaces with other characters when given a :space_replacement parameter' do
    filter = new_filter('[[A Link With Spaces]]', :space_replacement => '*')

    text = filter.call

    text.must_equal '<a href="/A*Link*With*Spaces">A Link With Spaces</a>'
  end

  it 'must urlencode special characters in the link but not in the description' do
    filter = new_filter('[[{}\]]')

    text = filter.call

    text.must_equal '<a href="/%7B%7D%5C">{}\</a>'
  end

  it 'must strip whitespace from the ends of a link' do
    filter = new_filter('[[   Link   ]]')

    text = filter.call

    text.must_equal '<a href="/Link">Link</a>'
  end

  it 'must strip whitespace from the ends of a description' do
    filter = new_filter('[[Link|   Description   ]]')

    text = filter.call

    text.must_equal '<a href="/Link">Description</a>'
  end

  it 'prepends the link with another string when given a :base_url parameter' do
    filter = new_filter('[[Link]]', :base_url => '/foo/bar/')

    text = filter.call

    text.must_equal '<a href="/foo/bar/Link">Link</a>'
  end

  it 'properly joins the base_url with the link' do
    filter = new_filter('[[Link]]', :base_url => 'foo/bar')

    text = filter.call

    text.must_equal '<a href="foo/bar/Link">Link</a>'
  end

  it 'replaces with underscores when nil is given as a space replacement' do
    filter = new_filter('[[A Link With Spaces]]', :space_replacement => nil)

    text = filter.call

    text.must_equal '<a href="/A_Link_With_Spaces">A Link With Spaces</a>'
  end

  it 'uses a single forward slash when nil is given as a base URL' do
    filter = new_filter('[[Link]]', :base_url => nil)

    text = filter.call

    text.must_equal '<a href="/Link">Link</a>'
  end

  it 'converts two links on the same line into two links, not one big one with brackets inside' do
    filter = new_filter('[[Link One]] and [[Link Two]]')

    text = filter.call

    text.must_equal '<a href="/Link_One">Link One</a> and <a href="/Link_Two">Link Two</a>'
  end

  it 'converts two links with descriptions into two links' do
    filter = new_filter('[[Link|Link One]] and [[Link|Link Two]]')

    text = filter.call

    text.must_equal '<a href="/Link">Link One</a> and <a href="/Link">Link Two</a>'
  end
end
