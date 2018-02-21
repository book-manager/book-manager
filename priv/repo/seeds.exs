# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Booker.Repo.insert!(%Booker.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
Booker.Auth.create_user(%{email: "james@gmail.com", name: "James", surname: "Bond", password: "password", avatar_url: "https://avatars2.githubusercontent.com/u/10079912?s=460&v=4", is_admin: true})
