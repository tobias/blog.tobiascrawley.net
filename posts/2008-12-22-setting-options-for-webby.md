---
title: "Setting options for Webby"
author: Toby Crawley
layout: post
tags: [ruby, webby]
disqus_identifier: "80 http://blog.handbuiltsoftware.com/?p=80"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I&#x2019;m using <a href="http://webby.rubyforge.org/">Webby</a> to manage the static <a href="http://handbuiltsoftware.com/">Hand Built Software</a> site, and had a difficult time finding how to set defaults for the webby rake tasks (specifically the <code>deploy:ssh</code> task in this case). Here is what I figured out: you set the values at the top of your project <code>Sitefile</code> like so:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"><span style="color:#008000; font-style:italic;">#-*-ruby-*-</span>
SITE.<span style="color:#9900CC;">user</span> = <span style="color:#996600;">'tobias'</span>
SITE.<span style="color:#9900CC;">host</span> = <span style="color:#996600;">'handbuiltsoftware.com'</span>
SITE.<span style="color:#9900CC;">remote_dir</span> = <span style="color:#996600;">'/path/to/site/'</span>
&nbsp;
task <span style="color:#ff3333; font-weight:bold;">:default</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#ff3333; font-weight:bold;">:build</span>
&nbsp;
desc <span style="color:#996600;">'deploy the site to the webserver'</span>
task <span style="color:#ff3333; font-weight:bold;">:deploy</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:build</span>, <span style="color:#996600;">'deploy:ssh'</span><span style="color:#006600; font-weight:bold;">]</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># EOF</span></pre></div></div>




