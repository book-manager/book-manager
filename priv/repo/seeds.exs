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
alias Booker.Repo
alias Booker.Books.Book
alias Booker.Authors.Author

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
  avatar_url: "https://images.bookmanager.pro/user/myAvatar.png",
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

slawomir = Repo.insert!(%Author{
  name: "Sławomir",
  surname: "Nieściur",
  avatar_url: "https://api.adorable.io/avatars/285/slawomir.niesciur",
  description:
    "Rocznik 1973. Z wykształcenia prawnik. Literaturą zafascynowany mniej więcej od siódmego roku życia, kiedy to po heroicznych bojach przedarł się przez znaleziony na strychu, doszczętnie sczytany i lekko nadgryziony przez myszy egzemplarz „Krzyżaków”. Pierwsze opowiadanie wystukał na tablecie za pomocą dotykowej klawiatury w spartańskich warunkach wsi polskiej bez dostępu do technologicznych udogodnień."
})

ostatniego_zezra_psy = %Book{
  title: "Ostatniego zeżra psy",
  cover_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/b80f5ef8-186e-08bd-6f05-45f0fe4042a2.jpg",
  thumbnail_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/b80f5ef8-186e-08bd-6f05-45f0fe4042a2.jpg",
  isbn: "9788379642533",
  description: "Myślisz, że widziałeś już wszystko, ale Zona potrafi zaskoczyć… \n Elektronika wysiada, nad Strefą wisi łuna niewiadomego pochodzenia, pojawiający się znikąd ogień trawi sprzęt, który – wydawałoby się – przetrwa najgorsze. \nCoś się porobiło… ze wszystkim. \n Badania nad mutacjami, a co za tym idzie dziesiątki sterowanych emisji, wymykają się spod kontroli. \n Myśliwi mają szansę odkryć prawdę, ale jak mówił Lenin: Abstrakcyjnej prawdy nie ma, prawda jest zawsze konkretna."
}

wedlug_zaslug = %Book{
  title: "Według zasług",
  cover_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/d420b7eb-2cb3-2b95-1cd6-c231f6b1d387.jpg",
  thumbnail_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/d420b7eb-2cb3-2b95-1cd6-c231f6b1d387.jpg",
  isbn: "9788379641857",
  description:
    "Wiosną 2006 roku Czarnobylska Strefa Wykluczenia przypomina rezerwat dzikiej przyrody. W istocie jednak jest ogromnym poligonem badawczym. \n Kiedy dochodzi do katastrofy, tereny wokół elektrowni przekształcają się w najeżone anomaliami piekło – Zonę. To w niej znajdują schronienie przypuszczalni jej sprawcy, zaś dekadę później rozpoczyna się ostatnia runda śmiertelnej rozgrywki. Starcia, w którym drapieżnik staje się zwierzyną, a zwierzyna – drapieżnikiem. \nBrawurowo opowiedziana, eksploatująca nowe wątki historia z uniwersum S.T.A.L.K.E.R. –a."
}

ostatniego_zezra_psy_book = Ecto.build_assoc(slawomir, :books, ostatniego_zezra_psy)
wedlug_zaslug_book = Ecto.build_assoc(slawomir, :books, wedlug_zaslug)

Repo.insert!(ostatniego_zezra_psy_book)
Repo.insert!(wedlug_zaslug_book)

# =====================================

author = Repo.insert!(%Author{
  name: "Bartek",
  surname: "Biedrzycki",
  avatar_url: "https://api.adorable.io/avatars/285/bartek.biedrzycki",
  description:
    "Rocznik ’78, mąż Ali, ojciec Zuzy i Bruna, zamieszkuje w aglomeracji warszawskiej. Przez ponad dekadę pracował przy produkcji telewizyjnej, obecnie jest specjalistą IT. Ma niepotrzebny dyplom UW, uprawniający go do pracy w charakterze nauczyciela j. angielskiego. Starszy kapral rezerwy, po wzorowej służbie w Dywizjonie Artylerii Samobieżnej w Orzyszu. W armii zdarł dwie pary butów, za to wyniósł stamtąd honorowe krwiodawstwo."
})

dworzec = %Book{
  title: "Dworzec śródmieście",
  cover_url: "https://images.bookmanager.pro/book/cover/dworzec-srodmiescie.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/dworzec-srodmiescie.jpg",
  isbn: "9788379641826",
  description: "Warszawa po Zagładzie to o wiele więcej, niż metro. Ludzie żyją tu na podziemnych dworcach, w piwnicach, w zapomnianych przejściach. Mieszkańcy tych miejsc śmieją się i płaczą, kochają i nienawidzą, czekają – czasem sami nie wiedzą na co; szukają – rzadko wiedząc czego. Żyją i umierają. Ale czasem, kiedy umierają zbyt gwałtownie, krucha równowaga i prowizoryczna umowa społeczna zostają naruszone. Czasem za krew można zapłacić nabojami, czasem książkami, a czasem odpłatą może być tylko krew.\n\nCzy po wojnie atomowej nie ma już dobrych ludzi? Czy każdy człowiek, nawet ten z pozoru najlepszy, ma w sobie utajonego zbrodniarza, który za godziwą zapłatę zrobi wszystko? Ile warte jest w takim świecie życie – życie brata, życie męża, życie syna..\n\nNapisana z wielkim rozmachem kulminacja przygód rudobrodego stalkera Borki z Kryształowego Pałacu, pokazująca życie Warszawy poza systemem stołecznego metra od chwili Zagłady, aż po czasy najnowsze. Klucz do zrozumienia wydarzeń trylogii warszawskiej, odkrywający wszystkie tajemnice i misterną siatkę powiązań między pozornie nieznajomymi bohaterami."
}

stacja = %Book{
  title: "Stacja Nowy Świat",
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/476de0a8-1d52-678a-666c-462cd6dc356a.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/476de0a8-1d52-678a-666c-462cd6dc356a.jpg",
  isbn: "9788379640676",
  description: "Wojna wygnała ludzi z Warszawy, zostali tylko ci, którzy zdążyli zejść pod ziemię. Ocaleni w tunelach, na stacjach i podziemnych dworcach wiodą trudny żywot w mroku, zimnie i wilgoci, walcząc o jedzenie i kąt do spania. \nNa Ursynowie swoją domenę buduje emerytowany kapitan wojska polskiego, pod Wisłą realizuje swoje ambicje kapral-dezerter. Zachowawczy stary wyga i agresywny młody wilk – stołeczna kolej podziemna jest dla nich dwóch za mała, a starcie takich charakterów musi skończyć się wielką wojną. Wojną w tunelach, wojną na peronach, wojną w ruinach wymarłego miasta, gdzie pośród zwiadowców, stalkerów i kobiet-wojowniczek bohaterem może stać się każdy. Nawet mały chłopiec… \nPoznaj legendę warszawskiego metra, dowiedz się, za co zginął Licznik, czemu Przymierze nazywane jest Ostatnim i dlaczego Madonna Tuneli patronuje właśnie stalkerom!"
}

kompleks = %Book{
  title: "Kompleks 7215",
  cover_url: "https://images.bookmanager.pro/book/cover/kompleks-7215.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/kompleks-7215.jpg",
  isbn: "9788375749878",
  description: "Warszawskie metro dwie dekady po wojnie atomowej.\n\nPo globalnym konflikcie termonuklearnym w podziemiach zrujnowanej aglomeracji warszawskiej żyją ludzie. Chowają się przed, radiacją, mutantami i innymi zagrożeniami, które sprawiły, że życie na powierzchni przestało być już możliwe.\n\nBorka, najemnik-intelektualista z sojuszu Kryształowy Pałac, dowódca oddziału stalkerów, podejmuje absurdalną misję odnalezienia Atomowej Kwatery Dowodzenia w Puszczy Kampinoskiej i wyrusza ze swoją drużyną w podróż na północ pierwszej linii metra, do ostatniej stacji i dalej…\n\nPrawdziwa gratka dla miłośników ZONY, literatury wojennej i militariów."
}

