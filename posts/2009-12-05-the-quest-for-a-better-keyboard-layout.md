---
title: "The quest for a better keyboard layout"
author: Toby Crawley
layout: post
tags: [keyboard, keyboard layout, ruby, ukelele]
disqus_identifier: "241 http://blog.tobiascrawley.net/?p=241"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<h3>The Quest</h3>

<p> <img src="/posts/assets/old/AdventureQuest-header5-300x166.jpg" alt="" title="" width="300" height="166" class="alignleft size-medium wp-image-249"></img></p>

<p>Like most programmers, I type a lot &#x2013; many hours a day, most days of the week. The keyboard is the primary conduit of my creative expression most of the time, whether I&#x2019;m writing code or constructing elaborate stories to impress friends, clients, or co-workers (aka email/chat/this blog). For the last couple of years, I&#x2019;ve been mildly obsessed with making that conduit more efficient. I&#x2019;ve <a href="http://en.wikipedia.org/wiki/IBM_Model_M">tried</a> <a href="http://www.microsoft.com/hardware/mouseandkeyboard/productdetails.aspx?pid=043">several</a> <a href="http://www.kinesis-ergo.com/images/freestyle-solo_690x375.jpg">different</a> <a href="http://www.kinesis-ergo.com/index.htm">keyboards</a> and entirely new <a href="http://en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard">keyboard</a> <a href="http://en.wikipedia.org/wiki/Colemak#Colemak">layouts</a>. </p>

<p>I stopped the keyboard search with the <a href="http://www.kinesis-ergo.com/index.htm">Kinesis Advantage</a> &#x2013; it works really well for me, and is the easiest keyboard for touch typing that I&#x2019;ve ever used. But the keyboard layout search continued. The productivity hit during the learning period for <a href="http://en.wikipedia.org/wiki/Dvorak_Simplified_Keyboard">Dvorak</a> or <a href="http://en.wikipedia.org/wiki/Colemak#Colemak">Colemak</a> was too great, and I quickly slid back to <a href="http://en.wikipedia.org/wiki/Qwerty">Qwerty</a>. </p>

<p>I could type as fast as I wanted in Qwerty, so I tried to figure out what was really bugging me about my typing. I realized it was the shift key &#x2013; I was frustrated with the high percentage of characters I typed that involved shift. I primarily code in Ruby, which uses &#x2018;_&#x2019; much more often than &#x2018;-&#x2019; (about 14 times more often), &#x2018;:&#x2019; more than &#x2018;;&#x2019; (about 78 times more often!), and &#x2018;{}&#x2019; more than &#x2018;[]&#x2018; (or so I thought &#x2013; more on that later). </p>

<p>I then decided to create a custom keyboard layout that would reduce the need for the shift key when coding. My goals were:</p>


<ul>
<li>no remapping of the letter keys, since my muscle memory knows where they all are</li>
<li>remap commonly used symbols to be available without the shift key</li>
<li>be easy to learn, so no remapping characters to new keys</li>
</ul>



<p>Using the <a href="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&amp;id=Ukelele">Ukelele</a> keyboard layout editing tool (for MacOS), I played around with some layout ideas before settling on the one I&#x2019;ve been using since May 2009.</p>

<h3>The Layout</h3>

<p><img src="/posts/assets/old/covered-model-railway-layout-300x253.jpg" alt="" title="" width="300" height="253" class="alignright size-medium wp-image-252"></img>
Since I mostly code in Ruby, and mostly use symbols in code vs. email/chat/etc., I remapped the shifted symbols I used more often.<br></br>
I &#x2018;shift-swapped&#x2019; (meaning the symbol you get with or without the shift key depressed are reversed) the following character pairs:</p>


