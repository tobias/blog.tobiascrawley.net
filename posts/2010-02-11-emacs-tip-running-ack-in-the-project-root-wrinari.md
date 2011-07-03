---
title: "Emacs tip: running ack in the project root w/rinari"
author: Toby Crawley
layout: post
tags: [emacs, rails, tips]
disqus_identifier: "292 http://blog.tobiascrawley.net/?p=292"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>This post covers how to combine the awesomeness of <a href="http://betterthangrep.com/">ack</a> with <a href="http://rinari.rubyforge.org/">rinari</a> in emacs to run ack in the project root by default. (If you aren&#x2019;t using ack, definitely check it out for searching your codebase. If you aren&#x2019;t using emacs, this post isn&#x2019;t going to convince you to switch). </p>

<p>I&#x2019;ve been using <a href="http://www.rooijan.za.net/">Kim van Wyk&#x2019;s</a> <a href="http://www.rooijan.za.net/?q=ack_el">ack.el</a> for a few months now, but was annoyed that I had to tell it the directory where to run ack, when in most cases I wanted it to run in the root of my Rails app. So I copied the <code>ack</code> function from ack.el and made one that only asks for the search pattern, then runs in the root of the app (provided by rinari&#x2019;s <code>rinari-root</code> function). I then bound that function to <code>C-c f a</code>. </p>

<p>Here is the code:<br></br>
<script src="http://gist.github.com/301205.js?file=ack-in-project.el"></script></p>

<p><strong>Note:</strong> you will need <a href="http://rinari.rubyforge.org/">rinari</a> and <a href="http://www.rooijan.za.net/?q=ack_el">ack.el</a> loaded, and <a href="http://betterthangrep.com/">ack</a> will need to be in your path.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

