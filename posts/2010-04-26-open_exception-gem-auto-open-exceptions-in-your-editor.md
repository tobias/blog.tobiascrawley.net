---
title: "open_exception gem: auto open exceptions in your editor"
author: Toby Crawley
layout: post
tags: [emacs, gems, ruby]
disqus_identifier: "318 http://blog.tobiascrawley.net/?p=318"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>open_exception opens an exception in your favorite editor when developing locally. It works by parsing the backtrace, and opening the offending file at the offending line in your favorite editor (assuming your favorite editor supports remote open commands).</p>

<p>You can add filters that allow you to ignore some exceptions, and filters that allow you to scope the backtrace search. The backtrace scoping is useful for opening the last call in your application code when the exception occurs in a framework or lib.</p>

<p>If you are on MacOSX and have the <a href="http://rubygems.org/gems/growl">growl gem</a> installed, you will get a growl notification with the exception message when the file is opened.</p>

<h3>Editors</h3>

<p>Out if the box, the gem supports three editors (with the following open commands):</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">    <span style="color:#ff3333; font-weight:bold;">:emacs</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'/usr/bin/emacsclient -n +{line} {file}'</span>,
<span style="color:#ff3333; font-weight:bold;">:textmate</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'/usr/local/bin/mate -a -d -l {line} {file}'</span>,
<span style="color:#ff3333; font-weight:bold;">:macvim</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'/usr/local/bin/mvim +{line} {file}'</span></pre></div></div>




<p>Note: if using emacs, you will need to be running <code>emacsserver</code>. To start the server: <code>M-x server-start</code><br></br>
or add <code>(server-start)</code> to your init.</p>

<h3>Configuration</h3>

<p>To configure, pass a block to the configure method:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">    OpenException.<span style="color:#9900CC;">configure</span> <span style="color:#9966CC; font-weight:bold;">do</span> <span style="color:#006600; font-weight:bold;">|</span>oe<span style="color:#006600; font-weight:bold;">|</span>
<span style="color:#008000; font-style:italic;"># open_with can be one of the built in editors (:emacs, :macvim, :textmate)</span>
<span style="color:#008000; font-style:italic;"># or a command to execute to open the file, where {file} and {line} will be replaced</span>
<span style="color:#008000; font-style:italic;"># with the file path and line number, respectively. See 'Editors' above for an example.</span>
<span style="color:#008000; font-style:italic;"># The default editor is :emacs.</span>
&nbsp;
oe.<span style="color:#9900CC;">open_with</span> = <span style="color:#ff3333; font-weight:bold;">:emacs</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># you can add exclusion filters to ignore exceptions. A filter can be an exception class to </span>
<span style="color:#008000; font-style:italic;"># ignore, or a proc that is passed the exception, and should evaluate to true if the exception </span>
<span style="color:#008000; font-style:italic;"># should be ignored. Be careful with using a class - it uses is_a?, so any subclasses of the</span>
<span style="color:#008000; font-style:italic;"># passed class will be ignored as well. The list of filters is [] by default.</span>
&nbsp;
oe.<span style="color:#9900CC;">exclusion_filters</span> <span style="color:#006600; font-weight:bold;">&lt;&lt;</span> SomeErrorClass
oe.<span style="color:#9900CC;">exclusion_filters</span> <span style="color:#006600; font-weight:bold;">&lt;&lt;</span> <span style="color:#CC0066; font-weight:bold;">lambda</span> <span style="color:#006600; font-weight:bold;">{</span> <span style="color:#006600; font-weight:bold;">|</span>exception<span style="color:#006600; font-weight:bold;">|</span> <span style="color:#0000FF; font-weight:bold;">true</span> <span style="color:#9966CC; font-weight:bold;">if</span> exception_should_be_excluded <span style="color:#006600; font-weight:bold;">}</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># you can scope the search for the file:line to open with a filter as well. A filter can be a </span>
<span style="color:#008000; font-style:italic;"># regular expression that is matched against the line, or a proc that is passed the line and </span>
<span style="color:#008000; font-style:italic;"># should evaluate to true if the line should be used. The first line that any filter passes for </span>
<span style="color:#008000; font-style:italic;"># will be the file:line that is opened. This is useful for opening the point in the stack just</span>
<span style="color:#008000; font-style:italic;"># before control passes out of your app code when the exception occurs in an external </span>
<span style="color:#008000; font-style:italic;"># lib/framework. The list of filters is [] by default. </span>
&nbsp;
oe.<span style="color:#9900CC;">backtrace_line_filters</span> <span style="color:#006600; font-weight:bold;">&lt;&lt;</span> <span style="color:#006600; font-weight:bold;">%</span>r<span style="color:#006600; font-weight:bold;">{</span><span style="color:#006600; font-weight:bold;">/</span>app<span style="color:#006600; font-weight:bold;">/</span>root<span style="color:#006600; font-weight:bold;">/</span><span style="color:#006600; font-weight:bold;">(</span>app<span style="color:#006600; font-weight:bold;">|</span>lib<span style="color:#006600; font-weight:bold;">)</span><span style="color:#006600; font-weight:bold;">}</span> 
oe.<span style="color:#9900CC;">backtrace_line_filters</span> <span style="color:#006600; font-weight:bold;">&lt;&lt;</span> <span style="color:#CC0066; font-weight:bold;">lambda</span> <span style="color:#006600; font-weight:bold;">{</span> <span style="color:#006600; font-weight:bold;">|</span>backtrace_line<span style="color:#006600; font-weight:bold;">|</span> <span style="color:#0000FF; font-weight:bold;">true</span> <span style="color:#9966CC; font-weight:bold;">if</span> line_should_be_used <span style="color:#006600; font-weight:bold;">}</span>
&nbsp;
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>