dworzec_book = Ecto.build_assoc(author, :books, dworzec)
stacja_book = Ecto.build_assoc(author, :books, stacja)
kompleks_book = Ecto.build_assoc(author, :books, kompleks)

Repo.insert!(dworzec_book)
Repo.insert!(stacja_book)
Repo.insert!(kompleks)

# ==============================================

golkowski = Repo.insert!(%Author{
  name: "Michał",
  surname: "Gołkowski",
  avatar_url: "https://api.adorable.io/avatars/285/michal.golkowski",
  description:
    "Zodiakalnie, patologiczny Wodnik z roku Stanu Wojennego. Wbrew pozorom samotnik, mizantrop i introwertyk. Z wykształcenia lingwista, z zamiłowania historyk wojskowości, z zawodu na co dzień tłumacz kabinowy ang-pol-ros. Obecnie stalker."
})

sztywny = %Book{
  title: "Sztywny",
  cover_url: "https://images.bookmanager.pro/book/cover/sztywny.jpg",
  thumbnail_url: "https://images.bookmanager.pro/resized/cover/sztywny.jpg",
  isbn: "9788379640645",
  description: "Sztywny ma problem.\n\nRzecz nie w tym, że jego partnerzy nie wracają z Zony.\n\nNie chodzi wcale o to, że zdecydowanie za dużo pije i za ostro wciąga.\n\nProblemem nie jest nawet to, że Sztywny nie potrafi utrzymać w spodniach swoich części niesfornych.Bynajmniej.\n\nProblemem jest sam Sztywny."
}

drugi_brzeg = %Book{
  title: "Drugi brzeg",
  cover_url: "https://images.bookmanager.pro/book/cover/drugi_brzeg.jpg",
  thumbnail_url: "https:/.images.bookmanager.pro/book/resized/drugi_brzeg.jpg",
  isbn: "9788375749939",
  description: "Kontynuacja przebojowego Ołowianego Świtu\n\nPrypeć – wymarłe miasto-antychryst\n\nWyścig z czasem w świecie po katastrofie. Stalker Miszka przechodzi na prawy brzeg rzeki – nigdy wcześniej tak daleko nie zabrnął.\n\nPodróż do Serca Zony: Martwe Miasto, Oko Moskwy i czarnobylskie cmentarzysko statków w otoczeniu lasów i bagien."
}

droga = %Book{
  title: "Droga donikąd",
  cover_url: "https://images.bookmanager.pro/book/cover/droga-donikad.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/droga-donikad.jpg",
  isbn: "9788375745016",
  description: "„Droga do nikąd” to trzecia część trylogii Michała Gołkowskiego, a zarazem powrót do przeszłości i przedstalkerskiego życia Miszy sprzed „Ołowianego świtu”. Bohater, który w dwóch poprzednich tomach zawładnął umysłami tysięcy polskich czytelników, dochodzi do wniosku, że ma dosyć swojego monotonnego życia, bo mając wszystko, tak naprawdę nie ma niczego. Opuszcza swój warszawski apartament i wyrusza w nieznane, by mierzyć się z własną głupotą i wzbogacać bagaż doświadczeń. Uliczkami Mińska i ciemnymi zaułkami Brahina trafia do samej Zony. To tu poznaje tajemnice, które niczym stalker, będą go prześladować przez resztę jego życia.\n\n„Droga do nikąd” to koniec a zarazem początek historii, osadzonej w realiach kultowej już gry S.T.A.L.K.E.R. Wszyscy jesteśmy stalkerami, a największe zło jakie może spotkać cię z Zonie to drugi człowiek. Czy przeżyjesz?"
}

olowiany_swit = %Book{
  title: "Ołowiany świt",
  cover_url: "https://images.bookmanager.pro/book/cover/olowiany_swit.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/olowiany_swit.jpg",
  isbn: "9788375747362",
  description: "Zona - tajemnica, która wciąga, kusi i intryguje.\n\nJej historią jest świat współczesny. Jej dzieci to my.\n\nUniwersum S.T.A.L.K.E.R.a oczami Polaka – stara mleczarnia, martwy cieć, zapomniany kalendarz i wieża w środku lasu. Wchodzisz w to? Zresztą, już jesteś. Wszyscy jesteśmy – stalkerami. Dziećmi Sarkofagu.\n\nTutaj wrogiem jest zło, które może czaić się tuż obok, za naszymi plecami. Może przyjmować różne postaci, imiona i kształty; jednak najstraszniejszym, co możemy spotkać w Zonie - jest człowiek."
}

powrot = %Book{
  title: "Powrót",
  cover_url: "https://images.bookmanager.pro/book/cover/powrot.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/powrot.jpg",
  isbn: "9788379643202",
  description: "Obiecywał sobie, że już nigdy więcej. Że tamten raz był naprawdę ostatni. Że wszystko się zmieni, znormalnieje. Jednak ciężko jest udawać normalnego człowieka. Kiedy do drzwi puka przeszłość w osobie postrzelonego przyjaciela-stalkera z dawnych lat, a zimowa zawierucha niesie w sobie szepty zza dalekiego Kordonu, trzeba schować do kieszeni moralność i odwiesić na kołek solenne obietnice.\n\nNadchodzi pora, żeby raz jeszcze zostawić za sobą Dużą Ziemię i po raz kolejny - tym razem naprawdę już ostatni - wkroczyć na bezdroża ziemi utraconej, którą jest czarnobylska Zona. Bo nic innego nie ma znaczenia, kiedy człowiek usłyszy Zew.\n\nNadeszła pora ostatniej przygody."
}

sztywny_book = Ecto.build_assoc(golkowski, :books, sztywny)
drugi_brzeg_book = Ecto.build_assoc(golkowski, :books, drugi_brzeg)
droga_book = Ecto.build_assoc(golkowski, :books, droga)
olowiany_swit_book = Ecto.build_assoc(golkowski, :books, olowiany_swit)
powrot_book = Ecto.build_assoc(golkowski, :books, powrot)

Repo.insert!(sztywny_book)
Repo.insert!(drugi_brzeg_book)
Repo.insert!(droga_book)
Repo.insert!(olowiany_swit_book)
Repo.insert!(powrot_book)

# ============================================

weclawek = Repo.insert!(%Author{
  name: "Dominika",
  surname: "Węcławek",
  avatar_url: "https://api.adorable.io/avatars/285/dominika.weclawek",
  description:
    "Urodzona w Sosnowcu, kilkukrotnie się przeprowadzała. Ukończyła wydział filozofii na UKSW. Obecnie mieszka we Wrocławiu wraz z dwójką dzieci.Zajmuje się głównie dziennikarstwem muzycznym, parentingowym i podróżniczym. Współpracowała m.in. z pismami Ślizg, Loop, Życie Warszawy, Machina, Przekrój, Zeszyty Komiksowe, Kartki czy National Geographic Traveler; pisała także dla portali internetowych, m.in. Interia.pl, t-mobile-music.pl oraz Foch.pl Redaktorka naczelna satyrycznego pisma parentingowego Bachor oraz czasopisma muzycznego M/I. Na stałe pracuje w agencji kreatywnej In Hot Water Company.W 2010 była jurorką konkursu komiksowego na MFKiG w Łodzi."
})

swiatynia = %Book{
  title: "Upadła świątynia",
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/ac3e348a-5eba-f75b-bacf-87e0cdcb3b74.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/ac3e348a-5eba-f75b-bacf-87e0cdcb3b74.jpg",
  isbn: "9788379641215",
  description: "Dwie dekady po Zagładzie skuta lodem i pogrzebana pod radioaktywnym śniegiem metropolia wydaje się być martwa. Przyroda jednak nie znosi próżni. \n Pojawił się ktoś, lub coś, co wabi do siebie ocaleńców, skazując ich na śmierć. Z samego serca stołecznego metra wyrusza więc specjalna ekspedycja. \nJej członków łączy niewiele, a różni niemal wszystko. Przeprawa przez wyklęte rewiry, nawiedzone pustkowia i mroczne podziemia okaże się prawdziwym wyzwaniem. \nNa szczęście rozkazy generała są jasne: dotrzeć do prawdy, nie dać się zabić, wszystkie zagrożenia eliminować bez pytania. Pozostaje tylko jedna wątpliwość, czy aby na pewno na uwadze władz jest dobro całej społeczności Tuneli?"
}

