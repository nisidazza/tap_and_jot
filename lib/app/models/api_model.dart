// class Answer {
//   final String reading;

//   Answer({required this.reading});

//   factory Answer.fromJson(Map<String, dynamic> json) {
//     return Answer(reading: json['reading']);
//   }
// }

class Quotes {
  final String text;
  final String author;

  Quotes({
    required this.text,
    required this.author,
  });

  factory Quotes.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'text': String text,
        'author': String author,
      } =>
        Quotes(
          text: text,
          author: author,
        ),
      _ => throw const FormatException('Failed to load quotes')
    };
  }
}