<h3>Rails Integration</h3>

<p>The gem also alias chains in to rails&#x2019; <code>ActionController#rescue_action_locally</code> method to automatically open exceptions in development mode. The gem also adds the following filter to the <code>:backtrace_line_filters</code> to scope the opened files to the app:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">    <span style="color:#006600; font-weight:bold;">%</span>r<span style="color:#006600; font-weight:bold;">{</span><span style="color:#008000; font-style:italic;">#{Rails.root}/(app|lib)}</span></pre></div></div>




<p>To replace or remove this filter, you will need to reset the <code>:backtrace_line_filters</code> in your configure block:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">    OpenException.<span style="color:#9900CC;">configure</span> <span style="color:#9966CC; font-weight:bold;">do</span> <span style="color:#006600; font-weight:bold;">|</span>oe<span style="color:#006600; font-weight:bold;">|</span>
oe.<span style="color:#9900CC;">backtrace_line_filters</span> = <span style="color:#006600; font-weight:bold;">[</span><span style="color:#006600; font-weight:bold;">]</span>
oe.<span style="color:#9900CC;">backtrace_line_filters</span> <span style="color:#006600; font-weight:bold;">&lt;&lt;</span> my_new_filter
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>




<p>This has been tested with rails v2.3.5, but should work fine with 2.1 &lt;= rails &lt; 3. It may work with rails 3 as well, I just haven&#x2019;t yet looked at rails 3.</p>

<h3>Standalone/Other Frameworks</h3>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">    <span style="color:#008000; font-style:italic;"># To manually open an exception, or wire it up in another framework, you call:</span>
OpenException.<span style="color:#CC0066; font-weight:bold;">open</span><span style="color:#006600; font-weight:bold;">(</span>exception<span style="color:#006600; font-weight:bold;">)</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># You can override the default (or configured) options by passing a hash as the second arg:</span>
OpenException.<span style="color:#CC0066; font-weight:bold;">open</span><span style="color:#006600; font-weight:bold;">(</span>exception, <span style="color:#006600; font-weight:bold;">{</span>:open_with <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#ff3333; font-weight:bold;">:textmate</span>, <span style="color:#ff3333; font-weight:bold;">:backtrace_line_filters</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">[</span>filter, another_filter<span style="color:#006600; font-weight:bold;">]</span><span style="color:#006600; font-weight:bold;">)</span></pre></div></div>




<p>The source is on <a href="http://github.com/tobias/open_exception">github</a>, and the gem is on <a href="http://rubygems.org/gems/open_exception">rubygems</a>.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

