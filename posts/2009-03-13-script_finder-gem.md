---
title: "script_finder gem"
author: Toby Crawley
layout: post
tags: [gems, rails, ruby]
disqus_identifier: "163 http://blog.tobiascrawley.net/?p=163"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I recently published a ruby gem on <a href="http://github.com/tobias/script_finder">github</a> that simplifies running scripts from a <code>script/</code> dir from anywhere in your project (rails or otherwise). </p>

<p>script_finder provides a script (called <code>s@) in your path that searches in and up from the current dir for a folder (default: @script/</code>) containing an executable file uniquely identified by the a prefix given as the first argument. It then calls that executable, passing the rest of the arguments to the called executable. If the given prefix is ambiguous, the script suggests unique prefixes.</p>

<p>Examples (in a rails app):</p>


<pre style="">
~/rails_app/app/views$ s c
--&gt; calling '/Users/tobias/rails_app/script/console'
Loading development environment (Rails 2.1.0)
RowsLogger plugin enables mysql
&gt;&gt; exit
~/rails_app/app/views$ s r 'some ruby'
's r' was too ambiguous. Try:
's ru' for 'script/runner'
's re' for 'script/remote'
~/rails_app/app/views$ s ru 'some ruby'
--&gt; calling '/Users/tobias/rails_app/script/runner some ruby'
...
</pre>



<p>The gem is not rails specific &#x2013; out of the box it will work with any project that has a <code>script/</code> directory. If you want to make your own version of the <code>s@ script that looks for executables in a different dir (I would save this one as @c</code>):</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="">  <span style="color:#008000; font-style:italic;">#!/usr/bin/env ruby</span>
&nbsp;
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'script_finder'</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># looks for executables in a commands/ dir instead of script/.</span>
ScriptFinder.<span style="color:#9900CC;">find_and_execute</span><span style="color:#006600; font-weight:bold;">(</span>ARGV, <span style="color:#996600;">'commands'</span><span style="color:#006600; font-weight:bold;">)</span></pre></div></div>




<p>Let me know if you have any problems/questions.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

