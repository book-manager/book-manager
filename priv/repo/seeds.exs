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
Booker.Auth.create_user(%{
  email: "james@gmail.com",
  name: "James",
  surname: "Bond",
  password: "password",
  avatar_url: "https://avatars2.githubusercontent.com/u/10079912?s=460&v=4",
  is_admin: true
})

Booker.Auth.create_user(%{
  email: "mike@gmail.com",
  name: "Mike",
  surname: "Warren",
  password: "password",
  avatar_url: "https://randomuser.me/api/portraits/med/men/83.jpg",
  is_admin: false
})

Booker.Auth.create_user(%{
  email: "william@gmail.com",
  name: "William",
  surname: "Welch",
  password: "password",
  avatar_url: "https://randomuser.me/api/portraits/med/men/43.jpg",
  is_admin: false
})

names =
  ~w[Ewa Josef Mozelle Damaris Ching Elinor Mamie Kami Leigh Jennell Tommie Alexandria Estell Tennille Terry Alana Marylyn Debrah Sid Leonida]

surnames =
  ~w[Longmire Neu Sprankle Kenna Rodriques Nastasi Katrina Surber Mandie Brodsky Dixson Leung Pita Ruddell Betances Castaldo Kotek Battle Hornung Room Kinkade Gerhard]

avatar_url = "https://api.adorable.io/avatars/285/"

Enum.each(0..20, fn _ ->
  name = Enum.random(names)
  surname = Enum.random(surnames)
  email = name <> "." <> surname <> "@gmail.com"
  avatar = avatar_url <> name <> surname

  Booker.Auth.create_user(%{
    email: email,
    name: name,
    surname: surname,
    password: "password",
    avatar_url: avatar,
    is_admin: false
  })
end)

# 1
Booker.Author.create_authors(%{
  name: "Sławomir",
  surname: "Nieściur",
  avatar_url: "https://api.adorable.io/avatars/285/slawomir.niesciur",
  description:
    "Rocznik 1973. Z wykształcenia prawnik. Literaturą zafascynowany mniej więcej od siódmego roku życia, kiedy to po heroicznych bojach przedarł się przez znaleziony na strychu, doszczętnie sczytany i lekko nadgryziony przez myszy egzemplarz „Krzyżaków”. Pierwsze opowiadanie wystukał na tablecie za pomocą dotykowej klawiatury w spartańskich warunkach wsi polskiej bez dostępu do technologicznych udogodnień."
})

# 2
Booker.Author.create_authors(%{
  name: "Bartek",
  surname: "Biedrzycki",
  avatar_url: "https://api.adorable.io/avatars/285/bartek.biedrzycki",
  description:
    "Rocznik ’78, mąż Ali, ojciec Zuzy i Bruna, zamieszkuje w aglomeracji warszawskiej. Przez ponad dekadę pracował przy produkcji telewizyjnej, obecnie jest specjalistą IT. Ma niepotrzebny dyplom UW, uprawniający go do pracy w charakterze nauczyciela j. angielskiego. Starszy kapral rezerwy, po wzorowej służbie w Dywizjonie Artylerii Samobieżnej w Orzyszu. W armii zdarł dwie pary butów, za to wyniósł stamtąd honorowe krwiodawstwo."
})

# 3
Booker.Author.create_authors(%{
  name: "Dominika",
  surname: "Węcławek",
  avatar_url: "https://api.adorable.io/avatars/285/dominika.weclawek",
  description:
    "Urodzona w Sosnowcu, kilkukrotnie się przeprowadzała. Ukończyła wydział filozofii na UKSW. Obecnie mieszka we Wrocławiu wraz z dwójką dzieci.Zajmuje się głównie dziennikarstwem muzycznym, parentingowym i podróżniczym. Współpracowała m.in. z pismami Ślizg, Loop, Życie Warszawy, Machina, Przekrój, Zeszyty Komiksowe, Kartki czy National Geographic Traveler; pisała także dla portali internetowych, m.in. Interia.pl, t-mobile-music.pl oraz Foch.pl Redaktorka naczelna satyrycznego pisma parentingowego Bachor oraz czasopisma muzycznego M/I. Na stałe pracuje w agencji kreatywnej In Hot Water Company.W 2010 była jurorką konkursu komiksowego na MFKiG w Łodzi."
})

