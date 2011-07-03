---
title: "Collapsing the Lighthouse ticket form"
author: Toby Crawley
layout: post
tags: [lighthouse]
disqus_identifier: "120 http://blog.tobiascrawley.net/?p=120"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>We&#x2019;ve been using lighthouse for the last few months to track bugs/features for <a href="http://restaurantzite.com/">RestaurantZite</a>. Overall, its a pretty good bug tracker; not great, but good. One thing that bothers me about it is the expansive nature of the ticket entry/edit form:</p>

<p><img src="/posts/assets/old/before.png" alt="before" title="before" width="523" height="333" class="aligncenter size-full wp-image-121"></img></p>

<p>Usually, my browser is sized to where the submit button is off of the bottom of the screen, as well as the tag input. The description box is larger than it needs to be (for our use anyway, since we are describing bugs for ourselves and can usually capture it in sentence or two), and the whitespace to the right of the description seems wasted. </p>

<p>To help with this, I wrote a custom stylesheet that turns the above form into:</p>

<p><img src="/posts/assets/old/after-1.png" alt="after" title="after" width="520" height="238" class="aligncenter size-full wp-image-128"></img></p>

<p>Its not perfect, but works for me. I compacted the header and the subtab row as well, which will be reflected on all of the pages. I also compacted the ticket view page (which has this form at the bottom for updates) to reduce its vertical space usage.</p>

<p>The css is available for Firefox on <a href="http://userstyles.org/styles/14319">userstyles.org</a> for the <a href="https://addons.mozilla.org/en-US/firefox/addon/2108">Stylish</a> plugin, or as a <a href="http://gist.github.com/55066">gist</a>. I haven&#x2019;t tried it in Safari or an <span class="caps">SSB, </span>so let me know how it works or what changes you had to make if you do.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

