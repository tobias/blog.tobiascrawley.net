---
title: "Presentation Tools"
author: Toby Crawley
layout: post
tags: [codex, haml, presenting, sass]
disqus_identifier: "143 http://blog.tobiascrawley.net/?p=143"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>Last night, I gave my first presentation in a really long time. It went really well! (I used to have a terrible fear of public speaking, so much so that I changed majors in college to avoid having to take a public speaking class (I switched back, because I realized I was being foolish. I&#x2019;m glad I did, because I met a nice lady (we went out once, and it was the worst date of my life; but I digress))). The presentation was on <a href="http://haml.hamptoncatlin.com/docs/rdoc/classes/Haml.html">Haml</a> &amp; <a href="http://haml.hamptoncatlin.com/docs/rdoc/classes/Sass.html">Sass</a>, and is available on <a href="http://github.com/tobias/haml_sass_presentation">github</a> if you are interested.   </p>

<p>But this post isn&#x2019;t about the presentation, but about the tools I used to build/show it. I spent some time trying to get colorized code samples in to Keynote &#x2019;09, but did not have much luck. After a little bit of research, I found Dave Thomas&#x2019; <a href="http://github.com/pragdave/codex">codex</a>, an html based presentation builder that uses the <a href="http://meyerweb.com/eric/tools/s5/">s5</a> javascript presentation tool. Codex allows you to reference code files or embed code snippets, which will be pulled in during the build process and wrapped in a <a href="http://alexgorbatchev.com/wiki/SyntaxHighlighter">SyntaxHighlighted</a> div. It processes &#x2018;slide&#x2019; files and creates one html page containing the entire presentation. I modified it a bit for this presentation to add support for adding text to the previous slide, and included all of the available SyntaxHighlighter language modules in the output. The modified version is <a href="http://github.com/tobias/codex">here</a>. </p>

<p>To display the presentation, I created a <a href="http://fluidapp.com">Fluid</a> app, set it to me chromeless, and made it draggable from anywhere. I then installed <a href="http://www.filewell.com/iRedLite/">iRed Lite</a>, which allows you to send keystrokes to any app using the Apple infrared remote. Once that was all in place, I hooked up the projector, dragged the Fluid app to the projected display, and gave the presentation.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

