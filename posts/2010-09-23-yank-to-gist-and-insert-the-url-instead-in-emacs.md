---
title: "Yank to gist (and insert the url instead) in Emacs"
author: Toby Crawley
layout: post
tags: [emacs, erc, gist, irc]
disqus_identifier: "330 http://blog.tobiascrawley.net/?p=330"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>On our <a href="http://projectodd.org/">distributed team</a>, we use <a href="http://en.wikipedia.org/wiki/Internet_Relay_Chat"><span class="caps">IRC</span></a> constantly to stay in touch, and we often share gists of code/log file chunks/whatever. I use <a href="http://www.emacswiki.org/emacs/ERC"><span class="caps">ERC</span></a> as my <span class="caps">IRC </span>client, and use <a href="http://github.com/defunkt/gist.el">gist.el</a> constantly to turn content in to gists. It works really well when the content you are trying to gistify is already in an emacs buffer. You can gist an entire buffer (or a region of the buffer), and have the url to the gist on your kill-ring (clipboard) ready to yank (paste). But I often have the need to create a gist of content I&#x2019;ve copied from somewhere outside of emacs &#x2013; from a terminal, a browser window, wherever. </p>

<p>Until tonight, my workflow was to paste into a temp buffer in emacs, call <code>gist-buffer</code> to create the gist, then yank the gist url into <span class="caps">ERC.</span> This evening, I wrote <code>yank-to-gist</code> to streamline that process a bit. It takes the top of the kill-ring, inserts it into a temp buffer, creates a gist from the buffer, then inserts the url for the new gist at the point. </p>

<script src="http://gist.github.com/593091.js?file=my-defuns.el"></script>

<p>It relies on gist.el being loaded. I Currently only have it bound in erc-mode to <code>C-c y</code>.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

