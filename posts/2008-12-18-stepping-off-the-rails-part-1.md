---
title: "Stepping off the Rails – adventures with Sinatra (Part 1)"
author: Toby Crawley
layout: post
tags: [rails, ruby, sinatra]
disqus_identifier: "3 http://blog.handbuiltsoftware.com/?p=3"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p><em>In this episode, our trusty adventurer leaves the warm and fuzzy confines of Rails, and explores an &#x2018;alternative&#x2019; Ruby web framework. Part 1 will cover the app itself, and <a href="http://blog.handbuiltsoftware.com/2008/12/21/stepping-off-the-rails-part-2stepping-off-the-rails-part-2/">Part 2</a> will cover deployment.</em></p>

<p>I must admit it: I&#x2019;m one of those folks that came to Ruby because of Rails. And don&#x2019;t get me wrong &#x2013; I like Rails, but I frickin&#x2019; <strong>love</strong> Ruby. I&#x2019;m not a clever person, but Ruby makes me <em>feel</em> clever every day. Ruby is a good friend, and I want to get to know it better outside of its relationship with Rails. I&#x2019;m also interested in building simple web apps that don&#x2019;t need the full weight of Rails. So I turned to <a href="http://sinatra.rubyforge.org">Sinatra</a>.</p>

<p>For those of you that don&#x2019;t know all about it, Sinatra is a lightweight Ruby web application framework that takes a different approach than Rails. With Sinatra, you can write an entire web app in one file, with all of your templates inline (you can also have your templates in separate files instead, as we will see in a minute). Sinatra is rackable, and can be deployed in a <a href="http://rack.rubyforge.org">Rack</a> container, making it straightforward to deploy under <a href="http://modrails.com/">Passenger</a> (deployment is covered in <a href="http://blog.handbuiltsoftware.com/2008/12/21/stepping-off-the-rails-part-2stepping-off-the-rails-part-2/">Part 2</a>). There are lots of other good intros out there on Sinatra, and I&#x2019;ll list a few at the bottom of this post.</p>

<h3>The Controller</h3>

<p>Let&#x2019;s get started! The sample application here is <span class="caps">URLU</span>nwind. You can see it in operation at <a href="http://urlunwind.com/">urlunwind.com</a>, and see the full source on <a href="http://github.com/tobias/url_unwind">github</a>. It is a simple short <span class="caps">URL </span>unwinder, using <a href="http://www.ruby-doc.org/stdlib/libdoc/net/http/rdoc/index.html">Net::HTTP</a> to make a <span class="caps">HEAD </span>request and then pulling out the &#x2018;Location:&#x2019; header.</p>

