---
title: "zendesk_remote_auth gem makes Zendesk SSO easy!"
author: Toby Crawley
layout: post
tags: [gems, rails, ruby, zendesk]
disqus_identifier: "217 http://blog.tobiascrawley.net/?p=217"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I extracted how we are doing <a href="http://www.zendesk.com/api/remote_authentication">Zendesk remote authentication</a> from an app at <a href="http://dealerignition.com">Dealer Ignition</a>, and stuck it in a small gem for your enjoyment. You can find it on <a href="http://github.com/tobias/zendesk_remote_auth">GitHub</a>.</p>

<h3>Installation and Setup</h3>

<p>Install:</p>


<pre>gem install tobias-zendesk_remote_auth</pre>


<p>Setup:</p>

<p>You will need to give the gem your token and authentication url, perhaps in an initializer:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#6666ff; font-weight:bold;">Zendesk::RemoteAuth</span>.<span style="color:#9900CC;">token</span> = <span style="color:#996600;">'YOUR-TOKEN'</span>
<span style="color:#6666ff; font-weight:bold;">Zendesk::RemoteAuth</span>.<span style="color:#9900CC;">auth_url</span> = <span style="color:#996600;">'https://yourcompany.zendesk.com/access/remote/'</span></pre></div></div>




<p>and config the gem in environment.rb (if using rails):</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">config.<span style="color:#9900CC;">gem</span> <span style="color:#996600;">'tobias-zendesk_remote_auth'</span>, <span style="color:#ff3333; font-weight:bold;">:lib</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'zendesk_remote_auth'</span>, <span style="color:#ff3333; font-weight:bold;">:source</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> http:<span style="color:#006600; font-weight:bold;">//</span>gems.<span style="color:#9900CC;">github</span>.<span style="color:#9900CC;">com</span><span style="color:#996600;">'</span></pre></div></div>




<h3>Usage</h3>

<p>Mixin the Zendesk::RemoteAuthHelper module wherever needed, then call:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  zendesk_remote_auth_url<span style="color:#006600; font-weight:bold;">(</span><span style="color:#ff3333; font-weight:bold;">:name</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'user name'</span>,
<span style="color:#ff3333; font-weight:bold;">:email</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#996600;">'user email'</span>,
<span style="color:#006600; font-weight:bold;">&lt;</span>optional params<span style="color:#006600; font-weight:bold;">&gt;</span><span style="color:#006600; font-weight:bold;">)</span></pre></div></div>




<p>This will return a url you can redirect the user to to log them in to your zendesk account. </p>

<p>As a convenience, you can pass a user object to zendesk_remote_auth_url:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  zendesk_remote_auth_url<span style="color:#006600; font-weight:bold;">(</span>user<span style="color:#006600; font-weight:bold;">)</span></pre></div></div>




<p>This user must <code>respond_to?</code> <code>:name</code> and <code>:email</code>, and its <code>:id</code> will be used as the <code>:external_id</code> (making it useless with user objects that return an ephemeral object_id, but works well with ActiveRecord and the like). If the user object responds to <code>:zendesk_organization</code>, that will be used as the <code> <img src="http://blog.tobiascrawley.net/wp-includes/images/smilies/icon_surprised.gif" alt=":o" class="wp-smiley"></img> rganization</code> for the call.</p>

<p>This method will generate and include the hash of the parameters for you if necessary. </p>

<h3>Example Auth Controller</h3>

<p>Here is an example controller that handles login and logout for zendesk:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#008000; font-style:italic;"># Uses restful-authentication style auth. </span>
<span style="color:#008000; font-style:italic;"># </span>
<span style="color:#008000; font-style:italic;"># Define the following in routes.rb:</span>
<span style="color:#008000; font-style:italic;"># map.with_options :controller =&gt; 'zendesk_auth' do |zd|</span>
<span style="color:#008000; font-style:italic;">#   zd.connect '/zendesk/authorize', :action =&gt; 'authorize'</span>
<span style="color:#008000; font-style:italic;">#   zd.connect '/zendesk/logout', :action =&gt; 'logout'</span>
<span style="color:#008000; font-style:italic;"># end</span>
<span style="color:#9966CC; font-weight:bold;">class</span> ZendeskAuthController <span style="color:#006600; font-weight:bold;">&lt;</span> ApplicationController
<span style="color:#9966CC; font-weight:bold;">include</span> <span style="color:#6666ff; font-weight:bold;">Zendesk::RemoteAuthHelper</span>
&nbsp;
skip_before_filter <span style="color:#ff3333; font-weight:bold;">:login_required</span>, <span style="color:#ff3333; font-weight:bold;">:only</span> <span style="color:#006600; font-weight:bold;">=&gt;</span> <span style="color:#ff3333; font-weight:bold;">:logout</span>
&nbsp;
<span style="color:#9966CC; font-weight:bold;">def</span> authorize
redirect_to zendesk_remote_auth_url<span style="color:#006600; font-weight:bold;">(</span>current_user<span style="color:#006600; font-weight:bold;">)</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
&nbsp;
<span style="color:#9966CC; font-weight:bold;">def</span> logout
redirect_to logout_url
<span style="color:#9966CC; font-weight:bold;">end</span>
&nbsp;
protected
<span style="color:#9966CC; font-weight:bold;">def</span> login_required
<span style="color:#9966CC; font-weight:bold;">if</span> !logged_in?
flash<span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:notice</span><span style="color:#006600; font-weight:bold;">]</span> = <span style="color:#996600;">'You must log in to access the support site.'</span>
store_location
redirect_to login_path
<span style="color:#9966CC; font-weight:bold;">end</span>
<span style="color:#9966CC; font-weight:bold;">end</span>
<span style="color:#9966CC; font-weight:bold;">end</span></pre></div></div>



<!-- end .postmetadata -->












</div><!-- end .padding -->

