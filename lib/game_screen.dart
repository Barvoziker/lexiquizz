import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'score_manager.dart';
import 'dart:core';
import 'end_game_screen.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int gameDuration = 60;
  Timer? gameTimer;
  int timeLeft = 0;
  int score = 0;
  String currentWord = '';
  String scrambledWord = '';
  List<String> wordList = [];
  String randomWord = '';
  final TextEditingController wordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadWordList();
    startTimer();
  }

  void startTimer() {
    setState(() {
      timeLeft = gameDuration;
    });
    gameTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        endGame();
      }
    });
  }

  void endGame() async {
    await ScoreManager.saveScore(score);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => EndGameScreen(currentScore: score)),
    );
  }

  Future<void> loadWordList() async {
    String content = await rootBundle.loadString('assets/data/fr.json');
    final jsonResult = json.decode(content);

    wordList = (jsonResult['words'] as List)
        .where((word) => word['targetWord'].length >= 5)
        .map((word) => word['targetWord'] as String)
        .toList();

    pickRandomWord();
  }

  void pickRandomWord() {
    final random = Random();
    randomWord = wordList[random.nextInt(wordList.length)];
    print('MOT CHOISI: $randomWord');
    scrambledWord = scrambleWord(randomWord).toUpperCase();
    scrambledWord = scrambledWord.split('').join(' ');
    setState(() {});
  }

  String scrambleWord(String word) {
    var random = Random();
    var letters = word.split('');
    for (int i = 0; i < letters.length; i++) {
      int randomIndex = random.nextInt(letters.length);
      var temp = letters[i];
      letters[i] = letters[randomIndex];
      letters[randomIndex] = temp;
    }
    return letters.join();
  }

  String normalize(String input) {
    String normalized = input;
    const accents = 'ÀÁÂÃÄÅàáâãäåÒÓÔÕÖØòóôõöøÈÉÊËèéêëÇçÌÍÎÏìíîïÙÚÛÜùúûüÝýÿÑñ';
    const nonAccents =
        'AAAAAAaaaaaaOOOOOOooooooEEEEeeeeCcIIIIiiiiUUUUuuuuYyyNn';

    for (int i = 0; i < accents.length; i++) {
      normalized = normalized.replaceAll(accents[i], nonAccents[i]);
    }

    return normalized;
  }

  void submitWord() {
    if (isWordValid(currentWord)) {
      setState(() {
        score += calculateScore(currentWord);
        currentWord = '';
        pickRandomWord();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Mot invalide'),
          duration: Duration(seconds: 1),
        ),
      );
    }
    wordController.clear();
  }

  bool isWordValid(String word) {
    String normalizedInput = normalize(word);
    String normalizedRandomWord = normalize(randomWord);

    return normalizedInput.toLowerCase() == normalizedRandomWord.toLowerCase();
  }

  int calculateScore(String word) {
    return word.length;
  }

  @override
  void dispose() {
    wordController.dispose();
    gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double progress = (timeLeft / gameDuration).clamp(0.0, 1.0);

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.blue],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey[300],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
              ),
              const SizedBox(height: 10),
              Text(
                '$timeLeft s',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                '$score',
                style: const TextStyle(fontSize: 22, color: Colors.amber),
              ),
              const SizedBox(height: 20),
              Text(
                scrambledWord.toUpperCase(),
                style: const TextStyle(
                    fontSize: 20, color: Colors.lightGreenAccent),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: wordController,
                onChanged: (value) => setState(() => currentWord = value),
                decoration: InputDecoration(
                  hintText: "Formez un mot",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitWord,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Soumettre'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
