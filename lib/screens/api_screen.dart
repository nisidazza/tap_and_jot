import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jiggle_and_jot/model/api_model.dart';

class AnswerScreen extends StatefulWidget {
  const AnswerScreen({super.key});

  @override
  State<AnswerScreen> createState() => _AnswerScreenState();
}

class _AnswerScreenState extends State<AnswerScreen> {
  late Future<Answer> answer;

  @override
  void initState() {
    super.initState();
    answer = fetchAnswer();
  }

  Future<Answer> fetchAnswer() async {
    final response = await http.get(Uri.parse("https://eightballapi.com/api"));
    if (response.statusCode == 200) {
      return Answer.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      throw Exception("Failed to load answer");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Your reading'),
        ),
        body: Center(
            child: FutureBuilder<Answer>(
                future: answer,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(snapshot.data!.reading);
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }

                  return const CircularProgressIndicator();
                })));
  }
}
