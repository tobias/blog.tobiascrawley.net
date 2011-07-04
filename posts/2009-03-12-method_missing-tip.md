---
title: "method_missing tip"
author: Toby Crawley
layout: post
tags: [gotcha, ruby]
disqus_identifier: "150 http://blog.tobiascrawley.net/?p=150"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>When using ruby&#x2019;s <code>method_missing</code>, don&#x2019;t alter the <code>method</code> parameter before calling <code>super</code> (you are calling <code>super</code>, aren&#x2019;t you?). Otherwise, you will get a very clear exception:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="">  <span style="color:#CC00FF; font-weight:bold;">ArgumentError</span>: no id given</pre></div></div>




<p>Thanks to google and <a href="http://www.simpltry.com/2007/10/15/hooplas-involving-method_missing-tricks/">Nicholas Schlueter</a> for the tip.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

