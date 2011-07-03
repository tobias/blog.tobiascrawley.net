---
title: "Pomodoro, status updates, and a distributed team"
author: Toby Crawley
layout: post
tags: [applescript, campfire, pomodoro, ruby]
disqus_identifier: "232 http://blog.tobiascrawley.net/?p=232"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p><img src="/posts/assets/old/pomodoro_status.jpg" alt="pomodoro_status" title="pomodoro_status" width="545" height="151" class="aligncenter size-full wp-image-235"></img></p>

<p>For the last few months, I&#x2019;ve been playing with the <a href="http://www.pomodorotechnique.com/">pomodoro technique</a> to manage my time and stay focused on the task at hand. It works best for me when I&#x2019;m stressed and have an overwhelming workload. It helps me focus on the immediate task, and not get distracted too much by all of the other stuff I need to do. </p>

<p>One issue with managing the technique is keeping interruptions to a minimum. When I start a pomodoro, I&#x2019;ll quit email, twitter, and chat. But we are a distributed team, and I work from home 95% of the time. I want to let the rest of the team know I&#x2019;m around, but also let them know that I&#x2019;m in a pomodoro, and to only interrupt in emergencies. Since we primarily use <a href="http://campfirenow.com">Campfire</a> to communicate, I set up a &#x2018;Status&#x2019; room there that allows us to post what we are up to/where we are at/etc. Its not only useful for pomodoro updates, but also &#x2018;off to lunch&#x2019;, &#x2018;gone for the day&#x2019;, etc. (And here is a third sentence that ends in etc.) But manually entering those status updates means they won&#x2019;t happen. So I wrote a simple update script using the lovely <a href="http://tinder.rubyforge.org/">tinder</a> gem. It consists of two files &#x2013; the script itself:</p>

<script src="http://gist.github.com/227107.js"></script>

<p>and the config file (<code>~/.campfire_status</code>):</p>

<script src="http://gist.github.com/227109.js"></script>

<p>But pomodoro status updates still require a manual step to run the script. Enter <a href="http://pomodoro.ugolandini.com/">Pomodoro</a>, a MacOS pomodoro client by <a href="http://www.ugolandini.com/">Ugo Landini</a>. His client allows integration with growl, twitter, and applescript. So I added the following applescript snippets to update the status for me:</p>

<script src="http://gist.github.com/227129.js"></script>

<p>A couple of gotchas I ran in to:<br></br>
* the Pomodoro app does not allow copy &amp; paste in the applescript text areas, making it a bit of a pain to enter<br></br>
* the Pomodoro app also has a file selector next to each applescript text area, but I could not get it to recognize the saved applescripts<br></br>
* the Campfire <span class="caps">API </span>seems to ignore requests from users that are currently logged in(?), so the status updates come from another account (in our case, we have a &#x2018;service-bot&#x2019; account that posts messages from other services). That&#x2019;s why there is a <code>USER_NAME</code> setting that is displayed with the message.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

