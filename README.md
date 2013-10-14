# stockholmruby.com

Sinatra app.


## Deployment

To Heroku.


## Development

To run the app locally you must first find [your Meetup API key](http://www.meetup.com/meetup_api/key/).

Add the `MEETUP_KEY` environment variable to `.env`

    % echo MEETUP_KEY=... >> .env

Now you can set up the app as normal:

    % bundle install
    % foreman start -p 9292

It is now running on [http://localhost:9292/](http://localhost:9292).

    % open http://localhost:9292/


## Get involved

Please help out!

For repo access, ask [any repo member](https://github.com/sthlmrb?tab=members). You can also fork and submit pull requests.

For Heroku (deployment) access, ask [Henrik Nyh](http://henrik.nyh.se).

For DNS changes to `stockholmruby.com` and `stockholmruby.se`, talk to [Barsoom](http://barsoom.se).
