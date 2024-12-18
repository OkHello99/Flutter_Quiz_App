class Question {
  final String questionText;
  final List<Answer> answerList;

  Question(this.questionText, this.answerList);
}

class Answer {
  final String answerText;
  final bool isCorrect;

  Answer(this.answerText, this.isCorrect);
}
List<Question> getQuestions() {
  List<Question> list = [];

  list.add(
    Question("Mi Magyarország fővárosa?",
    [
      Answer("Debrecen", false),
      Answer("Pécs", false),
      Answer("Szeged", false),
      Answer("Budapest", true),
    ],
  ));

  list.add(
    Question("Mi Magyarország hivatalos nyelve?",
    [
      Answer("Angol", false),
      Answer("Német", false),
      Answer("Magyar", true),
      Answer("Francia", false),
    ],
  ));

  list.add(
    Question("Mi Magyarország legnagyobb tava?",
    [
      Answer("Balaton", true),
      Answer("Tisza-tó", false),
      Answer("Velencei-tó", false),
      Answer("Fertő-tó", false),
    ],
  ));

  list.add(
    Question("Ki volt Magyarország első királya?",
    [
      Answer("Mátyás király", false),
      Answer("Szent István", true),
      Answer("László király", false),
      Answer("Károly Róbert", false),
    ],
  ));

  list.add(
    Question("Melyik évben kezdődött a második világháború?",
    [
      Answer("1935", false),
      Answer("1939", true),
      Answer("1941", false),
      Answer("1945", false),
    ],
  ));

  list.add(
    Question("Melyik híres magyar város a Hortobágyi Nemzeti Park központja?",
    [
      Answer("Szeged", false),
      Answer("Debrecen", true),
      Answer("Budapest", false),
      Answer("Pécs", false),
    ],
  ));

  list.add(
    Question("Mi a legismertebb magyar étel?",
    [
      Answer("Pörkölt", true),
      Answer("Pizza", false),
      Answer("Hamburger", false),
      Answer("Sushi", false),
    ],
  ));

  list.add(
    Question("Ki találta fel a golyóstollat?",
    [
      Answer("Bíró László", true),
      Answer("Eötvös Loránd", false),
      Answer("Puskás Ferenc", false),
      Answer("Kodály Zoltán", false),
    ],
  ));

  list.add(
    Question("Melyik magyar festőművész alkotta a 'Téli táj' című művet?",
    [
      Answer("Szinyei Merse Pál", true),
      Answer("Kandó Kálmán", false),
      Answer("Munkácsy Mihály", false),
      Answer("Rippl-Rónai József", false),
    ],
  ));

  list.add(
    Question("Mi Magyarország legmagasabb hegye?",
    [
      Answer("Kékes", true),
      Answer("Matrica", false),
      Answer("Javolá", false),
      Answer("Fekete-hegy", false),
    ],
  ));

  list.add(
    Question("Melyik évben alapították Magyarországot?",
    [
      Answer("896", true),
      Answer("1000", false),
      Answer("1241", false),
      Answer("1526", false),
    ],
  ));

  list.add(
    Question("Hány megye van Magyarországon?",
    [
      Answer("17", false),
      Answer("19", true),
      Answer("21", false),
      Answer("25", false),
    ],
  ));

  list.add(
    Question("Melyik magyar városban található az ország egyetlen UNESCO Világörökségi borvidéke?",
    [
      Answer("Tokaj", true),
      Answer("Eger", false),
      Answer("Villány", false),
      Answer("Badacsony", false),
    ],
  ));

  list.add(
    Question("Melyik magyar tudós nyerte meg a Nobel-díjat a C-vitamin felfedezéséért?",
    [
      Answer("Szent-Györgyi Albert", true),
      Answer("Bay Zoltán", false),
      Answer("Wigner Jenő", false),
      Answer("Puskás Tivadar", false),
    ],
  ));

  list.add(
    Question("Melyik magyar feltaláló alkotta meg a híres 'Gömböcöt'?",
    [
      Answer("Domokos Gábor", true),
      Answer("Irinyi János", false),
      Answer("Rubik Ernő", false),
      Answer("Jedlik Ányos", false),
    ],
  ));

  return list;
}
