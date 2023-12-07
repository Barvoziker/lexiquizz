# Ressources pour le Développement Flutter

## Logo et gestion des accents
- [ChatGPT](https://chat.openai.com)

### Prompt pour le logo : Genere moi un logo d'application mobile pour un jeu ou il faut devnier un mot suivant la chaine de caractere donnée.

### Prompt pour les accents : Peux-tu me fournir un exemple de fonction en Dart pour normaliser une chaîne de caractères en remplaçant les lettres accentuées par leurs équivalents sans accent ?

### Reponse : 

Bien sûr, voici une fonction en Dart qui normalise une chaîne de caractères en remplaçant les lettres accentuées par leurs équivalents sans accent :

```dart
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
```

Cette fonction parcourt chaque caractère de la chaîne `input` et remplace les caractères accentués par leur équivalent sans accent en utilisant deux chaînes constantes : `accents` pour les caractères accentués et `nonAccents` pour leurs correspondants sans accent.

## Généralités et Animations
- [Flutter Documentation](https://flutter.dev/docs)
- [Flutter API Reference](https://api.flutter.dev/)

## Widgets et UI
- [Widgets Introduction - Flutter](https://flutter.dev/docs/development/ui/widgets-intro)
- [Layouts in Flutter](https://flutter.dev/docs/development/ui/layout)

## Gestion de l'État
- [State Management - Flutter](https://flutter.dev/docs/development/data-and-backend/state-mgmt/intro)

## Navigation et Routes
- [Navigation and Routing - Flutter](https://flutter.dev/docs/development/ui/navigation)

## Gestion des Fichiers JSON
- [Working with JSON in Flutter](https://flutter.dev/docs/development/data-and-backend/json)
- [JSON and serialization - Flutter](https://flutter.dev/docs/development/data-and-backend/json)
- [Thousand most common words - GitHub](https://github.com/SMenigat/thousand-most-common-words/blob/master/words/fr.json)

## SharedPreferences
- [Using SharedPreferences in Flutter](https://pub.dev/packages/shared_preferences)

## Manipulation de Texte et Contrôleurs
- [TextEditingController class - Flutter](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html)
- [Handling Text Input - Flutter](https://flutter.dev/docs/cookbook/forms/text-field-changes)

## Formatage de Date
- [DateFormat class - intl package](https://pub.dev/documentation/intl/latest/intl/DateFormat-class.html)

## Asynchrone et Futures
- [Asynchronous Programming: Futures - Dart](https://dart.dev/codelabs/async-await)

## Gestion des Scores
- [Reading and Writing Files - Flutter](https://flutter.dev/docs/cookbook/persistence/reading-writing-files)