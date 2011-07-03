---
title: "Generating a TAGS file from a git hook"
author: Toby Crawley
layout: post
tags: [emacs, git, ruby]
disqus_identifier: "86 http://blog.handbuiltsoftware.com/?p=86"
---


<div class="padding">

</div><!-- end .padding -->
<div class="border-gray"></div>
<div class="padding">

<p>Any decent programmer&#x2019;s text editor provides some form of symbol lookup. With <a href="http://macromates.com/">TextMate</a>, the lookup table generation is built in. If you are using vim or emacs, you will need to use an external program to generate the lookup table. This post covers generating the lookup table for emacs (and with some slight modification, vi), and adding a hook to git to regenerate the table after a pull/merge. For more information on using symbol (tag) lookup with emacs or vim, see <a href="http://vim.wikia.com/wiki/Browsing_programs_with_tags">this wikia entry</a> for vim, or <a href="http://www.emacswiki.org/emacs/EmacsTags">this emacswiki entry</a> for emacs.</p>

<h3>ctags</h3>

<p>Traditionally, the <code>ctags/etags</code> executable was used to generate lookup tables for vi/emacs respectively. <code>ctag</code> would create a <code>tags</code> file for vi, and <code>etag</code> would create a <code>TAGS</code> file for emacs. Unfortunately, the <code>etags/ctags</code> that ships with MacOS X does not parse ruby code. For that, you will need to use <a href="http://ctags.sourceforge.net/">Exuberant Ctags</a>. You can install Exuberant Ctags on MacOS via <a href="http://macports.org/">MacPorts</a> with <code>sudo port install ctags</code>. </p>

<h3>git hooks</h3>

<p>There are some nice hooks that you can define for git to call after/before it performs certain actions. You can read the full list <a href="http://www.kernel.org/pub/software/scm/git/docs/githooks.html">here</a>. Hooks are defined by placing properly named executables into <code>.git/hooks/</code> in your repo. The two hooks we care about here are <a href="http://www.kernel.org/pub/software/scm/git/docs/githooks.html#_post_merge">post-merge</a> and <a href="http://www.kernel.org/pub/software/scm/git/docs/githooks.html#_post_commit">post-commit</a> ( <strong>Update:</strong> the script has been modified to register for the <a href="http://www.kernel.org/pub/software/scm/git/docs/githooks.html#_post_checkout">post-checkout</a> hook as well, based on a suggestion from <a href="http://smartic.us/2009/04/03/creating-ctags-with-git-hooks/">Bryan Liles</a>). The <code>post-merge</code> hook will get called after you do a <code>git pull</code> to merge from another repository, and <code>post-commit</code> is called after a local commit. An important thing to remember about these hooks (and anything else in <code>.git</code>) is that they will not be pushed to the remote repo. So if you develop on multiple machines, or want to share hooks with coworkers, you will need to install them in each local repo.</p>

<h3>the kitchen sink</h3>

<p>Here is the script I use to handle generating tags from ruby code explicitly, generating tags from a git hook, and installing the git hooks. It really should be two different scripts, but&#x2026; well&#x2026; isn&#x2019;t.</p>

<script src="http://gist.github.com/42308.js"></script>

<p>You can read it and see what it does. To have it install the hooks in the current repo, call it with the <code>-i@ option. If you use vim instead of emacs, you will need to remove the @-e</code> option and change <code>TAGS</code> to <code>tags</code> on the  <code>ctags</code> call.</p>

<p>Once it is installed, your tags will be regenerated after every commit or pull. You can manually regenerate the tags by calling the script from the repo base directory. </p>

<p><strong>Update:</strong> to see a video of this script in action, check out Bryan Liles&#x2019; post on <a href="http://smartic.us/2009/04/03/creating-ctags-with-git-hooks/">smartic.us</a>.</p>				


<!-- end .postmetadata -->












</div><!-- end .padding -->

