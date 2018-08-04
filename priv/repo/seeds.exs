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

Booker.Author.create_authors(%{name: "Sławomir", surname: "Nieściur", avatar_url: "https://api.adorable.io/avatars/285/slawomir.niesciur", description: "Rocznik 1973. Z wykształcenia prawnik. Literaturą zafascynowany mniej więcej od siódmego roku życia, kiedy to po heroicznych bojach przedarł się przez znaleziony na strychu, doszczętnie sczytany i lekko nadgryziony przez myszy egzemplarz „Krzyżaków”. Pierwsze opowiadanie wystukał na tablecie za pomocą dotykowej klawiatury w spartańskich warunkach wsi polskiej bez dostępu do technologicznych udogodnień."})
Booker.Author.create_authors(%{name: "Bartek", surname: "Biedrzycki", avatar_url: "https://api.adorable.io/avatars/285/bartek.biedrzycki", description: "Rocznik ’78, mąż Ali, ojciec Zuzy i Bruna, zamieszkuje w aglomeracji warszawskiej. Przez ponad dekadę pracował przy produkcji telewizyjnej, obecnie jest specjalistą IT. Ma niepotrzebny dyplom UW, uprawniający go do pracy w charakterze nauczyciela j. angielskiego. Starszy kapral rezerwy, po wzorowej służbie w Dywizjonie Artylerii Samobieżnej w Orzyszu. W armii zdarł dwie pary butów, za to wyniósł stamtąd honorowe krwiodawstwo."})
Booker.Author.create_authors(%{name: "Dominika", surname: "Węcławek", avatar_url: "https://api.adorable.io/avatars/285/dominika.weclawek", description: "Urodzona w Sosnowcu, kilkukrotnie się przeprowadzała. Ukończyła wydział filozofii na UKSW. Obecnie mieszka we Wrocławiu wraz z dwójką dzieci.Zajmuje się głównie dziennikarstwem muzycznym, parentingowym i podróżniczym. Współpracowała m.in. z pismami Ślizg, Loop, Życie Warszawy, Machina, Przekrój, Zeszyty Komiksowe, Kartki czy National Geographic Traveler; pisała także dla portali internetowych, m.in. Interia.pl, t-mobile-music.pl oraz Foch.pl Redaktorka naczelna satyrycznego pisma parentingowego Bachor oraz czasopisma muzycznego M/I. Na stałe pracuje w agencji kreatywnej In Hot Water Company.W 2010 była jurorką konkursu komiksowego na MFKiG w Łodzi."})
Booker.Author.create_authors(%{name: "Michał", surname: "Gołkowski", avatar_url: "https://api.adorable.io/avatars/285/michal.golkowski", description: "Zodiakalnie, patologiczny Wodnik z roku Stanu Wojennego. Wbrew pozorom samotnik, mizantrop i introwertyk. Z wykształcenia lingwista, z zamiłowania historyk wojskowości, z zawodu na co dzień tłumacz kabinowy ang-pol-ros. Obecnie stalker."})
Booker.Author.create_authors(%{name: "Joanna", surname: "Kanicka", avatar_url: "https://api.adorable.io/avatars/285/joanna.kanicka", description: "Studentka kierunku kultura i praktyka tekstu, urodzona w 1995 roku we Wrocławiu. Fascynację uniwersum S.T.A.L.K.E.R.a wiąże z miłością do zapomnianych miejsc i języka rosyjskiego. Uwielbia samotne podróże i dobrą muzykę, czasami pójdzie też postrzelać z wiatrówki. Otwarta na nowe doświadczenia – żałuje, że życie jest zbyt krótkie, by spróbować wszystkiego. Poza tym typowy nocny marek; wena najczęściej przychodzi do niej po kryjomu, gdy wszyscy sąsiedzi już śpią."})
Booker.Author.create_authors(%{name: "Andrzej", surname: "Ziemiański", avatar_url: "https://api.adorable.io/avatars/285/andrzej.ziemianski", description: "Porzucił prestiżową karierę naukową i zajął się pisaniem książek. Już po kilku latach zdobył uznanie pół miliona Polaków czytających Achaję z wypiekami na twarzach. Z wykształcenia jest architektem. Widzi i myśli obrazami. Podgląda, słucha i rozmawia dla przyjemności. Lubi fotografować puste miejsca. Sam jest dla siebie pracownikiem, szefem i przewodniczącym komitetu strajkowego. Nieustannie prowokuje czytelników i recenzentów swoim podejściem do sztuki pisania. Mówi, że cierpi na przymus tworzenia."})
Booker.Author.create_authors(%{name: "Andrzej", surname: "Pilipiuk", avatar_url: "https://api.adorable.io/avatars/285/andrzej.pilipiuk", description: "Andrzej Pilipiuk (1974) człowiek z przeszłości. Niestrudzony tropiciel ciekawostek z lamusa. Kolekcjoner nagród literackich, który z pisania z pasją uczynił swój sposób na życie. Miarą jego sukcesu jest 26 napisanych powieści wydanych w ciągu dekady, 600 tysięcy sprzedanych książek i miejsce na podium ścisłej czołówki najpoczytniejszych pisarzy w Polsce. Homo literatus, który do pisania podchodzi z żelazną regułą – pracuje planowo, codziennie, a kiedy poczuje zmęczenie fabułą, zabiera się za inny tytuł. Uprzedzając krytykę sam siebie nazwał Wielkim Grafomanem. Z wykształcenia archeolog, z zamiłowania łowca meteorów. Beznadziejnie zauroczony zapomnianymi odkrywcami i wynalazkami XIX wieku. Społecznik. Własnym sumptem i ogromnym zaangażowaniem wydał unikatowy album o Wojsławicach, mieście w którym narodził się Jakub Wędrowycz."})

Booker.Author.create_ownership(%{user_id: 1, author_id: 1})
Booker.Author.create_ownership(%{user_id: 1, author_id: 2})
Booker.Author.create_ownership(%{user_id: 1, author_id: 6})
Booker.Author.create_ownership(%{user_id: 1, author_id: 7})
Booker.Author.create_ownership(%{user_id: 2, author_id: 7})
Booker.Author.create_ownership(%{user_id: 2, author_id: 4})
Booker.Author.create_ownership(%{user_id: 3, author_id: 3})
