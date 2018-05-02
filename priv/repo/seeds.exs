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
Booker.Auth.create_user(%{email: "mike@gmail.com", name: "Mike", surname: "Warren", password: "password", avatar_url: "https://randomuser.me/api/portraits/med/men/83.jpg", is_admin: false})
Booker.Auth.create_user(%{email: "william@gmail.com", name: "William", surname: "Welch", password: "password", avatar_url: "https://randomuser.me/api/portraits/med/men/43.jpg", is_admin: false})

emails = [
  "vivan.fox51@example.com",
  "milton.rodriguez73@example.com",
  "tom.burke37@example.com",
  "emily.matthews28@example.com",
  "francisco.hicks78@example.com",
  "rick.reed84@example.com",
  "harold.diaz28@example.com"
]

names = ~w[Ewa Josef Mozelle Damaris Ching Elinor Mamie Kami Leigh Jennell Tommie Alexandria Estell Tennille Terry Alana Marylyn Debrah Sid Leonida]
surnames = ~w[Longmire Neu Sprankle Kenna Rodriques Nastasi Katrina Surber Mandie Brodsky Dixson Leung Pita Ruddell Betances Castaldo Kotek Battle Hornung Room Kinkade Gerhard]
avatar_url = "https://api.adorable.io/avatars/285/"

Enum.each 0..20, fn number ->

  name = Enum.random(names)
  surname = Enum.random(surnames)
  email = name <> "." <> surname <> "@gmail.com"
  avatar = avatar_url <> name <> surname

  Booker.Auth.create_user(%{email: email, name: name, surname: surname, password: "password", avatar_url: avatar, is_admin: false})
end