swiatynia_book = Ecto.build_assoc(weclawek, :books, swiatynia)

Repo.insert!(swiatynia_book)

# ============================================

kanicka = Repo.insert!(%Author{
  name: "Joanna",
  surname: "Kanicka",
  avatar_url: "https://api.adorable.io/avatars/285/joanna.kanicka",
  description:
    "Studentka kierunku kultura i praktyka tekstu, urodzona w 1995 roku we Wrocławiu. Fascynację uniwersum S.T.A.L.K.E.R.a wiąże z miłością do zapomnianych miejsc i języka rosyjskiego. Uwielbia samotne podróże i dobrą muzykę, czasami pójdzie też postrzelać z wiatrówki. Otwarta na nowe doświadczenia – żałuje, że życie jest zbyt krótkie, by spróbować wszystkiego. Poza tym typowy nocny marek; wena najczęściej przychodzi do niej po kryjomu, gdy wszyscy sąsiedzi już śpią."
})

bagno = %Book{
  title: "Bagno szaleńców",
  author_id: 5,
  cover_url: "https://storage.googleapis.com/images.bookmanager.pro/book/cover/bagno_szalencow.jpg",
  thumbnail_url: "https://storage.googleapis.com/images.bookmanager.pro/book/resized/bagno_szalencow.jpg",
  isbn: "9788379643158",
  description: "Wszyscy wiedzą, że po Zonie należy się spodziewać niespodziewanego a najbardziej zadziwiające dziwy nie powinny dziwić. A jednak, gdy przez okno na 1 pietrze wpada w środku dnia artefakt zwany „blaskiem księżyca” Zielony i Łazik są bardzo zdziwieni. Nawet doświadczeni stalkerzy czasem dębieją. Wyjaśnienie niecodziennego zjawiska przychodzi bardzo szybko, wraz z niejakim Kosą i serią z karabinu. Jak to w Zonie.\n\nWydarzenie, które początkowo wydaje się niepodziewanym uśmiechem losu przeradza się w kolejny rajd w głąb Zony. A wszystko przez jednodniowy wypad po artefakty."
}

bagno_book = Ecto.build_assoc(kanicka, :books, bagno)

Repo.insert!(bagno_book)

# ============================================

ziemianski = Repo.insert!(%Author{
  name: "Andrzej",
  surname: "Ziemiański",
  avatar_url: "https://api.adorable.io/avatars/285/andrzej.ziemianski",
  description:
    "Porzucił prestiżową karierę naukową i zajął się pisaniem książek. Już po kilku latach zdobył uznanie pół miliona Polaków czytających Achaję z wypiekami na twarzach. Z wykształcenia jest architektem. Widzi i myśli obrazami. Podgląda, słucha i rozmawia dla przyjemności. Lubi fotografować puste miejsca. Sam jest dla siebie pracownikiem, szefem i przewodniczącym komitetu strajkowego. Nieustannie prowokuje czytelników i recenzentów swoim podejściem do sztuki pisania. Mówi, że cierpi na przymus tworzenia."
})

# ============================================

pilipiuk = Repo.insert!(%Author{
  name: "Andrzej",
  surname: "Pilipiuk",
  avatar_url: "https://api.adorable.io/avatars/285/andrzej.pilipiuk",
  description:
    "Andrzej Pilipiuk (1974) człowiek z przeszłości. Niestrudzony tropiciel ciekawostek z lamusa. Kolekcjoner nagród literackich, który z pisania z pasją uczynił swój sposób na życie. Miarą jego sukcesu jest 26 napisanych powieści wydanych w ciągu dekady, 600 tysięcy sprzedanych książek i miejsce na podium ścisłej czołówki najpoczytniejszych pisarzy w Polsce. Homo literatus, który do pisania podchodzi z żelazną regułą – pracuje planowo, codziennie, a kiedy poczuje zmęczenie fabułą, zabiera się za inny tytuł. Uprzedzając krytykę sam siebie nazwał Wielkim Grafomanem. Z wykształcenia archeolog, z zamiłowania łowca meteorów. Beznadziejnie zauroczony zapomnianymi odkrywcami i wynalazkami XIX wieku. Społecznik. Własnym sumptem i ogromnym zaangażowaniem wydał unikatowy album o Wojsławicach, mieście w którym narodził się Jakub Wędrowycz."
})

kroki = %Book{
  title: "2586 Kroków",
  cover_url:
    "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/77a50bd1-b0c0-c009-7e53-dd749e9efa4a.jpg",
  thumbnail_url:
    "https://images.karolkozakowski.io/resized/2568-krokow.jpg",
  isbn: "9788375749298",
  description:
    "I znowu odliczamy 2586 kroków... Tylko tyle. I aż tyle. Opowiadanie po opowiadaniu. To już V wydanie antologii, w nowej okładce, bez Wędrowycza, za to ze znakiem firmowym Pilipiuka w postaci niepowtarzalnego humoru i zdumiewających pomysłów. Czternaście historii, z których wieje grozą i mrocznym nastrojem. Odliczmy więc 2586 kroków... I krok: To jedna z najlepszych polskich antologii. Bardzo dobrze, lekko napisana, pełna świetnych pomysłów, ciekawa i świeża. Obowiązkowa rzecz na każdej półce. (Tomasz Kleta, Avatarae) II krok: 14 opowiadań zebranych w 1 książce to 13 różnych bohaterów, 14 niesamowitych historii, 14świetnych pomysłów i kilka godzin ciekawej lektury. (Piotr 'Szarik' Iwanicki, Playback) III krok: Najlepsze ze zbioru - tytułowe 2586 kroków i Wieczorne dzwony — to najdojrzalsze i najlepiej dopracowane opowiadania grozy, urzekające mrocznym nastrojem, bazującym na lęku przed chorobą, godne porównań do klimatów twórczości E. A. Poe. (Małgorzata Koczańska, Fahrenheit) Dalej liczcie już sami..."
}

wampir = %Book{
  title: "Wampir z KC",
  cover_url: "https://storage.googleapis.com/images.bookmanager.pro/book/cover/wampir-z-kc.jpg",
  thumbnail_url: "https://storage.googleapis.com/images.bookmanager.pro/book/resized/wampir-z-kc.jpg",
  isbn: "9788379643127",
  description: "Komuna ustępuje miejsca krwiożerczemu kapitalizmowi, co jednak wcale nie oznacza, że wszystko nagle układa się świetnie. \n\nTo był taki dobry plan, co mogło się nie udać?! Miały być zyski z wyśrubowanych norm i wakacje w Bułgarii. Miał być wyzysk i poganianie klasy robotniczej batogiem przez spasionego burżuja z cygarem w zębach. Miało być tak pięknie. Miało, ale się...\n\nWampiry przeżywają szereg traum: najpierw Zakład Pracy wysyła je na urlop. Wiadomo, że najgorsze we wczasach jest to, że nie ma nic do roboty. A bez roboty człowiek głupieje. Wampir również, bo wampir wszak też człowiek, tylko nieco bardziej martwy.\n\nNastępnie Drucianka upada , mimo śmiałego planu naprawczego, który miał dziarskim i zwycięskim krokiem wprowadzić kulejący zakład w krwiożerczy kapitalizm. I znowu- najgorsze w bezrobociu jest to, że nie ma nic do roboty.\n\nMoże z powodu tych trudnych przeżyć oba wampiry nie mają tyle co kiedyś cierpliwości do kamieniczników czy byłych ubeków i ich pomysłów na nową rzeczywistość. W ogóle ta nowa rzeczywistość jakaś taka...podobna łudząco do tej starej.\n\nCóż, kapitalizm najwyraźniej już jest, ale kapitalistów zapomnieli dowieźć."
}

