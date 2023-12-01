import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ScoreManager {
  static const String _scoresKey = 'scores';

  static Future<List<String>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoreStrings = prefs.getStringList(_scoresKey) ?? [];

    // Tri par ordre décroissant
    scoreStrings.sort((a, b) {
      int scoreA = int.parse(a.split(' - ')[0]);
      int scoreB = int.parse(b.split(' - ')[0]);
      return scoreB
          .compareTo(scoreA); // Notez l'inversion pour un tri décroissant
    });

    return scoreStrings;
  }

  static Future<void> saveScore(int newScore) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoreStrings = prefs.getStringList(_scoresKey) ?? [];

    // Formatage de la date actuelle
    String formattedDate =
        DateFormat('yyyy-MM-dd – kk:mm').format(DateTime.now());

    // Ajout du score et de la date
    scoreStrings.add('$newScore - $formattedDate');

    await prefs.setStringList(_scoresKey, scoreStrings);
  }
}