# 4
Booker.Author.create_authors(%{
  name: "Michał",
  surname: "Gołkowski",
  avatar_url: "https://api.adorable.io/avatars/285/michal.golkowski",
  description:
    "Zodiakalnie, patologiczny Wodnik z roku Stanu Wojennego. Wbrew pozorom samotnik, mizantrop i introwertyk. Z wykształcenia lingwista, z zamiłowania historyk wojskowości, z zawodu na co dzień tłumacz kabinowy ang-pol-ros. Obecnie stalker."
})

# 5
Booker.Author.create_authors(%{
  name: "Joanna",
  surname: "Kanicka",
  avatar_url: "https://api.adorable.io/avatars/285/joanna.kanicka",
  description:
    "Studentka kierunku kultura i praktyka tekstu, urodzona w 1995 roku we Wrocławiu. Fascynację uniwersum S.T.A.L.K.E.R.a wiąże z miłością do zapomnianych miejsc i języka rosyjskiego. Uwielbia samotne podróże i dobrą muzykę, czasami pójdzie też postrzelać z wiatrówki. Otwarta na nowe doświadczenia – żałuje, że życie jest zbyt krótkie, by spróbować wszystkiego. Poza tym typowy nocny marek; wena najczęściej przychodzi do niej po kryjomu, gdy wszyscy sąsiedzi już śpią."
})

# 6
Booker.Author.create_authors(%{
  name: "Andrzej",
  surname: "Ziemiański",
  avatar_url: "https://api.adorable.io/avatars/285/andrzej.ziemianski",
  description:
    "Porzucił prestiżową karierę naukową i zajął się pisaniem książek. Już po kilku latach zdobył uznanie pół miliona Polaków czytających Achaję z wypiekami na twarzach. Z wykształcenia jest architektem. Widzi i myśli obrazami. Podgląda, słucha i rozmawia dla przyjemności. Lubi fotografować puste miejsca. Sam jest dla siebie pracownikiem, szefem i przewodniczącym komitetu strajkowego. Nieustannie prowokuje czytelników i recenzentów swoim podejściem do sztuki pisania. Mówi, że cierpi na przymus tworzenia."
})

# 7
Booker.Author.create_authors(%{
  name: "Andrzej",
  surname: "Pilipiuk",
  avatar_url: "https://api.adorable.io/avatars/285/andrzej.pilipiuk",
  description:
    "Andrzej Pilipiuk (1974) człowiek z przeszłości. Niestrudzony tropiciel ciekawostek z lamusa. Kolekcjoner nagród literackich, który z pisania z pasją uczynił swój sposób na życie. Miarą jego sukcesu jest 26 napisanych powieści wydanych w ciągu dekady, 600 tysięcy sprzedanych książek i miejsce na podium ścisłej czołówki najpoczytniejszych pisarzy w Polsce. Homo literatus, który do pisania podchodzi z żelazną regułą – pracuje planowo, codziennie, a kiedy poczuje zmęczenie fabułą, zabiera się za inny tytuł. Uprzedzając krytykę sam siebie nazwał Wielkim Grafomanem. Z wykształcenia archeolog, z zamiłowania łowca meteorów. Beznadziejnie zauroczony zapomnianymi odkrywcami i wynalazkami XIX wieku. Społecznik. Własnym sumptem i ogromnym zaangażowaniem wydał unikatowy album o Wojsławicach, mieście w którym narodził się Jakub Wędrowycz."
})

