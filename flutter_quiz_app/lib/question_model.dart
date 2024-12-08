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

List<Question> getQuestion() {
  List<Question> list = [];

  list.add(
    Question("Who is...?",
    [
      Answer("I", false),
      Answer("You", false),
      Answer("He", false),
      Answer("Anyád", true),
    ],
  ));

  list.add(
    Question("Who is...?",
    [
      Answer("I", false),
      Answer("You", false),
      Answer("He", false),
      Answer("Anyád", true),
    ],
  ));

  list.add(
    Question("Who is...?",
    [
      Answer("I", false),
      Answer("You", false),
      Answer("He", false),
      Answer("Anyád", true),
    ],
  ));

  return list;
}