class elecItem {
  final int number;
  final String title;
  final String name;


  elecItem({
    required this.number,
    required this.title,
    required this.name,
  });
  factory elecItem.fromJson(Map<String, dynamic> json) {
    return elecItem(
      number: json['candidateNumber'],
      title: json['candidateTitle'],
      name: json['candidateName'],
    );
  }

  elecItem.fromJson2(Map<String, dynamic> json)
      : number = json['candidateNumber'],
        title = json['candidateTitle'],
        name = json['candidateName'];

  String toString() {
    return '$title$name';
  }
  String printnumber() {
    return '$number';
  }
}
