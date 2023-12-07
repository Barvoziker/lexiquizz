import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class ScoreManager {
  static const String _scoresKey = 'scores';

  static Future<List<String>> getScores() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoreStrings = prefs.getStringList(_scoresKey) ?? [];

    scoreStrings.sort((a, b) {
      int scoreA = int.parse(a.split(' - ')[0]);
      int scoreB = int.parse(b.split(' - ')[0]);
      return scoreB.compareTo(scoreA);
    });

    return scoreStrings;
  }

  static Future<void> saveScore(int newScore) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> scoreStrings = prefs.getStringList(_scoresKey) ?? [];

    String formattedDate =
        DateFormat('dd/MM/yyyy HH:mm').format(DateTime.now());

    scoreStrings.add('$newScore - $formattedDate');

    await prefs.setStringList(_scoresKey, scoreStrings);
  }
}