raport = %Book{
  title: "Raport z północy",
  cover_url: "https://storage.googleapis.com/images.bookmanager.pro/book/cover/raport-z-polnocy.jpg",
  thumbnail_url: "https://storage.googleapis.com/images.bookmanager.pro/book/resized/raport-z-polnocy.jpg",
  isbn: "9788379642915",
  description: "Podróż do wnętrza Wielkiego Grafomana, a jednocześnie wędrówka po jego ukochanej Skandynawii.\n\nTa książka jest poniekąd książką podróżniczą – jednak w przeciwieństwie do książek prawdziwych podróżników nie opisuję miejsc egzotycznych ani choćby trudno dostępnych. Zamiast to draństwo czytać możecie wsiąść w samolot tanich linii lotniczych i zobaczyć to wszystko na własne oczy.\n\nObsesją mojego życia zawsze była chęć odgryzienia się.\n\nPodjąłem walkę by nie dać się wdeptać w błoto. By się uratować. By się odegrać. By żyć po swojemu, a nie tak jak nam wymyślono. Moje podróże po Skandynawii to część tego planu. I ta książka jest pełna moich obsesji. To jest książka napisana przez wkurzonego niewolnika, który zdołał zerwać się z łańcucha.\n\nTo, o czym marzyłem, będąc nastolatkiem, spełniło się. Jestem pisarzem. Żyję w wolnym świecie otwartych granic w którym z samolotu korzysta się jak z PKS-u. Żegluję jachtem przez fiordy, czasem nawet stoję za sterem. Piszę książkę na laptopie. Nastąpiło dopełnienie. Ostatni kawałek rozsypanej układanki wskoczył na swoje miejsce."
}

kroki_book = Ecto.build_assoc(pilipiuk, :books, kroki)
wampir_book = Ecto.build_assoc(pilipiuk, :books, wampir)
raport_book = Ecto.build_assoc(pilipiuk, :books, raport)

Repo.insert!(kroki_book)
Repo.insert!(wampir_book)
Repo.insert!(raport_book)


# ============================================

zamboch = Repo.insert!(%Author{
  name: "Mirosław",
  surname: "Zamboch",
  avatar_url: "https://fabrykaslow.com.pl/wp/wp-content/uploads/2016/03/%C5%BCamboch.jpg",
  description: "Urodził się 13 stycznia 1972 roku w Hranicach na Morawach. Okazał się niebagatelnym umysłem ścisłym – ukończył fizykę na wydziale inżynierii jądrowej Politechniki Praskiej, potem pracował w Instytucie Badań Jądrowych w miejscowości Řež, zajmując się tam między innymi… rozbijaniem atomów. \n\n Na czeskim rynku czytelniczym debiutował w 1995. Koniasz, bohater, który uczynił go sławnym, pojawił się po raz pierwszy w zbiorze opowiadań „Ostatni bierze wszystko” w 2000 r. \n\n Jego powieści bywają uznawane za kontrowersyjne; ich cechą charakterystyczną jest duża dawka akcji (i krwi wrogów) oraz kreacje głównych bohaterów – „prawdziwych twardzieli”. \n\nŽamboch jest miłośnikiem sportów ekstremalnych (rowerowy downhill), amatorsko boksuje, walczy w pokazach judo, jego pasją jest również wbieganie na górskie szczyty. Doświadczenia te wykorzystuje w swojej twórczości. Inne zainteresowania: kobiety, wino i śpiew. \n\nJego ulubione lektury to Władca Pierścieni J.R.R. Tolkiena i Diuna F. Herberta, aczkolwiek jego pisarstwo dzieł tych twórców raczej nie przypomina – Žamboch stawia na akcję."
})

zakuty = %Book{
  title: "Zakuty w stal",
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/f8c24124-fed4-019d-b7b6-bde484ea22db.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/f8c24124-fed4-019d-b7b6-bde484ea22db.jpg",
  isbn: "9788379642649",
  description: "Świat stał się pustynią, skażoną chemicznymi i radioaktywnymi truciznami. Czterysta lat po zakończeniu wojny globalnej ludzie potrzebują źródeł, surowców i przestrzeni życiowej. \nPrzeszkadzają im w tym pogrobowcy Starej Wojny - stopniowo rozpadające się, ale nadal aktywne autonomiczne maszyny bojowe i degradujące się sztuczne inteligencje.\nMatyjasz Sanders jest mechanikiem wcielonym na siłę do załogi wielkiego czołgu.\nTo zbieranina zawodowych najemników zapewniających ochronę konwojom handlowym.\nDobry pancerz, sprzężone działka i armata, to jedne z największych gwarancji pokoju.\nZbliża się dzień, w którym ziemia znów będzie należała do ludzi."
}

percepcja = %Book{
  title: "Percepcja",
  cover_url: "https://images.bookmanager.pro/book/cover/percepcja.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/percepcja.jpg",
  isbn: "9788375747744",
  description: "Miroslav Żamboch i jego złe światy już niemal dekadę zwalają z nóg czytelników, których z każdą książką przybywa.\n\nTym razem Pragę zalewa fala wampirów, łatwych kobiet, motocykli, azjatyckich mieczy i morze czeskiej krwi. Zawrotne tempo akcji. Nawet zwykła bójka nagle zmienia się w regularną wojnę klanów. Nie ma miejsca na żarty, nie ma chwili na oddech.\n\nZłapałem go za kark i przycisnąłem do siebie. Stłumionym trzaskom wystrzałów towarzyszyły błyski ognia z otworu wentylacyjnego nad barem. W rytm tych wystrzałów drgała moja żywa tarcza. Przestała dopiero po ustaniu ognia\n\nWyrwałem zza pasa nóż do rzucania i cisnąłem go w otwór, z którego padły strzały. Chrapliwy jęk przekonał mnie, że rzut był celny."
}

klan = %Book{
  title: "W słuzbię klanu",
  cover_url: "https://images.bookmanager.pro/book/cover/w-sluzbie-klanu.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/w-sluzbie-klanu.jpg",
  isbn: "9788379640027",
  description: "Brutalny świat zajadłej wojny klanów. Wszystko co najlepsze z Żambocha.\n\nHerbert Ducatti wydobywa aktywne drogie kamienie dla klanu czarodziejów w Górach Północnych. Nie jest łatwo, bo skoncentrowana tam magia w przeciągu kilku godzin potrafi wypalić mózg każdego zwyczajnego człowieka. Na dużej głębokości wystarczy do tego kilka sekund. W Głębinie mogą przeżyć jedynie czarodzieje.\n\nKamieni pożądają wszystkie klany. A o to, czego chcą wszyscy, zazwyczaj toczy się krwawa walka.\n\nHerbert Ducatti chce tylko przeżyć… Chciał… przynajmniej na początku."
}

zakuty_book = Ecto.build_assoc(zamboch, :books, zakuty)
percepcja_book = Ecto.build_assoc(zamboch, :books, percepcja)
klan_book = Ecto.build_assoc(zamboch, :books, klan)

Repo.insert!(klan_book)
Repo.insert!(percepcja_book)
Repo.insert!(zakuty_book)

# ============================================

lewicki = Repo.insert!(%Author{
  name: "Andriej",
  surname: "Lewicki",
  avatar_url: "https://fabrykaslow.com.pl/wp/wp-content/uploads/2016/03/lewicki.jpeg",
  description: "Człowiek Zony \n\nDzieciństwo spędził w Czarnobylu. Po Katastrofie zdarzało mu się wielokrotnie odwiedzać teren Zony, nocując w porzuconych wsiach i miasteczkach, ukrywając się przed patrolującą Strefę ukraińską milicją. Właśnie to doświadczenie zaowocowało w trakcie pracy nad tworzeniem scenariuszy do gry „S.T.A.L.K.E.R. – Zew Prypeci” i jego obecnej działalności w projekcie Survarium.\nOpublikował (również we współpracy z innymi autorami) ponad 40 powieści, 10 mikropowieści i kilkadziesiąt opowiadań.\nPisarz chętnie sięga po książki Lema i Sienkiewicza, ogląda filmy noir z lat 40. i 50. oraz słucha czarnego bluesa i starego dobrego rocka. \nNajlepiej czuje się w górach z laptopem i termosem kawy, pisząc kolejny rozdział książki."
})