<p>For reference, here are the webby defaults which can be overridden (from <a href="http://github.com/TwP/webby/tree/master/lib/webby.rb">lib/webby.rb</a>)</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#008000; font-style:italic;"># call-seq:</span>
<span style="color:#008000; font-style:italic;">#    Webby.site    =&gt; struct</span>
<span style="color:#008000; font-style:italic;">#</span>
<span style="color:#008000; font-style:italic;"># Returns a struct containing the configuration parameters for the </span>
<span style="color:#008000; font-style:italic;"># Webby site. These defaults should be overridden as needed in the</span>
<span style="color:#008000; font-style:italic;"># site specific Rakefile.</span>
<span style="color:#008000; font-style:italic;">#</span>
<span style="color:#9966CC; font-weight:bold;">def</span> <span style="color:#0000FF; font-weight:bold;">self</span>.<span style="color:#9900CC;">site</span>
<span style="color:#0000FF; font-weight:bold;">return</span> <span style="color:#0066ff; font-weight:bold;">@site</span> <span style="color:#9966CC; font-weight:bold;">if</span> <span style="color:#9966CC; font-weight:bold;">defined</span>? <span style="color:#0066ff; font-weight:bold;">@site</span>
<span style="color:#0066ff; font-weight:bold;">@site</span> = OpenStruct.<span style="color:#9900CC;">new</span><span style="color:#006600; font-weight:bold;">(</span>
<span style="color:#ff3333; font-weight:bold;">:output_dir</span>    <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'output'</span>,
<span style="color:#ff3333; font-weight:bold;">:content_dir</span>   <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'content'</span>,
<span style="color:#ff3333; font-weight:bold;">:layout_dir</span>    <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'layouts'</span>,
<span style="color:#ff3333; font-weight:bold;">:template_dir</span>  <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'templates'</span>,
<span style="color:#ff3333; font-weight:bold;">:exclude</span>       <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">%</span>w<span style="color:#006600; font-weight:bold;">(</span>tmp$ bak$ ~$ CVS \.<span style="color:#9900CC;">svn</span><span style="color:#006600; font-weight:bold;">)</span>,
<span style="color:#ff3333; font-weight:bold;">:page_defaults</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span>
<span style="color:#996600;">'layout'</span>     <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'default'</span>
<span style="color:#006600; font-weight:bold;">}</span>,
<span style="color:#ff3333; font-weight:bold;">:find_by</span>       <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'title'</span>,
<span style="color:#ff3333; font-weight:bold;">:base</span>          <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0000FF; font-weight:bold;">nil</span>,
<span style="color:#ff3333; font-weight:bold;">:create_mode</span>   <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'page'</span>,
<span style="color:#ff3333; font-weight:bold;">:blog_dir</span>      <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'blog'</span>,
<span style="color:#ff3333; font-weight:bold;">:tumblog_dir</span>   <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'tumblog'</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Items for running the heel webserver</span>
<span style="color:#ff3333; font-weight:bold;">:use_web_server</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0000FF; font-weight:bold;">true</span>,
<span style="color:#ff3333; font-weight:bold;">:heel_port</span>      <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006666;">4331</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Items used to deploy the website</span>
<span style="color:#ff3333; font-weight:bold;">:user</span>       <span style="color:#006600; font-weight:bold;">=&gt;</span> ENV<span style="color:#006600; font-weight:bold;">[</span><span style="color:#996600;">'USER'</span><span style="color:#006600; font-weight:bold;">]</span> <span style="color:#006600; font-weight:bold;">||</span> ENV<span style="color:#006600; font-weight:bold;">[</span><span style="color:#996600;">'USERNAME'</span><span style="color:#006600; font-weight:bold;">]</span>,
<span style="color:#ff3333; font-weight:bold;">:host</span>       <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'example.com'</span>,
<span style="color:#ff3333; font-weight:bold;">:remote_dir</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'/not/a/valid/dir'</span>,
<span style="color:#ff3333; font-weight:bold;">:rsync_args</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">%</span>w<span style="color:#006600; font-weight:bold;">(</span><span style="color:#006600; font-weight:bold;">-</span>av<span style="color:#006600; font-weight:bold;">)</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Global options for HAML and SASS</span>
<span style="color:#ff3333; font-weight:bold;">:haml_options</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span><span style="color:#006600; font-weight:bold;">}</span>,
<span style="color:#ff3333; font-weight:bold;">:sass_options</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span><span style="color:#006600; font-weight:bold;">}</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Options passed to the 'tidy' program when the tidy filter is used</span>
<span style="color:#ff3333; font-weight:bold;">:tidy_options</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'-indent -wrap 80'</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># List of valid URIs (these automatically pass validation)</span>
<span style="color:#ff3333; font-weight:bold;">:valid_uris</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">[</span><span style="color:#006600; font-weight:bold;">]</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Options for coderay processing</span>
<span style="color:#ff3333; font-weight:bold;">:coderay</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span>
<span style="color:#ff3333; font-weight:bold;">:lang</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#ff3333; font-weight:bold;">:ruby</span>,
<span style="color:#ff3333; font-weight:bold;">:line_numbers</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0000FF; font-weight:bold;">nil</span>,
<span style="color:#ff3333; font-weight:bold;">:line_number_start</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006666;">1</span>,
<span style="color:#ff3333; font-weight:bold;">:bold_every</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006666;">10</span>,
<span style="color:#ff3333; font-weight:bold;">:tab_width</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006666;">8</span>
<span style="color:#006600; font-weight:bold;">}</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Options for graphviz processing</span>
<span style="color:#ff3333; font-weight:bold;">:graphviz</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span>
<span style="color:#ff3333; font-weight:bold;">:path</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0000FF; font-weight:bold;">nil</span>,
<span style="color:#ff3333; font-weight:bold;">:cmd</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'dot'</span>,
<span style="color:#ff3333; font-weight:bold;">:type</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'png'</span>
<span style="color:#006600; font-weight:bold;">}</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Options for tex2img processing</span>
<span style="color:#ff3333; font-weight:bold;">:tex2img</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span>
<span style="color:#ff3333; font-weight:bold;">:path</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0000FF; font-weight:bold;">nil</span>,
<span style="color:#ff3333; font-weight:bold;">:type</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'png'</span>,
<span style="color:#ff3333; font-weight:bold;">:bg</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'white'</span>,
<span style="color:#ff3333; font-weight:bold;">:fg</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'black'</span>,
<span style="color:#ff3333; font-weight:bold;">:resolution</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'150x150'</span>
<span style="color:#006600; font-weight:bold;">}</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># Options for ultraviolet syntax highlighting</span>
<span style="color:#ff3333; font-weight:bold;">:uv</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">{</span>
<span style="color:#ff3333; font-weight:bold;">:lang</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'ruby'</span>,
<span style="color:#ff3333; font-weight:bold;">:line_numbers</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#0000FF; font-weight:bold;">false</span>,
<span style="color:#ff3333; font-weight:bold;">:theme</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'mac_classic'</span>
<span style="color:#006600; font-weight:bold;">}</span>,
&nbsp;
<span style="color:#008000; font-style:italic;"># XPath identifiers used by the basepath filter</span>
<span style="color:#ff3333; font-weight:bold;">:xpaths</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#006600; font-weight:bold;">%</span>w<span style="color:#006600; font-weight:bold;">(</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>head<span style="color:#006600; font-weight:bold;">//</span>base<span style="color:#006600; font-weight:bold;">[</span>@href<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>head<span style="color:#006600; font-weight:bold;">//</span>link<span style="color:#006600; font-weight:bold;">[</span>@href<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">//</span>script<span style="color:#006600; font-weight:bold;">[</span>@src<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">[</span>@background<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">//</span>a<span style="color:#006600; font-weight:bold;">[</span>@href<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">//</span>object<span style="color:#006600; font-weight:bold;">[</span>@data<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">//</span>img<span style="color:#006600; font-weight:bold;">[</span>@src<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">//</span>area<span style="color:#006600; font-weight:bold;">[</span>@href<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">//</span>form<span style="color:#006600; font-weight:bold;">[</span>@action<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">/</span>html<span style="color:#006600; font-weight:bold;">/</span>body<span style="color:#006600; font-weight:bold;">//</span>input<span style="color:#006600; font-weight:bold;">[</span>@src<span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#006600; font-weight:bold;">)</span>
<span style="color:#008000; font-style:italic;"># other possible XPaths to include for base path substitution</span>
<span style="color:#008000; font-style:italic;">#   /html/body//object[@usemap]</span>
<span style="color:#008000; font-style:italic;">#   /html/body//img[@usemap]</span>
<span style="color:#008000; font-style:italic;">#   /html/body//input[@usemap]</span>
<span style="color:#006600; font-weight:bold;">)</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>




<p><strong>Note:</strong> this applies to webby 0.9.3 </p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

