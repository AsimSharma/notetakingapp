class NotesModels {
  final int? id;
  final String title, descriptions;
  final int priority, colors;

  NotesModels(
      {this.id,
      required this.title,
      required this.descriptions,
      required this.priority,
      required this.colors});

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "descriptions": descriptions,
        "priority": priority,
        "colors": colors
      };

  factory NotesModels.fromJson(Map<String, dynamic> json) {
    return NotesModels(
        id: json['id'],
        title: json['title'],
        descriptions: json['descriptions'],
        priority: json['priority'],
        colors: json['colors']);
  }
}
