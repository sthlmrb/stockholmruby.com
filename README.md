# stockholmruby.com

[![Build Status](https://travis-ci.org/sthlmrb/stockholmruby.com.png)](https://travis-ci.org/sthlmrb/stockholmruby.com)

Sinatra app.


## Deployment

To Heroku.


## Development

To see the recent meetups on the start page, you must configure an API key:

First find [your Meetup API key](http://www.meetup.com/meetup_api/key/).

Add the `MEETUP_KEY` environment variable to `.env`.

    % echo MEETUP_KEY=... >> .env

This file is ignored and should never be added to the repo.

The site will work without that key, but won't list meetups.

Now you can set up the app as normal:

    % bundle
    % foreman start

It will be running on <http://localhost:5000/>.

    % open http://localhost:5000/


## Test

    % bundle  # if you didn't already
    % rake

If your `MEETUP_KEY` is in the `.env` file per the development instructions, it will be used in the integration tests.


## Get involved

Please help out!

For repo access, ask [any repo member](https://github.com/sthlmrb?tab=members). You can also fork and submit pull requests.

For Heroku (deployment) access, ask [Henrik Nyh](http://henrik.nyh.se).

For DNS changes to `stockholmruby.com` and `stockholmruby.se`, talk to [Barsoom](http://barsoom.se).
