[![Build Status](https://travis-ci.org/lifted-studios/html-pipeline-cite.png?branch=master)](https://travis-ci.org/lifted-studios/html-pipeline-cite)

# HTML::Pipeline WikiLink Gem

An HTML::Pipeline filter for handling WikiMedia-style wiki links.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'html-pipeline-wiki-link'
```

And then execute:

```sh
$ bundle
```

Or install it yourself as:

```sh
$ gem install html-pipeline-wiki-link
```

## Usage

This library is designed as an extension of the [HTML::Pipeline]() system for creating pipelines of text conversions.  It can work on its own or in conjunction with other filters descended from `HTML::Pipeline::Filter`.

To use this filter on its own:

```ruby
require 'html/pipeline/wiki_link'

filter = HTML::Pipeline::WikiLinkFilter.new('Some text with a [[Link]] in it.')
filter.call
```

Filters can be combined into a pipeline which causes each filter to hand its output to the next filter's input.  For example, you could support wiki links in markdown by creating a pipeline like this:

```ruby
pipeline = HTML::Pipeline.new [
  HTML::Pipeline::MarkdownFilter,
  HTML::Pipeline::WikiLinkFilter
]

result = pipeline.call <<-CODE
This is some **Markdown** with a [[Link]] in it!
CODE
```

## Troubleshooting

## Development

To see what has changed in recent versions of Lifted Wiki, see the [CHANGELOG](https://github.com/lifted-studios/html-pipeline-wiki-link/blob/master/CHANGELOG.md).

## Core Team Members

* [Lee Dohm](https://github.com/lee-dohm/)

## Resources

<!-- ### Other questions

Feel free to chat with the Lifted Wiki core team (and many other users) on IRC in the  [#project](irc://irc.freenode.net/project) channel on Freenode, or via email on the [Project mailing list]().
 -->

## Copyright

Copyright © 2013 Lee Dohm, Lifted Studios. See [LICENSE](https://github.com/lifted-studios/html-pipeline-wiki-link/blob/master/LICENSE.md) for details.

Project is a member of the [OSS Manifesto](http://ossmanifesto.com/).
