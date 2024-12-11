import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/question_model.dart';
import 'dart:math';


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
    10000, 10000, 30000, 50000, 150000, 
    250000, 250000, 250000, 500000, 500000, 
    3000000, 5000000, 5000000, 10000000, 25000000
  ];

  // Közönség segítség ----------------------------------------------------------

  bool isKozonsegUsed = false;

  void _useKozonsegHelp() {
    setState(() {
      isKozonsegUsed = true;
    });

    List<int> kozonsegSzavazas = _kozonsegGeneral();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Közönség szavazás"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            4,
            (index) => Text(
              "${questionList[currentQuestionIndex].answerList[index].answerText}: ${kozonsegSzavazas[index]}%",
            ),
          ),
        ),
      ),
    );
  }

  List<int> _kozonsegGeneral() {
    int correctIndex = questionList[currentQuestionIndex]
        .answerList
        .indexWhere((answer) => answer.isCorrect);

    List<int> votes = List.generate(4, (_) => Random().nextInt(30));
    votes[correctIndex] = 70 + Random().nextInt(30);

    int total = votes.reduce((a, b) => a + b);
    votes = votes.map((vote) => (vote / total * 100).round()).toList();

    return votes;
  }

  // Felezős segítség -----------------------------------------------------------
  bool isFelezosUsed = false;

  void _useFelezosHelp() {
    if (isFelezosUsed) return;
    
    setState(() {
      isFelezosUsed = true;
    });

    int correctIndex = questionList[currentQuestionIndex]
        .answerList
        .indexWhere((answer) => answer.isCorrect);

    List<int> incorrectIndices = List.generate(4, (index) => index)
      ..remove(correctIndex);

    incorrectIndices.shuffle();
    incorrectIndices = incorrectIndices.take(2).toList();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Felezős segítség"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            4,
            (index) {
              if (incorrectIndices.contains(index)) {
                return const SizedBox.shrink();
              }
              return Text(questionList[currentQuestionIndex]
                  .answerList[index]
                  .answerText);
            },
          ),
        ),
      ),
    );
  }
  //------------------------------------------------------------------------------

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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Közönség ikon
                IconButton(
                  icon: Icon(Icons.people),
                  color: isKozonsegUsed ? Colors.grey : const Color(0xFFFFDE21),
                  iconSize: 40,
                  onPressed: isKozonsegUsed ? null : _useKozonsegHelp,
                ),
                const SizedBox(width: 20),
                // Felezős ikon
                IconButton(
                  icon: Icon(Icons.percent),
                  color: isFelezosUsed ? Colors.grey : const Color(0xFFFFDE21),
                  iconSize: 40,
                  onPressed: isFelezosUsed ? null : _useFelezosHelp,
                ),
              ],
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
                "Kérdés ${currentQuestionIndex + 1}/${questionList.length}, ${rewardLevels[currentQuestionIndex] + score} Ft-ért!",
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