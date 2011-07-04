require 'rubygems'
require 'nokogiri'

%w{ 2008 2009 2010 }.each do |year|
  Dir.glob(File.dirname(__FILE__) + "/../../old-blog/#{year}/**/index.html") do |file|
    if file !~ /feed/ && file =~ /#{year}\/(\d\d)\/(\d\d)\/(.+?)\/index.html/
      puts file
      month, day, slug = $1, $2, $3
      body = nil
      File.open(file) do |f|
        doc = Nokogiri::XML(f)
        body = doc.at_css('div.post')
      end

      title_header = body.at_css('div.padding h2:first-child')
      title = title_header.at_css('a').content
      disqus_id = $1 if body.content =~ /disqus_identifier = '(.*)';/

      tags = body.css('span.tags a').collect(&:content)

      # fix img paths
      body.css('img').each do |img|
        img['src'] = "/posts/assets/old/#{$1}" if img['src'] =~ /wp-content\/uploads\/\d*\/\d*\/(.*)$/
      end

      # ditch some of the old syntax highligher's style
      body.css('pre').each do |pre|
        pre['style'] = ''
      end
      
      # cleanup
      title_header.unlink
      body.at_css('div.postmetadata').unlink
      body.at_css('div#disqus_thread').unlink
      # kill the last three script tags
      body.css('script')[-3,3].each(&:unlink)
      # kill the disqus comments link
      body.css('a').last.unlink
      
      File.open(File.dirname(__FILE__) + "/../posts/#{year}-#{month}-#{day}-#{slug}.md", 'w') do |out|
        out.write <<-EOP
---
title: "#{title}"
author: Toby Crawley
layout: post
tags: [#{tags.join(", ")}]
disqus_identifier: "#{disqus_id}"
---

#{body.inner_html.gsub(/^[ \t]*/, '')}
EOP
      end
    end
  end
end