wstega = %Book{
  title: "Wstęga",
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/0788674c-ace9-14ec-2c0c-dee77cfd70ef.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/0788674c-ace9-14ec-2c0c-dee77cfd70ef.jpg",
  isbn: "9788379641994",
  description: "Nazywa się Paweł Nowickij. Żołnierz i przewoźnik rzeczy podejrzanych, przemytnik narkotyków, bohater wojny i Ojczyzny. Ocknął się sam, w sercu sekretnego Kompleksu, do wtóru wycia syreny alarmowej.\nWokół niego – tylko ciała towarzyszy.\nCzerwony blask lamp awaryjnych. \nI pustka w głowie.\nKompleks stoi przy samym Kordonie, gigantyczną ścianą opasującym przedziwną i śmiertelnie niebezpieczną Ziemię Utraconą. Nasz bohater zmuszony jest do wyjścia z Kompleksu i wyruszenia w długą podróż poprzez niegościnne terytorium. Myślicie, że gra toczy się o losy kraju, czy nawet świata? Gdyby tylko tyle! Mówimy tu o ciągłości całego kontinuum czasoprzestrzennego, które nagle zależy od decyzji i czynów jednego człowieka."
}

wojna = %Book{
  title: "Wojna",
  cover_url: "https://images.bookmanager.pro/cover/resized/wojna.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/wojna.jpg",
  isbn: "9788379642373",
  description: "Już myśleli, że mają zwycięstwo w zasięgu ręki.\n\nWiedźmak dostał się do Zagubionego Miasta, a oni deptali mi po piętach. Tylko skąd mieli wiedzieć, że miasto jest tylko nieistotnym punktem przerzutowym, a szaman wybiera się o wiele, wiele dalej?\n\n„Dalej” – czyli dokąd w ogóle? Czy może być coś jeszcze bardziej tajemniczego, zakazanego i nieznanego, niż owiane legendami centrum Sektora?\n\nOkazuje się, że tak. Były żołnierz Garsteczka, zabójca i najemnik Czerwony Kruk oraz uwięziony w ciele mutanta Chemik już wkrótce też to zrozumieją.\n\nZrozumieją – ale nie pojmą\n\nZrozumieją – ale nie pojmą"
}

wstega_book = Ecto.build_assoc(lewicki, :books, wstega)
wojna_book = Ecto.build_assoc(lewicki, :books, wojna)

Repo.insert!(wojna_book)
Repo.insert!(wstega_book)

# ============================================

kornew = Repo.insert!(%Author{
  name: "Paweł",
  surname: "Kornew",
  avatar_url: "https://fabrykaslow.com.pl/wp/wp-content/uploads/2016/03/kornew.jpeg",
  description: "Urodził się w 1978 roku w Czelabińsku, gdzie mieszka po dziś dzień. W 2000 roku ukończył studia ekonomiczne na Uniwersytecie Czelabińskim i prawie dziewięć lat przepracował w wyuczonym zawodzie. Obecnie całkowicie koncentruje się na twórczości literackiej.\n\nPisać, mniej lub bardziej systematycznie, zaczął w 2003 roku i wtedy powstały pierwsze rozdziały Sopla, powieści, która ukazała się nakładem wydawnictwa Alfa-kniga w styczniu 2006 roku, a już we wrześniu została uhonorowana nagrodą Miecz bez imienia (Nagroda ufundowana przez Wydawnictwo Alfa-kniga, jako zachęta dla młodych i nieznanych twórców fantastyki akcji i humorystycznej oraz w celu odrodzenia najlepszych tradycji literatury rosyjskiej. Nazwa nagrody pochodzi od tytułu powieści Andrieja Bielanina). Pierwsza tetralogia z cyklu Przygranicze została wydana w Polsce przez Fabrykę Słów."
})

cieplo = %Book{
  title: "Tam gdzie ciepło",
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/de081c1b-c9e0-1c0b-0a58-cb672c60710c.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/de081c1b-c9e0-1c0b-0a58-cb672c60710c.jpg",
  isbn: "9788379641758",
  description: "Przygranicze to kilka okręgów i miast wyrwanych z naszego świata i ciśniętych w krainę wiecznego mrozu. Fort jest jednocześni sercem Przygranicza i jego dnem. To od samych podstaw zmrożona kloaka, zamieszkana przez ludzi bynajmniej nie serdecznych, którzy cenę ludzkiego życia mierzą nierzadko wartością pudełka nabojów bądź skrzynki konserw.\n\nPozornie nie da się upaść niżej, dopóki los nie podstawi człowiekowi nogi i nie zmusi do porzucenia w miarę spokojnego życia i panicznej ucieczki gdzie oczy poniosą, byle znaleźć nowe miejsce na tym świecie.\nAle nawet tam, gdzie ciepło nie można tracić czujności. Jewgienij Maksymowicz Apostoł, do niedawna mieniący się człowiekiem sukcesu, przekona się o tym na własnej skórze. Chociaż oczekująca go w Siewierorieczeńsku praca z początku wydawała się całkiem-całkiem..."
}

cytadela = %Book{
  title: "Lodowa cytedela",
  cover_url: "https://images.bookmanager.pro/book/cover/lodowa-cytadela.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/lodowa-cytadela.jpg",
  isbn: "9788379640935",
  description: "Przygranicze to parę miast kilkadziesiąt lat temu wyrwanych z naszego świata i przeniesionych do krainy wiecznego mrozu. Dziwne miejsce, w którym przez większą część roku panują chłody i wieją lodowate wiatry, a ludzie nabywają magicznych zdolności, co czyni ich bardziej niebezpiecznymi od uzbrojonych po zęby bojowników.\n\nLecz człowiek umie przystosować się do każdych warunków, więc Jewgienij Apostoł już dawno przestał żałować, że trafił do Fortu - dawnego prowincjonalnego miasteczka, które stało się centrum cywilizacji na tej pokrytej śniegiem ziemi. I nawet kiedy przyszło wziąć nogi za pas, aby ratować skórę przed najemnymi zabójcami, przede wszystkim pomyślał o tym, jak nie zmarnować szansy na życiowy interes."
}

sopel = %Book{
  title: "Sopel",
  cover_url: "https://images.bookmanager.pro/book/cover/sopel.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/sopel.jpg",
  isbn: "9788379642267",
  description: "\n\nW świat Przygranicza trafiasz przypadkiem. Z woli losu. Wysiadasz z wagonu, by na postoju napić się piwa. Chwilę potem nie ma ani stacji, ani pociągu, ani torów, ani dworcowej knajpy, z której właśnie wyszedłeś.\n\nTylko mróz, śnieg, zamieć. I konieczność toczenia ciągłych walk. Z ludźmi i innymi bestiami.\n\nŚwiatem Przygranicza rządzi zasada „wszyscy przeciwko wszystkim”.\n\nSrebro i artefakty warte są tu nieporównanie więcej niż ludzkie życie. Miłosierdzie czy przyjaźń to tylko puste słowa. Co drugi jest bandytą. Sroga zima zaczyna się już w sierpniu. Zamarza serce. Czasem palec, i to – niestety – zanim pociągniesz za spust."
}

cieplo_book = Ecto.build_assoc(kornew, :books, cieplo)
cytadela_book = Ecto.build_assoc(kornew, :books, cytadela)
sopel_book = Ecto.build_assoc(kornew, :books, sopel)

