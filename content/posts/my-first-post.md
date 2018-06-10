---
title: "Building a Url Shortner: Part 1"
date: 2018-06-09T11:48:38-04:00
draft: false
---
There are a lot of tutorials for projects in go, but a majority of them devolve into copy and pasting code to get something that works.  I will try not to do that in this series.  Another thing a lot of these things leave out is how much forethought and design go into a project.  So, in the first part of this series, I'll go through collecting requirements and do some initial design.  Because this is just for me and this blog, I get to set my own requirements.  

### Requirements
First and most obviously, going to a shortened URL should redirect you to another site.  You'll also need to know what site to redirect to, so you'll need to be able to register a URL with the service.  There should also be a method to get metrics and stats for the shortened links.  Each shortened link should expire after a time.  It'd also be nice to set how long the expiration time is when the link is registered.

### Design

Now that we have a handful of requirements, we can start in on some design.  It makes the most sense to set this up as a REST API. The registration will be a POST to the base path and it will return with the shortened URL.  It will accept an optional TTL parameter to set the expiration.  The TTL will be an integer for the number of seconds to keep the URL, or a -1 to never expire.  A GET to the path of the shortened URL will redirect you to the original URL.  A GET to the `/stats/` endpoint will return the following stats for the service:

- Total registered URLs
- Total redirects
- Average response time

A GET to the `/stats/<token>` endpoint will return the following stats for the individual shortened URL:

- Number of redirects
- Expiration
- Average response time

A GET to the base path will return all shortened URLs and a DELETE to will remove all of them.  And finally, a DELETE to the path of the shortened URL will remove that shortener.

It's good to have a contract to code to, so I'll also define the payloads each endpoint will accept or return.

The payload to register a URL will look like the following:

``` js
{
  "url": "https://example.com",
  "ttl": "-1"
}
```

The return payload will be a link:

``` js
{
  "url": "https://example.com",
  "token": "<token>",
  "shortened_url": "https://<base_url>/<token>"
  "expiration": "never"
}
```

The GET to the base path will return a list of the above link.

The GET to the `/stats/` endpoint will return:

``` js
{
  "total_urls": 1,
  "total_redirects": 0,
  "average_response": "1ms"
}
```

The GET to the `/stats/<token>` endpoint will be:

``` js
{
  "redirects": 1,
  "expiration": "never",
  "average_response": "1ms"
}
```

### Conclusion
Now that we have a good idea of what our service will look like, we can get started building it out.  We'll start that in the next part.
