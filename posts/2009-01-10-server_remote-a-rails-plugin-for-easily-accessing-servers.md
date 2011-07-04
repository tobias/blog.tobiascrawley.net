---
title: "server_remote - A Rails plugin for easily accessing servers"
author: Toby Crawley
layout: post
tags: [deployment, rails, ruby, simplecli]
disqus_identifier: "102 http://blog.handbuiltsoftware.com/?p=102"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<div style="background-color: #ffc;border: 1px solid #777;padding: 12px;font-size:1.5em;text-align: center;line-height: 1.2em;">
<strong>Note:</strong> this post is out of date. This tool is now a gem instead of a plugin; read all about it <a href="http://blog.tobiascrawley.net/2009/03/31/server_remote-gem/">here</a>.<br></br>
</div>
I just released <a href="http://github.com/tobias/server_remote">server_remote</a> on github. It is a plugin for connecting to remote servers. Once installed, it provides commands via <code>script/remote</code>:<br></br>
* <code>remote shell</code> &#x2013; same as ssh&#x2019;ing to the server (this is the default command, so it can be called with just <code>remote</code>)<br></br>
* <code>remote console</code> &#x2013; executes a <code>script/console</code> on the server<br></br>
* <code>remote logtail</code> &#x2013; executes <code>tail -f log/&lt;environment&gt;.log</code> on the server

<p>Configuration is in <code>config/server_remote.yml</code>, and is grouped into <em>profiles</em>. </p>

<p>Here is the output of <code>remote usage</code>:</p>


<div class="wp_syntax"><div class="code"><pre class="html" style=""> Executes commands on a remote server over ssh. Configuration is in:
/Users/tobias/customers/DropZite/restaurantZite/config/server_remote.yml
&nbsp;
You can override the profile used with -p profile. The default profile is: app
&nbsp;
Learn more in the readme:
/Users/tobias/customers/DropZite/restaurantZite/vendor/plugins/server_remote/lib/README.textile
&nbsp;
remote commands are:
&nbsp;
DEFAULT COMMAND   shell
&nbsp;
commands          List all 'remote' commands
console           executes remote console
help              Provide help documentation for a command
logtail           executes remote tail -f on the log
shell             executes remote shell
usage             prints usage message
&nbsp;
For help on a particular command, use 'remote help COMMAND'.</pre></div></div>




<p>It uses <a href="http://remi.org">remi&#x2019;s</a> <a href="http://github.com/remi/simplecli">simplecli</a> gem. <br></br>
<br></br><br></br>
I plan to add other commands as needed, or you can open up <code>Remote::Commands</code> and add your own. Install with: <code>script/plugin install git://github.com/tobias/server_remote.git</code></p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

