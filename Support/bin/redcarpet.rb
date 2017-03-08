#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

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

class HTMLwithPygments < Redcarpet::Render::HTML
  def block_code(code, language)
    language ||= 'text'
    Pygments.highlight(code, :lexer => language)
  rescue
    Pygments.highlight(code, :lexer => 'text')
  end
end

def markdown(text)
  renderer = HTMLwithPygments.new(:hard_wrap => true, :filter_html => true)
  options = {
    :autolink            => true,
    :space_after_headers => true,
    :fenced_code_blocks  => true,
    :tables              => true,
    :strikethrough       => true,
    :smart               => true,
    :hard_wrap           => true,
    :safelink            => true,
    :no_intraemphasis    => true,
  }
  Redcarpet::Markdown.new(renderer, options).render(text)
end


puts [css, markdown(ARGF.read)].join