Repo.insert!(sopel_book)
Repo.insert!(cytadela_book)
Repo.insert!(cieplo_book)

# ============================================

raduchowska = Repo.insert!(%Author{
  name: "Martyna",
  surname: "Raduchowska",
  avatar_url: "http://s.lubimyczytac.pl/upload/authors/30464/34994-352x500.jpg",
  description: "Rocznik 87. Wrocławianka całym sercem i duszą. Z charakteru wredna i pyskata wiedźma, pełna optymizmu pesymistka, ambitny leniuch, pogodna maruda, zagorzała domatorka na obczyźnie, słowem, posiadaczka niepowtarzalnego zestawu cech, który gwarantuje, że cokolwiek by się nie działo, zawsze znajdzie się powód do narzekania – jej ulubionego zajęcia. Cierpi na chorobliwy nadmiar pomysłów oraz chroniczny brak wolnego czasu.\n\nUkończyła studia na Uniwersytecie Walijskim i przez najbliższy rok będzie zgłębiać tajniki psychologii rozwojowej na uniwersytecie w York. Z wykształcenia psycholog i kryminolog, z zamiłowania pisarka.\n\nZadebiutowała Całą prawdą o PPM (antologia Kochali się, że strach, Fabryka Słów, 2007), a o jej przyprawionych szczyptą magii i odrobiną niesamowitości walijskich doświadczeniach można czytać w opowiadaniu Shade (antologia Nawiedziny, Fabryka Słów, 2009). Pisać zaczęła gdzieś w okolicach dwunastego roku życia, przestać natomiast – ku udręce niektórych - nie zamierza nigdy."
})

szamanka = %Book{
  title: "Szamanka od umarlaków",
  cover_url: "https://images.bookmanager.pro/book/cover/szamanka-od-umarlakow.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/szamanka-od-umarlakow.jpg",
  isbn: "9788328045231",
  description: "Przygotujcie się na solidną dawkę znakomitego humoru, oto nowe wydanie kultowej powieści fantasy Martyny Raduchowskiej!\n\nKto by pomyślał, że potomkini wielkiego rodu czarodziejów, wróżbitów i telepatów zbuntuje się wobec rodzinnej tradycji… Ida Brzezińska ma osiemnaście lat i uważa magię za stek bzdur. Jak sama twierdzi, taka z niej czarownica, jak z koziego zadka waltornia. Jedyne, o czym Ida marzy, to spokojne życie młodej dziewczyny: wymarzone studia psychologiczne na Uniwersytecie Wrocławskim, mieszkanie w akademiku, poznawanie świata… Niestety przeszkadzają jej w tym pojawiające się ni stąd ni zowąd trupy. Widzenie zmarłych i przewidywanie śmierci ludzi żyjących to magiczny dar, długo poszukiwany przez rodziców Idy. Nie jest łatwo być medium… a dodatkowo Ida ma prawdziwego Pecha!"
}

szamanka_book = Ecto.build_assoc(raduchowska, :books, szamanka)
Repo.insert!(szamanka_book)

# ============================================

debski = Repo.insert!(%Author{
  name: "Eugeniusz",
  surname: "Dębski",
  avatar_url: "http://s.lubimyczytac.pl/upload/authors/3266/91232-352x500.jpg",
  description: "Polski pisarz fantastyczny, członek Stowarzyszenia Pisarzy Polskich (incydentalnie publikujący również pod pseudonimami Owen Yeates, Pierce O'Otooley i innymi), od 1997 członek Stowarzyszenia Pisarzy Polskich, od 2005 roku prezes SPP oddział Wrocław. W 1976 ukończył rusycystykę na Uniwersytecie Wrocławskim obecnie mieszka na stałe we Wrocławiu. Jako autor science fiction debiutował w 1984 roku opowiadaniem Najważniejszy dzień 111394 roku. Pod tym samym tytułem w 1985 ukazał się jego pierwszy zbiór opowiadań. Autor kilkunastu powieści oraz kilkudziesięciu opowiadań science fiction i fantasy, z których kilka przetłumaczonych zostało na niemiecki, węgierski, czeski i rosyjski. Sześć powieści z cyklu o przygodach Owena Yeatesa wydano już w Rosji, pozostałe w tłumaczeniu, w Rosji też opublikowany niedługo będzie przekład jednej z pierwszych polskich powieści fantasy Śmierć Magów z Yara, wcześniej wydanej już w Czechach."
})

moherfucker = %Book{
  title: "Russian Impossible - Moherfucker",
  cover_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/cover/dd3be342-d6b0-0f0a-619b-3789e111e17b.jpg",
  thumbnail_url: "https://s3.eu-central-1.amazonaws.com/booker-cover/book/resized/dd3be342-d6b0-0f0a-619b-3789e111e17b.jpg",
  isbn: "9788389595690",
  description: "Polskie służby specjalne, rosyjska policja — i bogobojne staruszki, które znienacka zmieniają się w krwiożercze monstra.\n\nPetersburg doświadcza fali potwornych zbrodni. Zaczyna się, oczywiście, całkiem niewinnie. Babuszka, zagadnięta przez kilku podpitych obiboków, nie zamierza się potulnie dorzucić do fajek. Ba, nie chce oddać siatki z portmonetką.\n\nTylko czy to aby na pewno staruszka? Czy poczciwe babcie urywają głowy podpitym młodzieńcom? I czy w odwecie za kapitalizm i głodowe emerytury szatkują współobywateli na drobne kawałki?\n\nZagadkę morderczego ożywienia wśród leciwej populacji Petersburga ma wyjaśnić kapitan Sukonin. Jego uwagę zwraca raport Kamila Stocharda z Agencji Bezpieczeństwa Wewnętrznego, opisujący dziwaczne zabójstwa wśród polskich emerytów. Postanawia ściągnąć kolegę z bratniego kraju na konsultacje. A żeby przyjaźń polsko-rosyjska nabrała rumieńców i żeby Polak nie odkrył żadnych niewygodnych dla gospodarzy tajemnic, jako anioła stróża przydziela mu piękną agentkę Zemfirę."
}

fartu_brak = %Book{
  title: "Raptowny fartu brak",
  cover_url: "https://storage.googleapis.com/images.bookmanager.pro/book/cover/raptowny-fartu-brak.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/raptowny-fartu-brak.jpg",
  isbn: "9788375740233",
  description: "Fartu brak? Czarta znak!\n\nBywa, że przeznaczenie, na autostradzie losu rozbija się o roboty drogowe. Albo Stwórca rzuca monetą, a ta, zawisa w powietrzu i wszystko zaczyna się pieprzyć...Tobie. Nie Stwórcy. I o tym są te opowiadania. Przypominają Kodeks Drogowy obowiązujacy w stanach obniżonego współczynnika szczęścia:\n\n§ 1. Zabrania się wyprzedzania, zawracania lub rozglądania w potoku pieszych. Zbieranie pamiątek po stratowanych grozi śmiercią lub kalectwem i utratą ubezpieczenia!\n\n§ 2. Przed rozpoczęciem ekspedycji skontroluj stan techniczny pokładowego mucha. Ze względu na możliwość wystąpienia pecha nie zaleca się przyjmowania na pokład samic żadnego gatunku.\n\n§ 3. Jeżeli Silnik twierdzi, że jesteś jego paliwem, zachowaj ostrożność. Odsuń się i łagodnie przemawiaj.\n\n§ 4. Stawianie ŻONY do pionu lub wystawianie na deszcz bez uprzedniej kontroli szczelności, grozi trwałym kalectwem i utratą gwarancji.\n\n§ 5. Po przeczytaniu - instrukcji nie zjadać."
}

