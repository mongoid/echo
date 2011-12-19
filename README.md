Echo
====

Development Environment Setup
=============================

* `$ brew install mongodb`
* `$ gem install bundler`
* `$ bundle install`

Running Specs
=============

* `$ rake`

Running Specs with Watchr and Spork
===================================

* `$ spork`
* `$ bundle exec watchr .watchr`

Environment Setup Heroku
========================
* `$ heroku config:add MONGOID_PORT=xxxxx`
* `$ heroku config:add MONGOID_HOST=xxxxxxxxxxxxxxxxx`
* `$ heroku config:add MONGOID_USERNAME=xxxxxxx`
* `$ heroku config:add MONGOID_PASSWORD=xxxxxxx`
* `$ heroku config:add MONGOID_DATABASE=echo`

Heroku
======
[Echo](http://echo-am.herokuapp.com)