# 8
Booker.Author.create_authors(%{
  name: "Mirosław",
  surname: "Zamboch",
  avatar_url: "https://fabrykaslow.com.pl/wp/wp-content/uploads/2016/03/%C5%BCamboch.jpg",
  description: "Urodził się 13 stycznia 1972 roku w Hranicach na Morawach. Okazał się niebagatelnym umysłem ścisłym – ukończył fizykę na wydziale inżynierii jądrowej Politechniki Praskiej, potem pracował w Instytucie Badań Jądrowych w miejscowości Řež, zajmując się tam między innymi… rozbijaniem atomów. \n\n Na czeskim rynku czytelniczym debiutował w 1995. Koniasz, bohater, który uczynił go sławnym, pojawił się po raz pierwszy w zbiorze opowiadań „Ostatni bierze wszystko” w 2000 r. \n\n Jego powieści bywają uznawane za kontrowersyjne; ich cechą charakterystyczną jest duża dawka akcji (i krwi wrogów) oraz kreacje głównych bohaterów – „prawdziwych twardzieli”. \n\nŽamboch jest miłośnikiem sportów ekstremalnych (rowerowy downhill), amatorsko boksuje, walczy w pokazach judo, jego pasją jest również wbieganie na górskie szczyty. Doświadczenia te wykorzystuje w swojej twórczości. Inne zainteresowania: kobiety, wino i śpiew. \n\nJego ulubione lektury to Władca Pierścieni J.R.R. Tolkiena i Diuna F. Herberta, aczkolwiek jego pisarstwo dzieł tych twórców raczej nie przypomina – Žamboch stawia na akcję."
})

# 9
Booker.Author.create_authors(%{
  name: "Andriej",
  surname: "Lewicki",
  avatar_url: "https://fabrykaslow.com.pl/wp/wp-content/uploads/2016/03/lewicki.jpeg",
  description: "Człowiek Zony \n\nDzieciństwo spędził w Czarnobylu. Po Katastrofie zdarzało mu się wielokrotnie odwiedzać teren Zony, nocując w porzuconych wsiach i miasteczkach, ukrywając się przed patrolującą Strefę ukraińską milicją. Właśnie to doświadczenie zaowocowało w trakcie pracy nad tworzeniem scenariuszy do gry „S.T.A.L.K.E.R. – Zew Prypeci” i jego obecnej działalności w projekcie Survarium.\nOpublikował (również we współpracy z innymi autorami) ponad 40 powieści, 10 mikropowieści i kilkadziesiąt opowiadań.\nPisarz chętnie sięga po książki Lema i Sienkiewicza, ogląda filmy noir z lat 40. i 50. oraz słucha czarnego bluesa i starego dobrego rocka. \nNajlepiej czuje się w górach z laptopem i termosem kawy, pisząc kolejny rozdział książki."
})

# 10
Booker.Author.create_authors(%{
  name: "Paweł",
  surname: "Kornew",
  avatar_url: "https://fabrykaslow.com.pl/wp/wp-content/uploads/2016/03/kornew.jpeg",
  description: "Urodził się w 1978 roku w Czelabińsku, gdzie mieszka po dziś dzień. W 2000 roku ukończył studia ekonomiczne na Uniwersytecie Czelabińskim i prawie dziewięć lat przepracował w wyuczonym zawodzie. Obecnie całkowicie koncentruje się na twórczości literackiej.\n\nPisać, mniej lub bardziej systematycznie, zaczął w 2003 roku i wtedy powstały pierwsze rozdziały Sopla, powieści, która ukazała się nakładem wydawnictwa Alfa-kniga w styczniu 2006 roku, a już we wrześniu została uhonorowana nagrodą Miecz bez imienia (Nagroda ufundowana przez Wydawnictwo Alfa-kniga, jako zachęta dla młodych i nieznanych twórców fantastyki akcji i humorystycznej oraz w celu odrodzenia najlepszych tradycji literatury rosyjskiej. Nazwa nagrody pochodzi od tytułu powieści Andrieja Bielanina). Pierwsza tetralogia z cyklu Przygranicze została wydana w Polsce przez Fabrykę Słów."
})