wlos_piwa = %Book{
  title: "O włos od piwa",
  cover_url: "https://storage.googleapis.com/images.bookmanager.pro/book/cover/o-wlos-od-piwa.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/o-wlos-od-piwa.jpg",
  isbn: "8389011743",
  description: "Eugeniusz Dębski, mistrz polskiej fantastyki, powraca ze wzbogaconym zbiorem najlepszych opowieści o przygodach dwóch wiernych towarzyszy, Cadrona i Hondelyka.\n\nW każdej historii jako nieodłączny element pojawia się także znany i lubiany złocisty trunek, przy którym przyjaciele rozprawiają o kolejnych niesamowitych wyprawach i który bywa również przyczyną ich problemów. Hondelyk i Cadron jak magnes przyciągają do siebie przygody lub, jak kto woli, to przygody przyciągają ich. Przewrotny los wciąż wysyła ich w kolejne podróże do niezwykłych, nierealnych światów, w których przeciwnikiem może być prymitywny, dziki wojownik, skrzydlaty stwór, a czasem piękna i równie niebezpieczna kobieta. Lecz Cadrona i Hondelyka nie jest łatwo pokonać, bo czyż można pokonać kogoś, kto zmienia skórę jak kameleon, a raczej... Xameleon?"
}


moherfucker_book = Ecto.build_assoc(debski, :books, moherfucker)
fartu_brak_book = Ecto.build_assoc(debski, :books, fartu_brak)
wlos_piwa_book = Ecto.build_assoc(debski, :books, wlos_piwa)

Repo.insert!(wlos_piwa_book)
Repo.insert!(moherfucker_book)
Repo.insert!(fartu_brak_book)

# ============================================

hannu = Repo.insert!(%Author{
  name: "Hannu",
  surname: "Rajaniemi",
  avatar_url: "https://images.bookmanager.pro/author/Hannu_Rajaniemi.jpg",
  description: " fiński autor fantastyki, piszący po angielsku i fińsku. Mieszka w Oakland w Kalifornii. Założył komercyjną organizacje ThinkTank Maths. W Polsce w 2018 roku została wydana jego trylogia Jean le Flambeur, w tym jego nagradzana powieść Kwantowy złodziej.\n\nUrodził się w Ylivieska w Finlandii w 1978 roku. Uzyskał licencjat z matematyki na Uniwersytecie w Oulu, tytuł magistra nauk matematycznych na University of Cambridge oraz doktorat z fizyki matematycznej na Uniwersytecie Edynburskim. Przed rozpoczęciem studiów doktoranckich ukończył krajową służbę jako naukowiec dla Finnish Defence Forces.\n\nW trakcie swoich studiów doktoranckich dołączył do Writers' Bloc, grupy pisarzy w Edynburgu, do której należy także Charlie Stross."
})

zlodziej = %Book{
  title: "Kwantowy złodziej",
  cover_url: "https://images.bookmanager.pro/book/cover/kwantowy-zlodziej.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/kwantowy-zlodziej.jpg",
  isbn: "9788374808781",
  description: "Jean le Flambeur siedzi w więzieniu. I powinien w nim zostać. Oszust, łgarz, niezrównany złodziej, o którego wyczynach krążą legendy. Jego pochodzenie owiewa mgła tajemnicy, za to o jego niesławnych dokonaniach – takich jak wykradnięcie ziemskich antyków z Marsa czy włamanie do rozległego zeusmózgu i kradzież jego myśli – słyszeli wszyscy. Popełnił tylko jeden, jedyny błąd; nie udał mu się jeden skok. I teraz, jeśli chce odzyskać wolność, będzie musiał spróbować ponownie… Powieść Rajaniemiego to oszałamiająca hard SF – opowieść złodziejska, której motorem napędowym są jak najbardziej ludzkie motywy: zdrada, zemsta, zazdrość. Mocne oparcie w nauce, oryginalne pomysły i świetnie nakreślone postaci – oto debiut wyjątkowy pod każdym względem."
}

zlodziej_book = Ecto.build_assoc(hannu, :books, zlodziej)
Repo.insert!(zlodziej_book)

# ============================================

noczkin = Repo.insert!(%Author{
  name: "Wiktor",
  surname: "Noczkin",
  avatar_url: "https://images.bookmanager.pro/author/noczkin.jpg",
  description: "Z niejednego pieca chleb jadł\n\nUrodził się w 1966 roku w Charkowie (wówczas ZSRR). Spędził tam dzieciństwo i młodość marząc o locie na nieznaną planetę lub choćby nadaniu nazwy rzece. Przez lata kolekcjonował figurki żołnierzyków, a nawet sam je produkował i sprzedawał. Życie zawodowe rozpoczynał jako inżynier i projektant dźwigów towarowych rozsyłanych na cały świat.\n\nPrzygodę z pisaniem rozpoczął dopiero jako trzydziestolatek w latach dziewięćdziesiątych, po zmianie ustroju i upadku ZSRR. Wymyślił jedną historię, zaczął zapisywać następne i wyszła z tego powieść, potem powstawały kolejne.\n\nW 2001 roku pisarz został zmuszony do wyjazdu za granicę. Dopiero w Niemczech opublikował swoje teksty w magazynach rosyjskojęzycznych i podpisał pierwszy kontrakt z rosyjskim wydawcą książek. W trakcie ostatniej dekady Wiktor Noczkin wydał ponad trzydzieści powieści i stał się jednym z najpopularniejszych autorów rosyjskojęzycznych.\n\nLiteratura powiązana z grą komputerową to znak naszych czasów – uważa Noczkin. W serię S.T.A.L.K.E.R. wciągnął go Andriej Lewicki, który był jednym z pionierów serii książek osadzonych w uniwersum gry. Za jego namową, Noczkin zagrał w „Cień Czarnobyla” i atmosfera gry go porwała…"
})

plama = %Book{
  title: "Slepa plama",
  cover_url: "https://images.bookmanager.pro/book/cover/slepa-plama.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/slepa-plama.jpg",
  isbn: "9788375749885",
  description: "Pierwsza rosyjskojęzyczna powieść z uniwersum S.T.A.L.K.E.R. przetłumaczona na język polski.\n\nTajemniczy sektor Zony\n\nŚlepy jest chyba jednym z najbardziej pechowych stalkerów. A jednak to właśnie jemu zaproponowano, by został przewodnikiem wybitnego uczonego Dietricha van de Meera.\n\nDietrich nie płaci nazbyt hojnie i porywa się na niemalże samobójcze ryzyko – ale Ślepy, szczerze mówiąc, nie za bardzo ma w czym przebierać.\n\nWkrótce tej dość dziwnej drużynie przychodzi się zetknąć z cokolwiek nietypowym problemem – zbadaniem sprawy tajemniczych zniknięć stalkerów, wciąż ginących w jednym i tym samym sektorze Zony. Co takiego im się przydarzyło? Jaki spotkał ich los? Tego nie wie nikt.\n\nJedynym tropem Ślepego i Dietricha są pijackie opowieści byłego stalkera, przysięgającego na wszystkie świętości, że to właśnie tam znajdują się szczególnie bogate pola artefaktów…"
}

szerep = %Book{
  title: "Czerep mutanta",
  cover_url: "https://images.bookmanager.pro/book/cover/szerep-mutanta.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/szerep-mutanta.jpg",
  isbn: "9788375749434",
  description: "Nowe przygody stalkera Ślepego\n\nZona skrywa niejedną tajemnicę – czasami nie wystarczy do jej odkrycia intuicja czy logika, a wtedy przydaje się ślepy traf. Czego jak czego, ale tego stalkerowi Ślepemu jego Fortuna nie szczędzi.\n\nPróbujący odpocząć u rodziny na Dużej Ziemi stalker trafia wbrew swej woli w sam środek szeroko zakrojonej operacji, realizowanej rękami najemników, ale stworzonej przez samych Gospodarzy Zony. Ukrywający się przed pogonią Ślepy zmienia tożsamość i chowa się w Głębokiej Zonie. Tam będzie musiał rozwikłać tajemnicę przestępstwa w obozie stalkerów, lawirować pomiędzy ścierającymi się frakcjami, znaleźć zabójcę, odnaleźć nietypowy artefakt, spotkać się z Chemikiem i Garsteczką.\n\nDziwne rzeczy dzieją się w Zonie, ścierają się ukryte siły, a Ślepy i jego towarzysze nagle okazują się być na pierwszej linii tej cichej wojny."
}