<p>Sinatra apps are based around one controller file. You can break out your controller actions into separate files, but will need to manually require them into the primary controller. For this app, the controller is <a href="http://github.com/tobias/url_unwind/tree/master/urlunwind.rb">urlunwind.rb</a>. Right now, we are just interested in the actions:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">get <span style="color:#996600;">'/'</span> <span style="color:#9966CC; font-weight:bold;">do</span>
haml <span style="color:#ff3333; font-weight:bold;">:index</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
&nbsp;
post <span style="color:#996600;">'/unwind'</span> <span style="color:#9966CC; font-weight:bold;">do</span>
<span style="color:#0066ff; font-weight:bold;">@url</span>, <span style="color:#0066ff; font-weight:bold;">@unwound_url</span>, <span style="color:#0066ff; font-weight:bold;">@unwind_error</span> = unwind<span style="color:#006600; font-weight:bold;">(</span>params<span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:url</span><span style="color:#006600; font-weight:bold;">]</span><span style="color:#006600; font-weight:bold;">)</span>
haml <span style="color:#ff3333; font-weight:bold;">:index</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
&nbsp;
get <span style="color:#996600;">'/unwind.json'</span> <span style="color:#9966CC; font-weight:bold;">do</span>
content_type <span style="color:#996600;">'application/json'</span>
&nbsp;
<span style="color:#0066ff; font-weight:bold;">@url</span>, <span style="color:#0066ff; font-weight:bold;">@unwound_url</span>, <span style="color:#0066ff; font-weight:bold;">@unwind_error</span> = unwind<span style="color:#006600; font-weight:bold;">(</span>params<span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:url</span><span style="color:#006600; font-weight:bold;">]</span><span style="color:#006600; font-weight:bold;">)</span>
<span style="color:#006600; font-weight:bold;">{</span> <span style="color:#ff3333; font-weight:bold;">:from_url</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0066ff; font-weight:bold;">@url</span>, <span style="color:#ff3333; font-weight:bold;">:to_url</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0066ff; font-weight:bold;">@unwound_url</span>, <span style="color:#ff3333; font-weight:bold;">:error</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0066ff; font-weight:bold;">@unwind_error</span> <span style="color:#006600; font-weight:bold;">}</span>.<span style="color:#9900CC;">to_json</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
&nbsp;
get <span style="color:#996600;">'/stylesheets/style.css'</span> <span style="color:#9966CC; font-weight:bold;">do</span>
content_type <span style="color:#996600;">'text/css'</span>
&nbsp;
sass <span style="color:#ff3333; font-weight:bold;">:style</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>





<p>To define an action, you use a simple <acronym title="Domain Specific Language">DSL</acronym>. It starts with the method (one of: &#x2018;get&#x2019;, &#x2018;post&#x2019;, &#x2018;put&#x2019;, &#x2018;delete&#x2019;, where &#x2018;put&#x2019; and &#x2018;delete&#x2019; are handled with a &#x2018;_method&#x2019; parameter on a post), followed by the route that should trigger the action. The routes are searched in order they are defined until a match is found. You can include named parameters (with <code>:symbol</code>) or splat parameters (with *) in the routes as well (see the <a href="http://sinatra.rubyforge.org/">Sinatra page</a> for examples of this). In a similar fashion to Rails, parameters matched in the route, provided in the post body, or included in the url all end up in a <code>params</code> hash available to your action. </p>

<p>If a request fails to match any route, Sinatra looks for a matching file path in a <code>public/</code> directory in the same directory as the called executable (<code>$0@) (this path can be overridden). I use that feature to provide a "SASS":http://haml.hamptoncatlin.com/docs/rdoc/classes/Sass.html stylesheet, but I have other stylesheets in @public/stylesheets/</code> that are served statically. </p>

<p>After the action does it&#x2019;s business, whatever it returns is given to the client.  </p>

<h3>Rendering Views</h3>

<p>View templates can be defined in four ways: inline on the render call, embedded in the controller, using the <code>template</code> method, or in individual files. I prefer the cleanliness of having a separate file for each view, so used that approach. Sinatra will look for file based views in a <code>views/</code> directory in the same directory as the called executable (<code>$0@) (this path can also be overridden). You render a template by calling a method for the type of template it is. This app has only two templates: @index.haml</code> and <code>style.sass</code> (rendered with <code>haml :index</code> and <code>sass :style</code>, respectively). </p>

<p>As in Rails, ivars defined in the action are available within the template. You can also pass locals on the render call. </p>

<p>You can override the content-type for a particular action. I do that in the stylesheet and json actions with <code>content_type</code>. </p>

<h3>Testing</h3>

<p>Sinatra provides helpers for Test::Unit, Test::Spec, and RSpec. Here is a snippet from my Test::Unit <a href="http://github.com/tobias/url_unwind/tree/master/test/urlunwind_test.rb">tests</a>:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"> <span style="color:#9966CC; font-weight:bold;">def</span> test_index
get_it <span style="color:#996600;">'/'</span>
assert_match <span style="color:#006600; font-weight:bold;">/</span>Unwind It<span style="color:#006600; font-weight:bold;">/</span>, <span style="color:#0066ff; font-weight:bold;">@response</span>.<span style="color:#9900CC;">body</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
&nbsp;
<span style="color:#9966CC; font-weight:bold;">def</span> test_unwind_with_blank_url
post_it <span style="color:#996600;">'/unwind'</span>, <span style="color:#ff3333; font-weight:bold;">:url</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">''</span>
assert_match <span style="color:#006600; font-weight:bold;">/</span>Please enter<span style="color:#006600; font-weight:bold;">/</span>, <span style="color:#0066ff; font-weight:bold;">@response</span>.<span style="color:#9900CC;">body</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>





<p>Sinatra provides helpers to call the actions: <code>get_it</code>, <code>post_it</code>, <code>delete_it</code>, <code>put_it</code>. After calling any of these, the response is available in the <code>@respose</code> ivar. The test helpers have a little growing to do &#x2013; I was only able to assert_match against the body of the response. It would be nice to have access to the assigned ivars as well (this may be changed in edge, I built all of this against the 0.3.2 gem version of Sinatra). </p>

<p>Since Sinatra looks for views relative to the executable, calling the tests with <code>ruby test/urlunwind_test.rb</code> had it looking for <code>test/views/</code>, which did not exist. I linked <code>test/views/</code> to <code>../views/</code>, and all was good. You could also probably define a <code>:test</code> environment configuration that set the path to the views as well. I&#x2019;ll cover overriding the default paths in <a href="http://blog.handbuiltsoftware.com/2008/12/21/stepping-off-the-rails-part-2stepping-off-the-rails-part-2/">Part 2</a>, and you can read about configurations on the <a href="http://sinatra.rubyforge.org/">Sinatra</a> site.</p>

<h3>Project Structure</h3>

<p>Here is a snap of the project structure: <br></br>
<img src="/posts/assets/old/layout.jpg" alt="layout" title="layout" width="153" height="270" class="size-full wp-image-34"></img>
I&#x2019;ll discuss the purpose of the <code>vendor/</code> and <code>config.ru</code> entries in <a href="http://blog.handbuiltsoftware.com/2008/12/21/stepping-off-the-rails-part-2stepping-off-the-rails-part-2/">Part 2</a> as part of my deployment discussion.</p>

<h3>Resources</h3>

<p>There are some good references out there for Sinatra (this list is by no means exhaustive):<br></br>
* <a href="http://sinatra.rubyforge.org/">The Sinatra Homepage</a> &#x2013; In case you didn&#x2019;t see the dozen links to it above<br></br>
* <a href="http://sinatra-book.gittr.com/">The Sinatra Book</a> &#x2013; Which I discovered <strong>after</strong> writing this app. Wish I had seen it earlier.<br></br>
* Chris Schneider&#x2019;s <a href="http://gittr.com/">blog</a> &#x2013; A good resource of Sinatra tips. Chris also maintains the Sinatra Book.<br></br>
* #sinatra on irc.freenode.net &#x2013; Folks there were quick to answer my deployment questions, and prodded me to provide a  web service from the app.<br></br>
* The Sinatra <a href="http://groups.google.com/group/sinatrarb">mailing list</a><br></br>
* faithfulgeek&#x2019;s &#x2019;10 Minute Web App&#x2019; <a href="http://www.vimeo.com/2374819">screencast</a><br></br>
* <strong>Update:</strong> Ruby Inside article &#x2013; <a href="http://www.rubyinside.com/sinatra-29-links-and-resources-for-a-quicker-easier-way-to-build-webapps-1371.html">Sinatra: 29 Links and Resources For A Quicker, Easier Way to Build Webapps</a></p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

