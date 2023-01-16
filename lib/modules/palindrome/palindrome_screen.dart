import 'package:flutter/material.dart';
import 'package:magang/helper/contant.dart';
import 'package:magang/modules/palindrome/provider/palindrome_provider.dart';
import 'package:magang/modules/welcome/welcome_sceen.dart';
import 'package:provider/provider.dart';

class PalindromeScreen extends StatefulWidget {
  const PalindromeScreen({super.key});

  @override
  State<PalindromeScreen> createState() => _PalindromeScreenState();
}

class _PalindromeScreenState extends State<PalindromeScreen> {
  final TextEditingController _palindromeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    _palindromeController.addListener(() {
      context.read<PalindromeProvider>().checkIsEmpty(_nameController.text, _palindromeController.text);
    });
    _nameController.addListener(() {
      context.read<PalindromeProvider>().checkIsEmpty(_nameController.text, _palindromeController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/background/login-background.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                left: kBigPadding.left,
                right: kBigPadding.right,
              ),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      height: 116,
                      width: 116,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(58),
                        color: Colors.white.withOpacity(0.5),
                      ),
                      child: const Icon(
                        Icons.person_add_alt_sharp,
                        size: 36,
                        color: kBackgroundColor,
                      ),
                    ),
                    const SizedBox(height: 58),
                    TextFormField(
                      controller: _nameController,
                      cursorColor: Colors.pink.shade300,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Name',
                        fillColor: kBackgroundColor,
                        focusColor: kBackgroundColor,
                        hoverColor: kBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        if (_nameController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Result'),
                                content: const Text('Name cannot be empty'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name cannot be empty';
                        }

                        return null;
                      },
                    ),
                    const SizedBox(height: 22),
                    TextFormField(
                      controller: _palindromeController,
                      cursorColor: Colors.pink.shade300,
                      decoration: const InputDecoration(
                        filled: true,
                        hintText: 'Palindrome',
                        fillColor: kBackgroundColor,
                        focusColor: kBackgroundColor,
                        hoverColor: kBackgroundColor,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 0, color: Colors.transparent),
                          borderRadius: kDefaultBorderRadius,
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (value) {
                        if (_palindromeController.text.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Result'),
                                content: const Text('Sentence cannot be empty'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Sentence cannot be empty';
                        }

                        return null;
                      },
                    ),
                    SizedBox(height: kTabLabelPadding.left),
                    SizedBox(
                      width: double.infinity,
                      height: 41,
                      child: ElevatedButton(
                        onPressed: context.watch<PalindromeProvider>().isEmpty
                            ? null
                            : () {
                                // TODO: move to provider
                                final isPalindrome =
                                    context.read<PalindromeProvider>().isPalindrome(_palindromeController.text);

                                if (isPalindrome) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Result'),
                                        content: const Text('isPalindrome'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text('Result'),
                                        content: const Text('not palindrome'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('OK'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: kDefaultBorderRadius,
                          ),
                          disabledBackgroundColor: Colors.indigo.shade900,
                          backgroundColor: kPrimaryColor,
                        ),
                        child: const Text('Check'),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: double.infinity,
                      height: 41,
                      child: ElevatedButton(
                        onPressed: context.watch<PalindromeProvider>().isEmpty
                            ? null
                            : () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return WelcomeScreen(name: _nameController.text);
                                    },
                                  ),
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: kDefaultBorderRadius,
                          ),
                          disabledBackgroundColor: Colors.indigo.shade900,
                          backgroundColor: kPrimaryColor,
                        ),
                        child: const Text('Next'),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
