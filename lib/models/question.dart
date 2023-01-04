class Question {
  final String id;
  final String title;
  final Map<String, bool> option;
  Question({required this.id, required this.title, required this.option});
  @override
  String toString() {
    // TODO: implement toString
    return 'Question(id:$id,title:$title,answer:$option)';
  }
}
