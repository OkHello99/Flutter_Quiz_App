import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/question_model.dart';

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF11092F),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.contain,
              height: 250,
            ),
            const SizedBox(height: 20),
            Container(
              width: 600,
              child: _questionWidget(),
            ),
            const SizedBox(height: 20),
            Container(
              width: 600,
              child: _answerList(),
            ),
            const SizedBox(height: 30),
            Container(
              width: 600,
              child: _nextButton(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _questionWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Kérdés ${currentQuestionIndex + 1}/${questionList.length}",
          style: const TextStyle(
            color: Color(0xFFFFDE21),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF11092F), Color(0xFF2F0940)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Text(
            questionList[currentQuestionIndex].questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _answerList() {
    return Column(
      children: questionList[currentQuestionIndex]
          .answerList
          .map((answer) => _answerButton(answer))
          .toList(),
    );
  }

  Widget _answerButton(Answer answer) {
    bool isSelected = answer == selectedAnswer;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: isSelected ? Colors.white : Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: isSelected ? Color(0xFFFFDE21) : Colors.white,
          elevation: isSelected ? 10 : 5,
        ),
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
            if (answer.isCorrect) {
              score++;
            }
          });
        },
        child: Text(
          answer.answerText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isSelected ? Colors.black : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        backgroundColor: Color(0xFFFFDE21),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 5,
      ),
      onPressed: () {
        if (currentQuestionIndex < questionList.length - 1) {
          setState(() {
            currentQuestionIndex++;
            selectedAnswer = null;
          });
        } else {
          _showScoreDialog();
        }
      },
      child: Text(
        currentQuestionIndex < questionList.length - 1 ? "Következő" : "Befejezés",
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  void _showScoreDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Kvíz Kész!"),
        content: Text("Pontszámod: $score/${questionList.length}"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestionIndex = 0;
                score = 0;
                selectedAnswer = null;
              });
            },
            child: const Text("Újraindítás"),
          ),
        ],
      ),
    );
  }
}
