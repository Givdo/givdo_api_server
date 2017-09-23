# Givdo API Server [![CircleCI](https://circleci.com/gh/Givdo/givdo_api_server.svg?style=svg)](https://circleci.com/gh/Givdo/givdo_api_server)

## Getting Started

1) Make sure you have the following dependencies installed

* Ruby 2.3.1
* Gem
* Bundler

2) After installing all dependencies, clone the repository

```
$ git clone git@github.com:Givdo/givdo_api_server.git && cd givdo_api_server
```

3) From project root run the following commands to install bundle packages
and create development database

```
$ bundle install
$ bin/rake db:setup
```

4) Seed your database, cache organizations from Facebook and create an admin
account with

```
$ bin/rake db:seed
$ bin/rake givdo:organizations:cache
$ bin/rake givdo:admin:create
$ bin/rake "givdo:admin:create['USER_EMAIL', 'USER_PASSWORD']"
```
Where 'USER_EMAIL' and 'USER_PASSWORD' are the email and password you wish to record.

5) Start development server with

```
$ bin/rails s -b 0.0.0.0
```

Happy coding!

## Running the tests

We use RSpec to exercise Givdo's API endpoints. To run all the specs, run:

```
$ rspec
```

This will ensure to run the specs in the most reliable, consistent and fast way.

## Browsable API documentation

**Documentation is incomplete and outdated**

Givdo's API documentation is accessible, in development, at `http://localhost:3000/api/docs`. Documentation generated from acceptance specs at `spec/acceptance` and includes details and simple usage examples.

At any time run the following command to (re)generate the documentation

```
$ bin/rake docs:generate
```

Check `spec/acceptance` for implementation details.

## Tools and Guides

- [Better Specs](http://www.betterspecs.org)
- [REST Client (Mac, Windows and Linux)](https://insomnia.rest)
- [RSpec API Documentation DSL](https://github.com/zipmark/rspec_api_documentation#dsl)
