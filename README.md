SocialSinaWeibo
===============

Dead simple example demonstrating Sina Weibo integration with iOS 6 and OS X 10.8 Social Framework

The project contains two targets, SocialSinaWeibo and SocialSinaWeibo-iOS for Mac and iOS, respectively.

SocialSinaWeibo
--------------

pending

SocialSinaWeibo-iOS
------------------

Require iOS 6 and one or more Chinese Input Methods enabled.

### New Status

Use `SLComposeViewController` to present a builtin compose view to send a status to Sina Weibo. Very easy and straightforward to use.

### Post Comment

*Note: clicking on the Post Comment button in the example will submit a comment to this [status](http://www.weibo.com/1866155797/yEzOv28o0). Change the code or cancel if that's not what you intend to to.*

While SLComposeViewController takes care of simple posting task for us, sometimes we need to call Weibo API with more control. This is when `ACAccountStore` and `SLRequest` come into plays.

Create an ACAccountStore instance then call `[accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierSinaWeibo]`. If permission is granted, create an SLRequest instance initialzed with Weibo V2 URL and parameters, assign it with an account fetched from the ACAccountStore instance. Finally shoot the API call with `performRequestWithHandler`. Job done.

License
------

The MIT License

Copyright (c) James Chen ([@ashchan](http://www.weibo.com/ashchan))

