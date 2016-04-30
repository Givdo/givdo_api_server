# Givdo API Server

[![Build Status](https://semaphoreci.com/api/v1/projects/0a11f28a-6e3e-4e24-a3a8-8682ac4b8b1a/575200/badge.svg)](https://semaphoreci.com/chjunior/givdo_api_server)

## Development dependencies

* Ruby 2.0.0
* Bundler

## Work Flow

After cloning or updating your working copy, run the following to get your environment up to date:

```bash
$ bundle install
$ rake db:migrate
```

You might want to reset your database to initial state if you will:

```bash
$ rake db:seed
$ rake givdo:organizations:cache
$ rake givdo:admin:create
```

And finally, to run the application:

```bash
$ rails server
```

As of now, you shouldn't have to worry about database setup, as we're developing on top of sqlite, and deploying to mysql. If you feel you'll need a database dependent feature or any external service dependency, **talk to the team**.

## Running the tests

To run all of the specs, just run:

```bash
$ rspec
```

This will ensure to run the specs in the most reliable, consistent and fast way.

## Browsing the API

The documentation with examples and details about the API is avaliable, in development,
at `http://localhost:3000/api/docs`.

For more low level details check `spec/acceptance`.
