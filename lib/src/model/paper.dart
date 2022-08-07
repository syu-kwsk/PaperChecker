class Paper {
  final String title;
  final String abstract;
  final String link;
  final String date;
  final String doi;

  Paper.fromJson(Map<String, dynamic> json) :
        title = json["title"],
        abstract = json["description"],
        link = json["@id"],
        date = json["prism:publicationDate"],
        doi = json["dc:publisher"];
}
