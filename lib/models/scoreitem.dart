class scoreItem {
  final int number;
  final String title;
  final String name;
  final int score;

  scoreItem({
    required this.number,
    required this.title,
    required this.name,
    required this.score,
  });
  factory scoreItem.fromJson(Map<String, dynamic> json) {
    return scoreItem(
      number: json['candidateNumber'],
      title: json['candidateTitle'],
      name: json['candidateName'],
      score : json['score'],
    );
  }

  scoreItem.fromJson2(Map<String, dynamic> json)
      : number = json['candidateNumber'],
        title = json['candidateTitle'],
        name = json['candidateName'],
        score = json['score'];

  String toString() {
    return '$title$name';
  }
  String printnumber() {
    return '$number';
  }
  String printscore() {
    return '$score';
  }
}
