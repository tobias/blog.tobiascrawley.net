---
title: "Commenting out blocks of ruby in emacs"
author: Toby Crawley
layout: post
tags: [emacs, ruby]
disqus_identifier: "302 http://blog.tobiascrawley.net/?p=302"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I&#x2019;ve been an <a href="http://www.gnu.org/software/emacs/">emacs</a> user for 12+ years, and am ashamed to admit that I&#x2019;ve never learned <a href="http://en.wikipedia.org/wiki/Emacs_Lisp">emacs lisp</a> (yes, my last post was about emacs lisp code, but it was a copy and paste with a few changes, and I certainly didn&#x2019;t understand what it was doing). Until now, that is. I started reading the <a href="http://www.gnu.org/software/emacs/emacs-lisp-intro/">emacs lisp intro</a>, but only got about fifty pages in to it before I got the itch to write some code.</p>

<p>So here it is. Its a package that allows you to comment out a block of ruby code from a keybinding (I&#x2019;m sure there is code out there to do this already, but it was a fun learning challenge).</p>

<p>The main function is <code>comment-ruby</code>, which I have bound to <code>C-:</code>. If there is a region active, it comments out the region. If that region is less than five lines, each line is commented with  &#x2018;# &#x2018;, otherwise the entire region is wrapped in <code>=begin...=end</code>. If the region is not active, the current line is commented out with &#x2018;# &#x2018;.</p>

<p>After a region has been commented out, the point (cursor) is set to the line above or below the region, depending on whether the point was at the beginning or end of the region when called.</p>

<p>Here is the code &#x2013; it probably isn&#x2019;t idiomatic lisp. If you have any suggestions on improving the code or making it more idiomatic, please let me know!</p>

<script src="http://gist.github.com/306302.js?file=comment-ruby.el"></script>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