# BOOK 1
Booker.Books.create_book(%{
  title: "2586 Kroków",
  author_id: 7,
  cover_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/77a50bd1-b0c0-c009-7e53-dd749e9efa4a.jpg",
  thumbnail_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/77a50bd1-b0c0-c009-7e53-dd749e9efa4a.jpg",
  isbn: "9788375749298",
  description:
    "I znowu odliczamy 2586 kroków... Tylko tyle. I aż tyle. Opowiadanie po opowiadaniu. To już V wydanie antologii, w nowej okładce, bez Wędrowycza, za to ze znakiem firmowym Pilipiuka w postaci niepowtarzalnego humoru i zdumiewających pomysłów. Czternaście historii, z których wieje grozą i mrocznym nastrojem. Odliczmy więc 2586 kroków... I krok: To jedna z najlepszych polskich antologii. Bardzo dobrze, lekko napisana, pełna świetnych pomysłów, ciekawa i świeża. Obowiązkowa rzecz na każdej półce. (Tomasz Kleta, Avatarae) II krok: 14 opowiadań zebranych w 1 książce to 13 różnych bohaterów, 14 niesamowitych historii, 14świetnych pomysłów i kilka godzin ciekawej lektury. (Piotr 'Szarik' Iwanicki, Playback) III krok: Najlepsze ze zbioru - tytułowe 2586 kroków i Wieczorne dzwony — to najdojrzalsze i najlepiej dopracowane opowiadania grozy, urzekające mrocznym nastrojem, bazującym na lęku przed chorobą, godne porównań do klimatów twórczości E. A. Poe. (Małgorzata Koczańska, Fahrenheit) Dalej liczcie już sami..."
})

# BOOK 2
Booker.Books.create_book(%{
  title: "Ostatniego zeżra psy",
  author_id: 1,
  cover_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/b80f5ef8-186e-08bd-6f05-45f0fe4042a2.jpg",
  thumbnail_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/b80f5ef8-186e-08bd-6f05-45f0fe4042a2.jpg",
  isbn: "9788379642533",
  description: "Myślisz, że widziałeś już wszystko, ale Zona potrafi zaskoczyć… \n Elektronika wysiada, nad Strefą wisi łuna niewiadomego pochodzenia, pojawiający się znikąd ogień trawi sprzęt, który – wydawałoby się – przetrwa najgorsze. \nCoś się porobiło… ze wszystkim. \n Badania nad mutacjami, a co za tym idzie dziesiątki sterowanych emisji, wymykają się spod kontroli. \n Myśliwi mają szansę odkryć prawdę, ale jak mówił Lenin: Abstrakcyjnej prawdy nie ma, prawda jest zawsze konkretna."
})

# Book 3
Booker.Books.create_book(%{
  title: "Według zasług",
  author_id: 1,
  cover_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/d420b7eb-2cb3-2b95-1cd6-c231f6b1d387.jpg",
  thumbnail_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/d420b7eb-2cb3-2b95-1cd6-c231f6b1d387.jpg",
  isbn: "9788379641857",
  description:
    "Wiosną 2006 roku Czarnobylska Strefa Wykluczenia przypomina rezerwat dzikiej przyrody. W istocie jednak jest ogromnym poligonem badawczym. \n Kiedy dochodzi do katastrofy, tereny wokół elektrowni przekształcają się w najeżone anomaliami piekło – Zonę. To w niej znajdują schronienie przypuszczalni jej sprawcy, zaś dekadę później rozpoczyna się ostatnia runda śmiertelnej rozgrywki. Starcia, w którym drapieżnik staje się zwierzyną, a zwierzyna – drapieżnikiem. \nBrawurowo opowiedziana, eksploatująca nowe wątki historia z uniwersum S.T.A.L.K.E.R. –a."
})

