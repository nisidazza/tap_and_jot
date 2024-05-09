class Answer {
  final String reading;

  Answer({required this.reading});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(reading: json['reading']);
  }
}
