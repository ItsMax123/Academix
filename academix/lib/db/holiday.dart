class Holiday {
  int id;
  String name;
  DateTime date;

  Holiday(this.id, this.name, this.date);

  factory Holiday.fromMap(Map<String, dynamic> data) {
    return Holiday(
      data["id"],
      data["nameEn"],
      DateTime.parse(data["date"]),
    );
  }
}
