import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/question_model.dart';


class MenuScreen extends StatelessWidget {
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
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                backgroundColor: const Color(0xFFFFDE21),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              child: const Text(
                "Start",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<Question> questionList = getQuestions();
  int currentQuestionIndex = 0;
  int score = 0;
  Answer? selectedAnswer;

  final List<int> rewardLevels = [
    10000, 20000, 50000, 100000, 250000, 
    500000, 750000, 1000000, 1500000, 2000000, 
    5000000, 10000000, 15000000, 25000000, 50000000
  ];

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
            SizedBox(
              width: 600,
              child: _questionWidget(),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 600,
              child: _answerList(),
            ),
            const SizedBox(height: 30),
            SizedBox(
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Kérdés ${currentQuestionIndex + 1}/${questionList.length}, ${rewardLevels[currentQuestionIndex]} Ft-ért!",
              style: const TextStyle(
                color: Color(0xFFFFDE21),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Eddig: $score Ft",
              style: const TextStyle(
                color: Color(0xFFFFDE21),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          padding: const EdgeInsets.all(32),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
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
          backgroundColor: isSelected ? const Color(0xFFFFDE21) : Colors.white,
          elevation: isSelected ? 10 : 5,
        ),
        onPressed: () {
          setState(() {
            selectedAnswer = answer;
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
      backgroundColor: const Color(0xFFFFDE21),
      foregroundColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      elevation: 5,
    ),
    onPressed: () {
      if (selectedAnswer == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Kérlek jelölj meg egy választ!")),
        );
        return;
      }

      if (selectedAnswer!.isCorrect) {
        score += rewardLevels[currentQuestionIndex];

        if ((currentQuestionIndex + 1) % 5 == 0 || currentQuestionIndex == questionList.length - 1) {
          _showExitDialog();
        } else {
          _nextQuestion();
        }
      } else {
        _showScoreDialog();
      }
    },
    child: Text(
      currentQuestionIndex < questionList.length - 1 ? "Következő" : "Vége",
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}

  void _nextQuestion() {
    if (currentQuestionIndex < questionList.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedAnswer = null;
      });
    } else {
      _showScoreDialog();
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Kiszállás?"),
        content: Text("Szeretnél kiszállni $score Ft-ért?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showScoreDialog();
            },
            child: const Text("Igen"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _nextQuestion();
            },
            child: const Text("Nem"),
          ),
        ],
      ),
    );
  }

void _showScoreDialog() {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: const Text("Játék vége!"),
      content: Text("Nyereményed: $score Ft"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => MenuScreen()),
              (route) => false,
            );
          },
          child: const Text("Vissza a menübe!"),
        ),
      ],
    ),
  );
}
}