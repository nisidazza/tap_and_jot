class Quote {
  final String text;
  final String author;

  Quote({
    required this.text,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'text': String text,
          'author': String author,
        }) {
      return Quote(text: text, author: author);
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }
}
