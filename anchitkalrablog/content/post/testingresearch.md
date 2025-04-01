---
title: "Testing Research"
date: 2015-07-29T01:59:54-08:00
Description: "Testing Research"
Tags: [automation, Nokia N9, PhantomJS, QTWebKit, Selenium, testing]
Categories: [automation, testing]
DisableComments: false
---

As I wait for Citrix’s (awesome) social media team to approve my previous blog post, I wanted to share what I have been doing since.

The next step (seems logical to me) is to write some automated test cases so that I don’t have to spend countless hours manually testing the core functionality. I have been looking at different tools I can use to get this done as painlessly as possible.

1. Selenium: This seems to be the obvious choice. I first heard about this when I was interning at Thomson Reuters back in 2010. Although I never got a chance to use it, I would listen to my teammate talk about how awesome this was in almost every team meeting we had. Also, from my research, it seems to support almost all languages. I am inclined on using Php or Java as I am really comfortable developing on them.

2. PhantomJS (and the like): I heard about this when I was developing an application on my Nokia N9 (my precious) as it uses QTWebKit. The cool thing about this is that it doesn’t use an actual web browser. So if you are running Linux without X11 you can still use this framework. Which is why it is called headless. Moreover, this doesn’t require any extra setup when running a continuous integration system like Jenkins. Although cool, it sucks for me because it uses a different engine than Google Chrome. Arguably the most popular browser in use. I guess the deal breaker for me is that if the code needs to query the browser for info (may be like HTML-5 feature list) then this would not work.

3. Watir: I sorta gave up on this as soon as I realized it needed me to learn Ruby. Now don’t get me wrong, I am always game to learn new things but in this case I need something done quick so that I can put more effort into my web application.
