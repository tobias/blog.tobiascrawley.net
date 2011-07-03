---
title: "RAILS_ROOT/app Organization"
author: Toby Crawley
layout: post
tags: [organization, rails, ruby, tips]
disqus_identifier: "211 http://blog.tobiascrawley.net/?p=211"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>As an app grows, so does the amount of files in <code>app/models</code>. Here is a simple tip to help reduce the clutter: move mailers, observers, and sweepers out of <code>app/models</code> into <code>app/mailers</code>, <code>app/observers</code>, and <code>app/sweepers</code>, respectively. For rails to still load them, you will need to modify <code>config/environment.rb</code>:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#008000; font-style:italic;"># clean up app/models a bit</span>
<span style="color:#006600; font-weight:bold;">%</span>w<span style="color:#006600; font-weight:bold;">{</span>mailers observers sweepers<span style="color:#006600; font-weight:bold;">}</span>.<span style="color:#9900CC;">each</span> <span style="color:#9966CC; font-weight:bold;">do</span> <span style="color:#006600; font-weight:bold;">|</span>dir<span style="color:#006600; font-weight:bold;">|</span>
config.<span style="color:#9900CC;">load_paths</span> <span style="color:#006600; font-weight:bold;">&lt;&lt;</span> <span style="color:#996600;">"#{RAILS_ROOT}/app/#{dir}"</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>




<p>As a bonus, you can now automatically record your observers with <code>ActiveRecord</code> instead of having to add them individually in <code>environment.rb</code>:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  config.<span style="color:#9900CC;">active_record</span>.<span style="color:#9900CC;">observers</span> = <span style="color:#CC00FF; font-weight:bold;">Dir</span>.<span style="color:#9900CC;">glob</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">"#{RAILS_ROOT}/app/observers/*.rb"</span><span style="color:#006600; font-weight:bold;">)</span>.<span style="color:#9900CC;">collect</span> <span style="color:#9966CC; font-weight:bold;">do</span> <span style="color:#006600; font-weight:bold;">|</span>filename<span style="color:#006600; font-weight:bold;">|</span>
filename.<span style="color:#CC0066; font-weight:bold;">split</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">'/'</span><span style="color:#006600; font-weight:bold;">)</span>.<span style="color:#9900CC;">last</span>.<span style="color:#CC0066; font-weight:bold;">split</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">'.'</span><span style="color:#006600; font-weight:bold;">)</span>.<span style="color:#9900CC;">first</span>.<span style="color:#9900CC;">to_sym</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>




One issue with this reorganization is that the generators will continue to create mailers, observers, and sweepers in <code>app/models</code>. For me, that is not a big deal &#x2013; I don&#x2019;t create them often, and manually move them after generation. I suspect it would be trivial to adjust the generators to use the new path, but have not looked in to it. <br></br>
</div>				


<!-- end .postmetadata -->