# Book 4
Booker.Books.create_book(%{
  title: "Upadła świątynia",
  author_id: 3,
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/ac3e348a-5eba-f75b-bacf-87e0cdcb3b74.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/ac3e348a-5eba-f75b-bacf-87e0cdcb3b74.jpg",
  isbn: "9788379641215",
  description: "Dwie dekady po Zagładzie skuta lodem i pogrzebana pod radioaktywnym śniegiem metropolia wydaje się być martwa. Przyroda jednak nie znosi próżni. \n Pojawił się ktoś, lub coś, co wabi do siebie ocaleńców, skazując ich na śmierć. Z samego serca stołecznego metra wyrusza więc specjalna ekspedycja. \nJej członków łączy niewiele, a różni niemal wszystko. Przeprawa przez wyklęte rewiry, nawiedzone pustkowia i mroczne podziemia okaże się prawdziwym wyzwaniem. \nNa szczęście rozkazy generała są jasne: dotrzeć do prawdy, nie dać się zabić, wszystkie zagrożenia eliminować bez pytania. Pozostaje tylko jedna wątpliwość, czy aby na pewno na uwadze władz jest dobro całej społeczności Tuneli?"
})

# Book 5
Booker.Books.create_book(%{
  title: "Stacja Nowy Świat",
  author_id: 2,
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/476de0a8-1d52-678a-666c-462cd6dc356a.jpg",
  thumbail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/476de0a8-1d52-678a-666c-462cd6dc356a.jpg",
  isbn: "9788379640676",
  description: "Wojna wygnała ludzi z Warszawy, zostali tylko ci, którzy zdążyli zejść pod ziemię. Ocaleni w tunelach, na stacjach i podziemnych dworcach wiodą trudny żywot w mroku, zimnie i wilgoci, walcząc o jedzenie i kąt do spania. \nNa Ursynowie swoją domenę buduje emerytowany kapitan wojska polskiego, pod Wisłą realizuje swoje ambicje kapral-dezerter. Zachowawczy stary wyga i agresywny młody wilk – stołeczna kolej podziemna jest dla nich dwóch za mała, a starcie takich charakterów musi skończyć się wielką wojną. Wojną w tunelach, wojną na peronach, wojną w ruinach wymarłego miasta, gdzie pośród zwiadowców, stalkerów i kobiet-wojowniczek bohaterem może stać się każdy. Nawet mały chłopiec… \nPoznaj legendę warszawskiego metra, dowiedz się, za co zginął Licznik, czemu Przymierze nazywane jest Ostatnim i dlaczego Madonna Tuneli patronuje właśnie stalkerom!"
})

# Book 6
Booker.Books.create_book(%{
  title: "Zakuty w stal",
  author_id: 8,
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/f8c24124-fed4-019d-b7b6-bde484ea22db.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/f8c24124-fed4-019d-b7b6-bde484ea22db.jpg",
  isbn: "9788379642649",
  description: "Świat stał się pustynią, skażoną chemicznymi i radioaktywnymi truciznami. Czterysta lat po zakończeniu wojny globalnej ludzie potrzebują źródeł, surowców i przestrzeni życiowej. \nPrzeszkadzają im w tym pogrobowcy Starej Wojny - stopniowo rozpadające się, ale nadal aktywne autonomiczne maszyny bojowe i degradujące się sztuczne inteligencje.\nMatyjasz Sanders jest mechanikiem wcielonym na siłę do załogi wielkiego czołgu.\nTo zbieranina zawodowych najemników zapewniających ochronę konwojom handlowym.\nDobry pancerz, sprzężone działka i armata, to jedne z największych gwarancji pokoju.\nZbliża się dzień, w którym ziemia znów będzie należała do ludzi."
})

