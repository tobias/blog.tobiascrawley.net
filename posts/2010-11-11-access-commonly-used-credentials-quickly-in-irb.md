---
title: "Access commonly used credentials quickly in irb"
author: Toby Crawley
layout: post
tags: [aws, irb, ruby]
disqus_identifier: "335 http://blog.tobiascrawley.net/?p=335"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I often deal with multiple Amazon <span class="caps">AWS </span>accounts in irb, and grew tired of copying and pasting my credentials, so I added code to my <code>~/.irbrc</code> to make them available from a constant. Here is the relevant chunk of my <code>irbrc</code> (explanation follows):</p>

<script src="https://gist.github.com/672837.js?file=irbrc.rb"></script>

<p>I load the credentials from a separate yaml file, with the keys as symbols (I&#x2019;ll explain why in a sec):</p>

<script src="https://gist.github.com/672839.js?file=creds.yml"></script>

<p>The yaml is parsed and loaded in to an <code>OpenCascade</code> from the <a href="http://rubyworks.github.com/hashery/">Hashery</a> gem, which works like ruby&#x2019;s builtin <a href="http://ruby-doc.org/stdlib/libdoc/ostruct/rdoc/classes/OpenStruct.html">OpenStruct</a>, but provides deep &#x2018;structing&#x2019; of the source hash. Since it requires symbols as keys, I store the keys as symbols in the yaml to avoid an ugly <code>symbolize_keys</code> step.</p>

<p>Now, inside irb, I can access the credentials with:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">EC2.<span style="color:#9900CC;">account_a</span>.<span style="color:#9900CC;">access_key_id</span>
EC2.<span style="color:#9900CC;">account_b</span>.<span style="color:#9900CC;">secret_access_key</span></pre></div></div>




<p>Since I use <a href="http://rvm.beginrescueend.com/"><span class="caps">RVM</span></a> gemsets for almost everything, I&#x2019;m often switching between gemsets, some of which have not had an irb session. To handle that case, I have the <code>force_require</code> method that will automatically install missing gems. </p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

