---
title: "rails_habitat: a simple rails plugin to make RAILS_ENV a bit friendlier"
author: Toby Crawley
layout: post
tags: [rails, ruby]
disqus_identifier: "227 http://blog.tobiascrawley.net/?p=227"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I just released a stupid simple plugin based on the idea behind Coda Hale&#x2019;s <a href="http://blog.codahale.com/2006/04/09/rails-environments-a-plugin-for-well-rails/">rails_environments plugin</a>.</p>

<p>This plugin adds the following functionality to the Rails module to help with determining the current enviroment:</p>



<pre>
&gt;&gt; Rails.environment       # a convenience alias to Rails.env
=&gt; "development"
&gt;&gt; Rails.development?
=&gt; true
&gt;&gt; Rails.not_development?
=&gt; false
&gt;&gt; Rails.production?
=&gt; false
&gt;&gt; Rails.not_production?
=&gt; true
&gt;&gt; Rails.test?
=&gt; false
&gt;&gt; Rails.not_test?
=&gt; true
</pre>



<p>Not only does it provide <code>env?</code> and <code>not_env?</code> methods for the standard environments, it also provides those methods for any environment you define in config/environments/ (in fact that is how it learns about all of the environments, including the standard three). So if you define new environments in config/environments/ they will be picked up automatically. </p>

<p>Install with: <code>script/plugin install git://github.com/tobias/rails_habitat.git</code></p>

<p>It lives on <a href="http://github.com/tobias/rails_habitat">github</a>.</p>

<p><strong>Edit</strong>: see David&#x2019;s comment below for the built in way to do this (in Rails &gt;= 2.2).</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

