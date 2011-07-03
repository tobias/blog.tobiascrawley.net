---
title: "Refreshing an individual gemspec"
author: Toby Crawley
layout: post
tags: [gems, rails, tips, why am I not using bundler?]
disqus_identifier: "288 http://blog.tobiascrawley.net/?p=288"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I&#x2019;m in the process of upgrading a rails app from 2.1 to 2.3, and 2.3 wants me to refresh some of the gemspecs for my vendored gems. Unfortunately, when I run <code>rake gems:refresh_specs</code> I get the dreaded:</p>



<pre>
rake aborted!
can't activate , already activated json-1.1.9
</pre>



<p>I was able to refresh the spec in question outside of rake with (in the console):</p>



<pre>
&gt;&gt; Rails::GemDependency.from_directory_name('vendor/gems/gem_name-0.1.0', false).refresh
</pre>



<p>Hopefully that helps someone else out.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

