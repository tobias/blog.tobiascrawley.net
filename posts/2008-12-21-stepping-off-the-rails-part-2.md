---
title: "Stepping off the Rails – adventures with Sinatra (Part 2)"
author: Toby Crawley
layout: post
tags: [deployment, dreamhost, passenger, ruby, sinatra, urlunwind]
disqus_identifier: "54 http://blog.handbuiltsoftware.com/?p=54"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p><em>In this episode, our trusty adventurer actually runs his Sinatra app, and deploys it to Passenger on shared hosting. See <a href="http://blog.handbuiltsoftware.com/2008/12/18/stepping-off-the-rails-part-1/">Part 1</a> for details of building the application.</em></p>

<h3>Launching locally: two ways to skin a cat</h3>

<p>I realized that in <a href="http://blog.handbuiltsoftware.com/2008/12/18/stepping-off-the-rails-part-1/">Part 1</a> I did not cover launching the app to hit it from the browser. It&#x2019;s easy! To launch the app, use <code>ruby app_name.rb</code>. This will fire up a mongrel instance on port <code>4567</code> for your viewing pleasure. </p>

<p>Once you have defined your rack configuration (see below), you can also run the app inside rack locally with <code>rackup config.ru</code> to test your rack settings. This will launch rack inside mongrel on port <code>9292</code>. Thanks to @jnunemaker for the <a href="http://railstips.org/2008/12/15/deploying-sinatra-on-dreamhost-with-passenger">tip</a>. In fact, John&#x2019;s article is what I used as a basis for my deployment, with a few changes to support file based view templates.</p>

<h3>Rack Configuration</h3>

<p>To configure the application to run on rack under Passenger, you need to define a rack configuration file. Passenger expects that file to be named <code>config.ru</code> (see <a href="http://www.modrails.com/documentation/Users%20guide.html#_deploying_a_rack_based_ruby_application">Deploying a Rack-based Ruby application</a> in the Passenger documentation). Here is a minimum <code>config.ru</code> to run the application:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"><span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'rubygems'</span>
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'sinatra'</span>
&nbsp;
disable <span style="color:#ff3333; font-weight:bold;">:run</span>
&nbsp;
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'urlunwind.rb'</span>
run Sinatra.<span style="color:#9900CC;">application</span></pre></div></div>





<p>The only real configuration there is <code>disable :run</code>. This prevents Sinatra from starting a mongrel on port <code>4567</code> when the app file is required. This configuration would work for an app that uses no file based templates, and does not reference anything in <code>public/</code>. If you run this config with rackup on url_unwind (<code>rackup config.ru</code>), you&#x2019;ll see errors like:</p>

<p><code>Errno::ENOENT: No such file or directory - /opt/local/bin/views/index.haml</code><br></br>
<br></br><br></br>
<br></br><br></br>
This is because rack by default sets its base directory to be the path to the called executable (and on my machine, <code>rackup</code> lives in <code>/opt/local/bin/</code>). So we&#x2019;ll need to explicitly set the paths:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"><span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'rubygems'</span>
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'sinatra'</span>
&nbsp;
disable <span style="color:#ff3333; font-weight:bold;">:run</span>
set <span style="color:#ff3333; font-weight:bold;">:views</span>, <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">dirname</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#0000FF; font-weight:bold;">__FILE__</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#006600; font-weight:bold;">+</span> <span style="color:#996600;">'/views'</span>
set <span style="color:#ff3333; font-weight:bold;">:public</span>, <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">dirname</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#0000FF; font-weight:bold;">__FILE__</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#006600; font-weight:bold;">+</span> <span style="color:#996600;">'/public'</span>
set <span style="color:#ff3333; font-weight:bold;">:app_file</span>, <span style="color:#0000FF; font-weight:bold;">__FILE__</span>
&nbsp;
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'urlunwind.rb'</span>
run Sinatra.<span style="color:#9900CC;">application</span></pre></div></div>




<p>Now the app should run properly with <code>rackup</code>. </p>

<h3>Logging</h3>

