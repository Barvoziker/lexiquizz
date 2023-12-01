import 'package:flutter/material.dart';
import 'game_screen.dart';
import 'score_manager.dart';

class EndGameScreen extends StatelessWidget {
  final int currentScore;

  const EndGameScreen({super.key, required this.currentScore});

  @override
  Widget build(BuildContext context) {
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
              Text(
                '$currentScore pts',
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(height: 20),
              const Text(
                'Meilleurs scores',
                style: TextStyle(fontSize: 22, color: Colors.amber),
              ),
              FutureBuilder<List<String>>(
                future: ScoreManager.getScores(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Text('Aucun score précédent');
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        // Splitting the string to separate the score and the date
                        var scoreDetails = snapshot.data![index].split(' - ');
                        var score = scoreDetails[0];
                        var date = scoreDetails[1];

                        return ListTile(
                          title: Text(
                            '$score le $date',
                            style:
                                const TextStyle(color: Colors.lightGreenAccent),
                          ),
                          leading: const Icon(Icons.star, color: Colors.amber),
                        );
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const GameScreen()),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  textStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Rejouer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
