Echo [![Build Status](https://secure.travis-ci.org/mongoid/echo.png?branch=master&.png)](http://travis-ci.org/mongoid/echo)
====
This is the sample Rails application for Mongoid.

Running mongoid/issues/2864
-----------------------------------

* `$ bundle install`
* `$ bundle exec rake db:reseed`
* `$ rails s`

After starting the server you can do multiple requests to: http://0.0.0.0:3000/ and they should return the right dbs.


Compatibility
-------------

Mongoid is tested against MRI 1.9.2, 1.9.3, 2.0.0, and JRuby (1.9).

Development Environment Setup
-----------------------------

* `$ brew install mongodb`
* `$ gem install bundler`
* `$ bundle install`

Running Specs
-------------

* `$ rake`

Running Specs with Guard and Spork
-----------------------------------

* `$ spork`
* `$ bundle exec guard`
