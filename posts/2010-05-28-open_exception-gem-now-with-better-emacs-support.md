---
title: "open_exception gem: now with better emacs support!"
author: Toby Crawley
layout: post
tags: [emacs, gems, rails, ruby]
disqus_identifier: "325 http://blog.tobiascrawley.net/?p=325"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I just released <a href="http://rubygems.org/gems/open_exception">v0.3.1</a> of the <a href="http://blog.tobiascrawley.net/2010/04/26/open_exception-gem-auto-open-exceptions-in-your-editor/">open_exception gem</a>. This release does a better job of handling exceptions that have been munged by Rails, and now provides a tempfile containing the full stack trace to the open command. </p>

<p>If you are using emacs, you can use the <code>:emacs_with_trace</code> open command, and get the stack trace as a navigable compilation buffer (next to || below) the source file in a split frame. For this to work, you&#x2019;ll need to add the following function to your emacs init:</p>

<script src="http://gist.github.com/417151.js?file=gistfile1.el"></script>

<p>See github for the <a href="http://github.com/tobias/open_exception">code</a> and <a href="http://github.com/tobias/open_exception/blob/master/README.md"><span class="caps">README</span></a>.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