lancuch = %Book{
  title: "Łańcuch pokarmowy",
  cover_url: "https://storage.googleapis.com/images.bookmanager.pro/book/cover/lancuch-pokarmowy.jpg",
  thumbnail_url: "https://storage.googleapis.com/images.bookmanager.pro/book/resized/lancuch-pokarmowy.jpg",
  isbn: "9788379641246",
  description: "Ślepy obiecywał sobie, że już nigdy więcej. Że to koniec, że on ze stalkerstwem skończył.\n\nAle zawsze jest ten ostatni raz.\n\nDuża polityka z Dużej Ziemi wlewa się do Zony i stawia wszystko na głowie. Bandyci z wysypiska, zabójca z wielkiego miasta, Stwór z zapomnianego laboratorium… a w oku cyklonu nasz bohater, jak zwykle trochę zagubiony, ale z uśmiechem na ustach i głową pełną dykteryjek.\n\nPo raz kolejny wkrocz ze Ślepym do Zony i zobacz, jak wygląda Jej łańcuch pokarmowy."
}

lowca_z_lasu = %Book{
  title: "Łowca z lasu",
  cover_url: "https://images.bookmanager.pro/book/cover/lowca-z-lasu.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/lowca-z-lasu.jpg",
  isbn: "9788379640249",
  description: "Wejdź do Survarium i zmierz się z krwiożerczą Matką Naturą\n\nXXI wiek. Ziemia powstała przeciwko człowiekowi, aby go zniszczyć.\n\nNa planecie pojawia się przerażająca bio-anomalia - Las pełen zmutowanych roślin i zwierząt. Nieliczni dają radę przeżyć w nowym świecie pełnym agresywnych mutantów i odmienionej przyrody. Ludzie formują bandy, klany i zgrupowania, walczące o resztki pozostałe po upadku cywilizacji. Łowca, Stas Łogin, balansując pomiędzy życiem a śmiercią w pojedynkę stawia czoła bandzie półdzikich koczowników, próbując rozwikłać zagadkę złowieszczego Poligonu Śmierci.\n\nNawet jeśli wszyscy są przeciwko tobie - nie znaczy to, że nie masz racji."
}

wektor = %Book{
  title: "Wektor zagrozenia",
  cover_url: "https://images.bookmanager.pro/book/cover/wektor-zagrozenia.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/wektor-zagrozenia.jpg",
  isbn: "9788379640539",
  description: "Survarium - duchowy spadkobierca S.T.A.L.K.E.R.a\n\nŚwiat przyszłości, w którym ziemia powstała przeciwko człowiekowi, aby go zniszczyć.\n\nNa planecie pojawia się przerażająca bio-anomalia – Las pełen zmutowanych roślin i zwierząt. Nieliczni dają radę przeżyć w nowym świecie pełnym agresywnych mutantów i odmienionej przyrody. Ludzie formują bandy, klany i zgrupowania, walczące o resztki pozostałe po upadku cywilizacji.\n\nWłóczęga Aleks wbrew swej woli wplątuje się w poszukiwanie sekretów porzuconych laboratoriów naukowych. Naprzeciw siebie stają oddziały Czarnego Rynku oraz Armii Odrodzenia, chcące posiąść na własność odpowiedź na zagadkę z przeszłości..\n\nKrwiożercza siła Matki Natury kontra natura człowieka"
}

plama_book = Ecto.build_assoc(noczkin, :books, plama)
czerep_book = Ecto.build_assoc(noczkin, :books, szerep)
lancuch_book = Ecto.build_assoc(noczkin, :books, lancuch)
lowca_z_lasu_book = Ecto.build_assoc(noczkin, :books, lowca_z_lasu)
wektor_book = Ecto.build_assoc(noczkin, :books, wektor)

Repo.insert!(plama_book)
Repo.insert!(czerep_book)
Repo.insert!(lancuch_book)
Repo.insert!(lowca_z_lasu_book)
Repo.insert!(wektor_book)

# ============================================

greaney = Repo.insert!(%Author{
  name: "Mark",
  surname: "Greaney",
  avatar_url: "https://images.bookmanager.pro/author/greaney.jpg",
  description: "Mark Greaney’s debut international thriller, THE GRAY MAN, was released by Jove Books in 2009. It became a national bestseller, and was nominated for a Barry Award in the Best Thriller category. A feature film adaptation of THE GRAY MAN is in development by New Regency Pictures. The screenplay for The Gray Man, written by Adam Cozad, was placed on the Black List of 2010 of the best unproduced screenplays in Hollywood. James Gray, director of We own the Night, and Two Lovers, will direct, and Brad Pitt has agreed to star as burned ex CIA paramilitary officer Court Gentry.\n\nMark’s next thriller, ON TARGET, was released in September 2010 by Jove, and was nominated for a Barry Award in the Best Thriller category."
})

zwierzchnik = %Book{
  title: "Zwierzchnik",
  cover_url: "https://images.bookmanager.pro/book/cover/zwierzchnik.jpg",
  thumbnail_url: "https://images.bookmanager.pro/book/resized/zwierzchnik.jpg",
  isbn: "9788328009981",
  description: "Dziewiąta książka z cyklu o Jacku Ryanie, byłym agencie CIA, prezydencie USA, opublikowana już po śmierci autora.\n\nTajemnicza historia z czasów zimnej wojny i współczesne wydarzenia: Rosja atakuje Ukrainę, świat staje na krawędzi wielkiego konfliktu. Okoliczności szybkiego i niespodziewanego dojścia do władzy nowego prezydenta Rosji owiane są tajemnicą. Terror i zastraszanie to metody powstrzymywania wrogów przed poznaniem prawdy. Okazuje się, że jest jedna osoba, która może znać mroczny sekret rosyjskiego magnata – obecny prezydent Stanów Zjednoczonych, były agent CIA Jack Ryan.\n\nNumer 1 na liście bestsellerów „New York Timesa”!"
}


zwierzchnik_book = Ecto.build_assoc(greaney, :books, zwierzchnik)

Repo.insert!(zwierzchnik_book)

# ============================================

  doobs = Repo.insert!(%Author{
    name: "Michael",
    surname: "Dobbs",
    avatar_url: "http://images.bookmanager.pro/author/dobbs.jpg",
    description: "Członek brytyjskiej Partii Konserwatywnej i pisarz."
  })

  house = %Book{
    title: "House of cards",
    cover_url: "https://images.bookmanager.pro/book/cover/house-of-cards.jpg",
    thumbnail_url: "https://images.bookmanager.pro/book/resized/house-of-cards.jpg",
    isbn: "9788324026555",
    description: "House of Cards – kto rozdaje karty na najwyższych szczeblach władzy?\n\nOpowieść-fenomen, która zachwyciła miliony widzów i czytelników na całym świecie.\n\nCzłowieka motywuje nie szacunek, lecz strach. To na nim buduje się imperia i za jego sprawą wszczyna rewolucje. W tym tkwi sekret wielkich ludzi. Kiedy ktoś się ciebie boi, zniszczysz go, zmiażdżysz, a w efekcie on zawsze obdarzy cię szacunkiem. Prymitywny strach jest upajający, wszechogarniający, wyzwalający. Zawsze silniejszy od szacunku. Zawsze.\n\nMichael Dobbs wie o czym pisze. Sam wiele lat był politykiem, który z bliska obserwował, jak działają mechanizmy władzy. Swoje doświadczenia przekuł w fascynującą opowieść o korupcji, manipulacji i ambicji, która każe człowiekowi iść po trupach do celu.\n\nJak daleko można się posunąć, by osiągnąć upragniony cel?\n\nOd tej książki rozpoczęła się historia jednego z najlepszych seriali XXI wieku."
  }

  house_book = Ecto.build_assoc(doobs, :books, house)

  Repo.insert!(house_book)