# Book 7
Booker.Books.create_book(%{
  title: "Wstęga",
  author_id: 9,
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/0788674c-ace9-14ec-2c0c-dee77cfd70ef.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/0788674c-ace9-14ec-2c0c-dee77cfd70ef.jpg",
  isbn: "9788379641994",
  description: "Nazywa się Paweł Nowickij. Żołnierz i przewoźnik rzeczy podejrzanych, przemytnik narkotyków, bohater wojny i Ojczyzny. Ocknął się sam, w sercu sekretnego Kompleksu, do wtóru wycia syreny alarmowej.\nWokół niego – tylko ciała towarzyszy.\nCzerwony blask lamp awaryjnych. \nI pustka w głowie.\nKompleks stoi przy samym Kordonie, gigantyczną ścianą opasującym przedziwną i śmiertelnie niebezpieczną Ziemię Utraconą. Nasz bohater zmuszony jest do wyjścia z Kompleksu i wyruszenia w długą podróż poprzez niegościnne terytorium. Myślicie, że gra toczy się o losy kraju, czy nawet świata? Gdyby tylko tyle! Mówimy tu o ciągłości całego kontinuum czasoprzestrzennego, które nagle zależy od decyzji i czynów jednego człowieka."
})

# Book 8
Booker.Books.create_book(%{
  title: "Tam gdzie ciepło",
  author_id: 10,
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/de081c1b-c9e0-1c0b-0a58-cb672c60710c.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/de081c1b-c9e0-1c0b-0a58-cb672c60710c.jpg",
  isbn: "9788379641758",
  description: "Przygranicze to kilka okręgów i miast wyrwanych z naszego świata i ciśniętych w krainę wiecznego mrozu. Fort jest jednocześni sercem Przygranicza i jego dnem. To od samych podstaw zmrożona kloaka, zamieszkana przez ludzi bynajmniej nie serdecznych, którzy cenę ludzkiego życia mierzą nierzadko wartością pudełka nabojów bądź skrzynki konserw.\n\nPozornie nie da się upaść niżej, dopóki los nie podstawi człowiekowi nogi i nie zmusi do porzucenia w miarę spokojnego życia i panicznej ucieczki gdzie oczy poniosą, byle znaleźć nowe miejsce na tym świecie.\nAle nawet tam, gdzie ciepło nie można tracić czujności. Jewgienij Maksymowicz Apostoł, do niedawna mieniący się człowiekiem sukcesu, przekona się o tym na własnej skórze. Chociaż oczekująca go w Siewierorieczeńsku praca z początku wydawała się całkiem-całkiem..."
})

Booker.Books.create_book_ownership(%{book_id: 1, user_id: 1, read: false})
Booker.Books.create_book_ownership(%{book_id: 3, user_id: 1, read: false})
Booker.Books.create_book_ownership(%{book_id: 2, user_id: 2, read: false})
Booker.Books.create_book_ownership(%{book_id: 1, user_id: 2, read: false})
Booker.Books.create_book_ownership(%{book_id: 6, user_id: 1, read: true})
Booker.Books.create_book_ownership(%{book_id: 7, user_id: 1, read: true})
Booker.Books.create_book_ownership(%{book_id: 8, user_id: 1, read: true})
Booker.Books.create_book_ownership(%{book_id: 4 user_id: 1, read: true})

# James
Booker.Author.create_ownership(%{user_id: 1, author_id: 1})
Booker.Author.create_ownership(%{user_id: 1, author_id: 2})
Booker.Author.create_ownership(%{user_id: 1, author_id: 3})
Booker.Author.create_ownership(%{user_id: 1, author_id: 6})
Booker.Author.create_ownership(%{user_id: 1, author_id: 7})
Booker.Author.create_ownership(%{user_id: 1, author_id: 8})
Booker.Author.create_ownership(%{user_id: 1, author_id: 9})
Booker.Author.create_ownership(%{user_id: 1, author_id: 10})

# Mike
Booker.Author.create_ownership(%{user_id: 2, author_id: 7})
Booker.Author.create_ownership(%{user_id: 2, author_id: 4})
Booker.Author.create_ownership(%{user_id: 3, author_id: 3})
