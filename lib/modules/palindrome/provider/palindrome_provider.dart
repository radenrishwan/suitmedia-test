import 'package:flutter/material.dart';

class PalindromeProvider extends ChangeNotifier {
  bool isEmpty = true;

  bool isPalindrome(String sentence) {
    final String reversedSentence = sentence.split('').reversed.join();

    return sentence == reversedSentence;
  }

  bool checkIsEmpty(String text) {
    if (text.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    notifyListeners();

    return isEmpty;
  }
}
