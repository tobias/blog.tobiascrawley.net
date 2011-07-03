---
title: "server_remote gem"
author: Toby Crawley
layout: post
tags: [deployment, gems, rails, ruby, simplecli]
disqus_identifier: "187 http://blog.tobiascrawley.net/?p=187"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I just re-released my server_remote plugin as a gem <a href="http://github.com/tobias/server_remote">server_remote</a> on github. I converted it to a gem to make it easier to use in multiple apps, and to make it easier to update (see <a href="http://blog.tobiascrawley.net/2009/01/10/server_remote-a-rails-plugin-for-easily-accessing-servers/">here</a> for the blog entry on the (now obselete) plugin). </p>

It is a gem that provides support for running commands on remote server. Once set up, it provides commands via <code>script/remote</code>:<br></br>
<ul>
<li><code>remote shell</code> &#x2013; same as ssh&#x2019;ing to the server (this is the default command, so it can be called with just <code>remote</code>)</li>
<li><code>remote console</code> &#x2013; executes a <code>script/console</code> on the server</li>
<li><code>remote logtail</code> &#x2013; executes <code>tail -f log/&lt;environment&gt;.log</code> on the server</li>
<li><code>remote cmd &lt;some command&gt;</code> executes command on the server, displaying the result. It <code>cd</code>&#x2018;s to the remote app root first.</li>
<li><code>remote scp &lt;local_file&gt; :&lt;remote_file&gt;</code> provides scp. Prefix remote files with &#x2018;:&#x2019;</li></ul>Configuration is in <code>config/server_remote.yml</code>, and is grouped into <em>profiles</em>. 

<p>Here is the output of <code>remote usage</code>:</p>


<div class="wp_syntax"><div class="code"><pre class="html" style="font-family:monospace;">Executes commands on a remote server over ssh. Configuration is in:
/Users/tobias/customers/DealerIgnition/dealer_ignition/script/../config/server_remote.yml
&nbsp;
You can override the profile used with -p profile. The default profile is: app
&nbsp;
Learn more in the readme:
/opt/local/lib/ruby/gems/1.8/gems/tobias-server_remote-0.2.0/lib/server_remote/../../README.textile
&nbsp;
remote commands are:
&nbsp;
DEFAULT COMMAND   shell
&nbsp;
cmd               executes an arbitrary command on the server after a cd to the app path
commands          List all 'remote' commands
console           executes remote console
help              Provide help documentation for a command
logtail           executes remote tail -f on the log
scp               copies files over scp (prefix remote files with ':')
shell             executes remote shell
usage             prints usage message
&nbsp;
For help on a particular command, use 'remote help COMMAND'.</pre></div></div>




<p>It uses <a href="http://remi.org">remi&#x2019;s</a> <a href="http://github.com/remi/simplecli">simplecli</a> gem. </p>

<p>I plan to add other commands as needed, or you can open up <code>Remote::Commands</code> and add your own. </p>

<h3>Installation</h3>

<p>You will need to install the gem (only once), then setup any apps where you want to use it.</p>



<pre>
sudo gem install tobias-server_remote --source http://gems.github.com/
server_remotify path_to_app
</pre>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

