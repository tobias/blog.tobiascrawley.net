---
title: "Changing the Get Satisfaction widget tab text"
author: Toby Crawley
layout: post
tags: []
disqus_identifier: "155 http://blog.tobiascrawley.net/?p=155"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>We recently added the <a href="http://getsatisfaction.com/widgets">Get Satisfaction</a> widget to an app, and it was darn easy (we used the overlay widget). It allows you to customize the location and the background color of the tab, but not the text (the default is &#x2018;Feedback&#x2019;). The customer wanted the text to be &#x2018;Support&#x2019;, so I thought I&#x2019;d share the solution with you in case you want to make the same change.</p>

<p>The tab uses a background image for the text, so I grabbed a copy and changed the text (its on a grey background div here so you can see it, since its white text with a transparent background):</p>

<div style="background-color: #aaa; width: 120px; height: 143px;padding:3px;">
<img src="/posts/assets/old/support_trans_tab.png" alt="support_trans_tab" title="support_trans_tab" width="102" height="140" class="aligncenter size-full wp-image-156"></img>
</div>

<p>and here is the css to apply it (the <code>body</code> in the selector makes it more specific to override the rule from Get Satisfaction&#x2019;s style; alternatively, you can use <code>!important</code> on the rule):</p>



<pre code="css" style="">body a#fdbk_tab {
    background-image: url(/path/to/support_trans_tab.png);
}</pre>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

