#!/bin/env ruby
$:.unshift File.expand_path("../../gems/*/lib", __FILE__)

# Usage: redcarpet [<file>...]
# Convert one or more Markdown files to HTML and write to standard output. With
# no <file> or when <file> is '-', read Markdown source text from standard input.
if ARGV.include?('--help')
  File.read(__FILE__).split("\n").grep(/^# /).each do |line|
    puts line[2..-1]
  end
  exit 0
end

$:.map{|p| File.expand_path(p.sub("/Users/msheets/rubyinstalled", "~/Library/Application Support/TextMate/Ruby/1.8.7"))}

Dir[File.expand_path('../../gems/*/lib', __FILE__)].each do |dir|
  $:.unshift dir
end

require 'redcarpet'
require 'pygments'

css = "<style>#{Pygments.css(:style => "colorful")}</style>"

require 'redcarpet'
require 'rouge'
require 'rouge/plugins/redcarpet'

class HTMLwithCode < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
  # def block_code(code, language)
  #   language ||= 'text'
  #   Pygments.highlight(code, :lexer => language)
  # rescue
  #   Pygments.highlight(code, :lexer => 'text')
  # end
end

def markdown(text)
  renderer = HTMLwithCode.new(:hard_wrap => true, :filter_html => true)
  options = {
    :autolink            => true,
    :space_after_headers => true,
    :fenced_code_blocks  => true,
    :tables              => true,
    :strikethrough       => true,
    :footnotes           => true,
    :smart               => true,
    :hard_wrap           => true,
    :safelink            => true,
    :no_intraemphasis    => true,
  }
  Redcarpet::Markdown.new(renderer, options).render(text)
end


puts [css, markdown(ARGF.read)].join

