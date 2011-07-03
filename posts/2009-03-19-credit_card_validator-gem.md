---
title: "credit_card_validator gem"
author: Toby Crawley
layout: post
tags: [gems, ruby]
disqus_identifier: "169 http://blog.tobiascrawley.net/?p=169"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>I recently published a gem that provides credit card validation. It is basically a ruby port of the <a href="http://github.com/madrobby/creditcard_js">javascript credit card validator</a> by <a href="http://mir.aculo.us/">Thomas Fuchs</a> (<a href="http://github.com/madrobby">madrobby</a>).</p>

<p>Usage:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">valid</span>?<span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">'1111 2222 3333 4444'</span><span style="color:#006600; font-weight:bold;">)</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># allow test numbers to be valid (for development) </span>
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">options</span><span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:test_numbers_are_valid</span><span style="color:#006600; font-weight:bold;">]</span> = <span style="color:#0000FF; font-weight:bold;">true</span>
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">valid</span>?<span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">'1111 2222 3333 4444'</span><span style="color:#006600; font-weight:bold;">)</span>
&nbsp;
<span style="color:#008000; font-style:italic;"># limit the card types you allow</span>
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">options</span><span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:allowed_card_types</span><span style="color:#006600; font-weight:bold;">]</span> = <span style="color:#006600; font-weight:bold;">[</span><span style="color:#ff3333; font-weight:bold;">:visa</span>, <span style="color:#ff3333; font-weight:bold;">:mastercard</span><span style="color:#006600; font-weight:bold;">]</span>
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">valid</span>?<span style="color:#006600; font-weight:bold;">(</span><span style="color:#996600;">'1111 2222 3333 4444'</span><span style="color:#006600; font-weight:bold;">)</span></pre></div></div>




<p>Supported card types:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#ff3333; font-weight:bold;">:amex</span>, <span style="color:#ff3333; font-weight:bold;">:discover</span>, <span style="color:#ff3333; font-weight:bold;">:diners_club</span>, <span style="color:#ff3333; font-weight:bold;">:master_card</span>, <span style="color:#ff3333; font-weight:bold;">:visa</span></pre></div></div>




<p>Whitespace is stripped from the number automatically.</p>

<p>The following things are tested:</p>

<p>1. does the luhn validation code add up? (see <a href="http://en.wikipedia.org/wiki/Luhn_algorithm">http://en.wikipedia.org/wiki/Luhn_algorithm</a>)<br></br>
2. does the number range and length seem right? (see <a href="http://en.wikipedia.org/wiki/Bank_card_number">http://en.wikipedia.org/wiki/Bank_card_number</a>)<br></br>
3. is it one of several well-known test numbers?</p>

<p>Note: this only validates that the number is of a valid format, it does not check if it is an actual credit card number. You will need to talk to your payment gateway to learn that.</p>

<p>You can also use the validator to learn about the type of the card:</p>


<div class="wp_syntax"><div class="code"><pre class="ruby" style="font-family:monospace;">  <span style="color:#008000; font-style:italic;"># gives the type back as a string (visa, master_card, etc)</span>
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">card_type</span><span style="color:#006600; font-weight:bold;">(</span>number<span style="color:#006600; font-weight:bold;">)</span>
&nbsp;
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">is_visa</span>?<span style="color:#006600; font-weight:bold;">(</span>number<span style="color:#006600; font-weight:bold;">)</span>
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">is_master_card</span>?<span style="color:#006600; font-weight:bold;">(</span>number<span style="color:#006600; font-weight:bold;">)</span>
<span style="color:#008000; font-style:italic;"># etc. - works for all of the supported card types</span>
&nbsp;
<span style="color:#6666ff; font-weight:bold;">CreditCardValidator::Validator</span>.<span style="color:#9900CC;">is_allowed_card_type</span>?<span style="color:#006600; font-weight:bold;">(</span>number<span style="color:#006600; font-weight:bold;">)</span></pre></div></div>




<p>To Install:</p>



<pre>
gem install tobias-credit_card_validator --source http://gems.github.com
</pre>




<p>The source is available on <a href="http://github.com/tobias/credit_card_validator">github</a></p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