<p>Sinatra uses rack&#x2019;s built in logging to log requests, and these log messages get printed to standard out. It would be nice to log these to a file, and we can do that as well in <code>config.ru</code> (based on <a href="http://www.gittr.com/index.php/archive/logging-with-sinatra-and-passenger-another-try/">this tip</a> from Chris Schneider). We&#x2019;ll also need to turn error raising back on, since by default Sinatra swallows errors in production mode:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"><span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'rubygems'</span>
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'sinatra'</span>
&nbsp;
disable <span style="color:#ff3333; font-weight:bold;">:run</span>
set <span style="color:#ff3333; font-weight:bold;">:env</span>, <span style="color:#ff3333; font-weight:bold;">:production</span>
set <span style="color:#ff3333; font-weight:bold;">:raise_errors</span>, <span style="color:#0000FF; font-weight:bold;">true</span>
set <span style="color:#ff3333; font-weight:bold;">:views</span>, <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">dirname</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#0000FF; font-weight:bold;">__FILE__</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#006600; font-weight:bold;">+</span> <span style="color:#996600;">'/views'</span>
set <span style="color:#ff3333; font-weight:bold;">:public</span>, <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">dirname</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#0000FF; font-weight:bold;">__FILE__</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#006600; font-weight:bold;">+</span> <span style="color:#996600;">'/public'</span>
set <span style="color:#ff3333; font-weight:bold;">:app_file</span>, <span style="color:#0000FF; font-weight:bold;">__FILE__</span>
&nbsp;
log = <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">new</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">"log/sinatra.log"</span>, <span style="color:#996600;">"a"</span><span style="color:#006600; font-weight:bold;">)</span>
STDOUT.<span style="color:#9900CC;">reopen</span><span style="color:#006600; font-weight:bold;">(</span>log<span style="color:#006600; font-weight:bold;">)</span>
STDERR.<span style="color:#9900CC;">reopen</span><span style="color:#006600; font-weight:bold;">(</span>log<span style="color:#006600; font-weight:bold;">)</span>
&nbsp;
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'urlunwind.rb'</span>
run Sinatra.<span style="color:#9900CC;">application</span></pre></div></div>





<p>This allows you to add your own logging messages as well, just <code>puts</code>, <code>print</code>, or <code>p@ whatever you want to log. *Note:* you will need to create the @log/</code> directory for this to work.</p>

<h3>Deploy with Capistrano</h3>

<p>I used Capistrano to deploy to Dreamhost, and based my Capfile of off John&#x2019;s directions <a href="http://railstips.org/2008/12/15/deploying-sinatra-on-dreamhost-with-passenger">here</a>. I modified it a bit to pull from github, and to create the <code>tmp/</code> and <code>log/</code> directories if they do not exist. Here is my Capfile:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"><span style="color:#008000; font-style:italic;">#-*-ruby-*-</span>
<span style="color:#CC0066; font-weight:bold;">load</span> <span style="color:#996600;">'deploy'</span> <span style="color:#9966CC; font-weight:bold;">if</span> respond_to?<span style="color:#006600; font-weight:bold;">(</span><span style="color:#ff3333; font-weight:bold;">:namespace</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#008000; font-style:italic;"># cap2 differentiator</span>
&nbsp;
default_run_options<span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:pty</span><span style="color:#006600; font-weight:bold;">]</span> = <span style="color:#0000FF; font-weight:bold;">true</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># be sure to change these</span>
set <span style="color:#ff3333; font-weight:bold;">:user</span>, <span style="color:#996600;">'app_user'</span>
set <span style="color:#ff3333; font-weight:bold;">:domain</span>, <span style="color:#996600;">'urlunwind.com'</span>
set <span style="color:#ff3333; font-weight:bold;">:application</span>, <span style="color:#996600;">'url_unwind'</span>
set <span style="color:#ff3333; font-weight:bold;">:git_path_prefix</span>, <span style="color:#996600;">"git@github.com/tobias/"</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># the rest should be good</span>
set <span style="color:#ff3333; font-weight:bold;">:repository</span>, <span style="color:#996600;">"#{git_path_prefix}#{application}.git"</span>
set <span style="color:#ff3333; font-weight:bold;">:deploy_to</span>, <span style="color:#996600;">"/home/#{user}/#{domain}"</span>
set <span style="color:#ff3333; font-weight:bold;">:deploy_via</span>, <span style="color:#ff3333; font-weight:bold;">:remote_cache</span>
set <span style="color:#ff3333; font-weight:bold;">:scm</span>, <span style="color:#996600;">'git'</span>
set <span style="color:#ff3333; font-weight:bold;">:branch</span>, <span style="color:#996600;">'master'</span>
<span style="color:#008000; font-style:italic;">#set :git_shallow_clone, 1</span>
set <span style="color:#ff3333; font-weight:bold;">:scm_verbose</span>, <span style="color:#0000FF; font-weight:bold;">true</span>
set <span style="color:#ff3333; font-weight:bold;">:use_sudo</span>, <span style="color:#0000FF; font-weight:bold;">false</span>
&nbsp;
server domain, <span style="color:#ff3333; font-weight:bold;">:app</span>, <span style="color:#ff3333; font-weight:bold;">:web</span>
&nbsp;
namespace <span style="color:#ff3333; font-weight:bold;">:deploy</span> <span style="color:#9966CC; font-weight:bold;">do</span>
task <span style="color:#ff3333; font-weight:bold;">:restart</span> <span style="color:#9966CC; font-weight:bold;">do</span>
run <span style="color:#996600;">"test -d #{current_path}/tmp || mkdir #{current_path}/tmp"</span>
run <span style="color:#996600;">"test -d #{current_path}/log || mkdir #{current_path}/log"</span>
run <span style="color:#996600;">"touch #{current_path}/tmp/restart.txt"</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>





