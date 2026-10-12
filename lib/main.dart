
import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Quiz App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const QuizHomePage(),
    );
  }
}

class QuizHomePage extends StatefulWidget {
  const QuizHomePage({super.key});

  @override
  State<QuizHomePage> createState() => _QuizHomePageState();
}

class _QuizHomePageState extends State<QuizHomePage> {
  int questionIndex = 0;
  int score = 0;
  int? selectedAnswer;
  bool quizFinished = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Flutter kis language ko use karta hai?',
      'answers': ['Python', 'Dart', 'Java', 'C++'],
      'correct': 1,
    },
    {
      'question': 'HTML ka full form kya hai?',
      'answers': [
        'Hyper Text Markup Language',
        'High Text Machine Language',
        'Home Tool Markup Language',
        'Hyperlinks Text Management Language',
      ],
      'correct': 0,
    },
    {
      'question': 'CPU ka full form kya hai?',
      'answers': [
        'Central Processing Unit',
        'Computer Personal Unit',
        'Central Program Utility',
        'Control Processing User',
      ],
      'correct': 0,
    },
  ];

  void checkAnswer() {
    if (selectedAnswer == null) return;

    if (selectedAnswer == questions[questionIndex]['correct']) {
      score++;
    }

    setState(() {
      if (questionIndex < questions.length - 1) {
        questionIndex++;
        selectedAnswer = null;
      } else {
        quizFinished = true;
      }
    });
  }

  void restartQuiz() {
    setState(() {
      questionIndex = 0;
      score = 0;
      selectedAnswer = null;
      quizFinished = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Quiz App'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: quizFinished
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      size: 80,
                      color: Colors.orange,
                    ),
                    const Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Text(
                      'Your Score: $score / ${questions.length}',
                      style: const TextStyle(fontSize: 23),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: restartQuiz,
                      child: const Text('Play Again'),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Question ${questionIndex + 1} '
                      'of ${questions.length}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 25),
                    Text(
                      questions[questionIndex]['question'],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...List.generate(
                      (questions[questionIndex]['answers'] as List).length,
                      (index) => RadioListTile<int>(
                        title: Text(
                          questions[questionIndex]['answers'][index],
                        ),
                        value: index,
                        groupValue: selectedAnswer,
                        onChanged: (value) {
                          setState(() {
                            selectedAnswer = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed:
                          selectedAnswer == null ? null : checkAnswer,
                      child: Text(
                        questionIndex == questions.length - 1
                            ? 'Finish Quiz'
                            : 'Next Question',
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
