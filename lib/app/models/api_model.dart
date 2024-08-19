class Quote {
  final String quote;
  final String author;

  Quote({
    required this.quote,
    required this.author,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    if (json
        case {
          'quote': String quote,
          'author': String author,
        }) {
      return Quote(quote: quote, author: author);
    } else {
      throw FormatException('Invalid JSON: $json');
    }
  }
}