<p>Since the Sinatra gem is not installed on Dreamhost, I put it in <code>vendor/</code> within the app. Since it is not a gem, it must be required with the full path to the base <code>.rb</code> file, both in <code>config.ru</code> and in the app file itself (<code>urlunwind.rb</code> in this case). Here is the final <code>config.ru</code>:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;"><span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'rubygems'</span>
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'vendor/sinatra/lib/sinatra.rb'</span>
&nbsp;
disable <span style="color:#ff3333; font-weight:bold;">:run</span>
set <span style="color:#ff3333; font-weight:bold;">:env</span>, <span style="color:#ff3333; font-weight:bold;">:production</span>
set <span style="color:#ff3333; font-weight:bold;">:raise_errors</span>, <span style="color:#0000FF; font-weight:bold;">true</span>
set <span style="color:#ff3333; font-weight:bold;">:views</span>, <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">dirname</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#0000FF; font-weight:bold;">__FILE__</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#006600; font-weight:bold;">+</span> <span style="color:#996600;">'/views'</span>
set <span style="color:#ff3333; font-weight:bold;">:public</span>, <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">dirname</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#0000FF; font-weight:bold;">__FILE__</span><span style="color:#006600; font-weight:bold;">)</span> <span style="color:#006600; font-weight:bold;">+</span> <span style="color:#996600;">'/public'</span>
set <span style="color:#ff3333; font-weight:bold;">:app_file</span>, <span style="color:#0000FF; font-weight:bold;">__FILE__</span>
&nbsp;
log = <span style="color:#CC00FF; font-weight:bold;">File</span>.<span style="color:#9900CC;">new</span><span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">"log/sinatra.log"</span>, <span style="color:#996600;">"a"</span><span style="color:#006600; font-weight:bold;">)</span>
STDOUT.<span style="color:#9900CC;">reopen</span><span style="color:#006600; font-weight:bold;">(</span>log<span style="color:#006600; font-weight:bold;">)</span>
STDERR.<span style="color:#9900CC;">reopen</span><span style="color:#006600; font-weight:bold;">(</span>log<span style="color:#006600; font-weight:bold;">)</span>
&nbsp;
<span style="color:#CC0066; font-weight:bold;">require</span> <span style="color:#996600;">'urlunwind.rb'</span>
run Sinatra.<span style="color:#9900CC;">application</span></pre></div></div>



<!-- end .postmetadata -->












</div><!-- end .padding -->

