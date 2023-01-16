import 'package:flutter/material.dart';

class PalindromeProvider extends ChangeNotifier {
  bool isEmpty = true;

  bool isPalindrome(String sentence) {
    final String reversedSentence = sentence.split('').reversed.join();

    return sentence == reversedSentence;
  }

  void checkIsEmpty(String name, String sentence) {
    if (name.isEmpty || sentence.isEmpty || name.isEmpty && sentence.isEmpty) {
      isEmpty = true;
    } else {
      isEmpty = false;

      notifyListeners();
    }
  }
}
