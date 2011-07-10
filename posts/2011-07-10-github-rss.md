---
title: "github-rss"
author: Toby Crawley
layout: post
tags: [github, rss, github-rss]
---

The commit feeds provided by github only list the files that changed, and do not 
include the diffs - [github-rss] fixes that. It is a simple web service that acts
as a proxy and uses the github API to fill in the diff for each commit in the feed.

## Usage

To use, simply give the app your feed url:

    http://github-rss.example.com/?feed=https://github.com/username/project/commits/master.atom
    
You can also use it with private repos, but you'll need to provide your login and [token],
and you'll need to escape  the '?' and '&' in the feed url with '%3f' and '%26' respectively, 
like so:

    http://github-rss.example.com/?feed=https://github.com/username/project/commits/master.atom%3flogin=my_login%26token=1adefed234

## Use it now!

I have an [instance running on Heroku](http://github-rss.heroku.com/) that you are free to use.
Here is the feed for github-rss itself as a [sample]. If you are using github-rss with a private repo, 
I recommend you run your own instance instead of using mine. It doesn't store your github [token], 
but it does cache commit data in memcached, and do you trust me that much? 
 
## Problems

The [source][github-rss] is available on github. If you run in to any problems,
[issues] and pull requests are always welcome!

[github-rss]: https://github.com/tobias/github-rss
[token]: http://help.github.com/set-your-user-name-email-and-github-token/
[Issues]: https://github.com/tobias/github-rss/issues
[sample]: http://github-rss.heroku.com/?feed=https://github.com/tobias/github-rss/commits/master.atom
