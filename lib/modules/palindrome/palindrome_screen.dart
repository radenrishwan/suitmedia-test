import 'package:flutter/material.dart';
import 'package:magang/modules/palindrome/provider/palindrome_provider.dart';
import 'package:provider/provider.dart';

class PalindromeScreen extends StatefulWidget {
  const PalindromeScreen({super.key});

  @override
  State<PalindromeScreen> createState() => _PalindromeScreenState();
}

class _PalindromeScreenState extends State<PalindromeScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    _controller.addListener(() {
      context.read<PalindromeProvider>().checkIsEmpty(_controller.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Palindrome'),
      ),
      body: Padding(
        padding: kTabLabelPadding,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Put your sentence here',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: kTabLabelPadding.left),
              TextFormField(
                controller: _controller,
                cursorColor: Colors.pink.shade300,
                decoration: InputDecoration(
                  hintText: 'kasur rusak',
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink.shade300,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.pink.shade300,
                    ),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
                autofocus: true,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) {
                  if (_controller.text.isEmpty) {
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
              ElevatedButton(
                onPressed: context.watch<PalindromeProvider>().isEmpty
                    ? null
                    : () {
                        final isPalindrome = context.read<PalindromeProvider>().isPalindrome(_controller.text);

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
                  disabledBackgroundColor: Colors.pink.shade300,
                  backgroundColor: Colors.pink.shade500,
                ),
                child: const Text('Check'),
              ),
              // register
              TextButton(
                onPressed: () {},
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
