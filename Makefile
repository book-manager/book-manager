MIX_ENV=dev

export MIX_ENV
export ACTUAL

all: release

clean:
	mix deps.clean --all

compile:
	mix deps.get
	mix deps.compile
	mix compile

prepare:
	mix ecto.setup

iex:
	iex -S mix phx.server

run:
	mix phx.server

docker:
	docker run -it --rm -e POSTGRES_USER=booker -e POSTGRES_PASWORD=booker -e POSTGRES_DATABASE=booker -p 5432:5432 -d --name psql postgres

docker-stop:
	docker stop psql

credo:
	mix credo --strict

coverage:
	 MIX_ENV=test mix coveralls.html

test:
	MIX_ENV=test mix test

test-iex:
	MIX_ENV=test iex -S mix test