<ul>
<li>{ [</li>
<li>} ]</li>
<li>| \</li>
<li>~ `</li>
<li>: ;</li>
<li>_ -</li>
</ul>




<p>I assumed that I used most of the symbols on the top row number keys more than I used the numbers, so I shift-swapped the 1 &#x2013; 0 number keys with the corresponding symbol. If caps-lock is on, number keys revert to normal, but all of the other symbol keys remain swapped (meaning when caps-lock is on, pressing the &#x2019;1&#x2032; key will give you a 1, but pressing the &#x2018;[' key will give you a {). Since the Kinesis keyboard does not have a separate keypad, this makes entering number sequences easier. </p>

<p>The caps-lock key has been moved to the f1 key, and I use the original caps-lock as a control key (for <a href="http://en.wikipedia.org/wiki/Emacs">Emacs</a>). This mapping can't be done by <a href="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&amp;id=Ukelele">Ukelele</a>, since it cannot remap function or modifier keys, so I did this using the remapping functionality in the Kinesis keyboard itself.</p>

<h3>Analysis</h3>

<p>After six weeks or so of using the new layout, I decided to analyze a large ruby codebase to see what my shift pair ratios actually were (something I should have done <em>before</em> creating a new layout). Using <a href="http://gist.github.com/133750">this script</a>, I got the following results:</p>



<pre>
Analyzed 457 files, 25060 lines
` ~     25     58  2.320
1 !   1161    713  0.614
2 @    564   2700  4.787
3 #    416   1914  4.601
4 $    264     55  0.208
5 %    359    303  0.844
6 ^    257     44  0.171
7 &amp;    152    226  1.487
8 *    176    115  0.653
9 (    196   4479  22.852
0 )   1761   4485  2.547
- _   1559  21837  14.007
[ {   1385   1304  0.942
] }   1396   1306  0.936
\ |    144   1480  10.278
; :    108   8446  78.204
= +   5588    729  0.130
&#x2018; "   5585   3909  0.700
, &lt;   4737    791  0.167
. &gt;  10257   2067  0.202
/ ?   1077   1054  0.979
</pre>



<p>Columns one and two are the shift pairs. Columns three and four are the occurrence counts for each character in the pair. The last column shows the ratio of the second character (normally shifted) to the first character (normally not shifted).  So a higher number in that column indicates an advantage to swapping the shift pair.</p>

<p>I looked at the shift pairs I had swapped, along with the other symbol shift pairs that I did not swap (the last five lines above).  There are some big wins here with my current remapping, along with some loses. The '[]'/'{}' swap was a small mistake - looks like I access elements of collections slightly more often than I define inline blocks or explicit hashes (which is kind of obvious in hindsight. In fact, on reflection I would think that collection access would happen considerably more often than inline block creation). And some of the number key remaps are big loses based on the ratios, but the lowest ratio pairs there have generally low volume. After this analysis, I didn't undo any of the remappings, though I should have reversed (and still should reverse) the bracket/brace swap. </p>

<h3>Usage </h3>

<p><img src="/posts/assets/old/hat-usage-instructions-300x266.jpg" alt="" title="" width="300" height="266" class="alignleft size-medium wp-image-259"></img>
The name of this layout is 'rubyist'. If you are interested in giving it a try, download the MacOS keylayout file <a href="http://tobiascrawley.net/rubyist/rubyist.keylayout">here</a>, and put it in ~/Library/Keyboard Layouts/. </p>

<p>I don't expect this layout to work well for everyone, or really anyone other than me. I do think all of us could benefit from evaluating the text we type the most, and seeing if some keyboard layout tweaks could make us more efficient. If you do want to give your own layout a try, check out these platform specific tools:</p>


<ul>
<li>MacOS: <a href="http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&amp;id=Ukelele">Ukelele</a></li>
<li>Linux: <a href="http://www.linux.com/archive/articles/113715"><span class="caps">XKB</span></a></li>
<li>Windows: <a href="http://msdn.microsoft.com/en-us/goglobal/bb964665.aspx">Microsoft Keyboard Layout Creator</a></li>
</ul>




<!-- end .postmetadata -->












</div><!-- end .padding -->

