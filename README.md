# Booker
[![Build Status](https://travis-ci.org/book-manager/book-manager.svg?branch=master)](https://travis-ci.org/book-manager/book-manager)
[![Coverage Status](https://coveralls.io/repos/github/book-manager/book-manager/badge.svg?branch=master)](https://coveralls.io/github/book-manager/book-manager?branch=master)

### Setup

Run Postgres in Docker container with correct credentials.

`docker run -d --rm -e POSTGRES_USER=booker -e POSTGRES_PASSWORD=booker -e POSTGRES_DB=booker -p 5432:5432 postgres` or `make docker`

Run migration to prepare database and create fixture data.

`mix ecto.setup` or `make prepare`

Run application

`mix phx.server` or `make run`

Application is running on port __4000__.
