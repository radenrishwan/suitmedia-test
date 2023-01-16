import 'package:flutter/material.dart';

class PalindromeProvider extends ChangeNotifier {
  bool isPalindrome(String sentence) {
    final String reversedSentence = sentence.split('').reversed.join();

    return sentence == reversedSentence;
  }
}
