class ItemModel {
  final String image;
  final String title;
  final DateTime deadline;
  final int min;
  final int max;
  final String publisher;
  final String description;
  final String docId; 

  ItemModel(
      {required this.image,
      required this.title,
      required this.deadline,
      required this.min,
      required this.max,
      required this.publisher,
      required this.description ,
      this.docId=""
      });
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
        image: json['image'],
        title: json['titre'],
        deadline: json['deadline'],
        min: json['min'],
        max: json['max'],
        publisher: json['publisher'],
        description: json['description'] , 
        docId : json['id'],
        );
  }
}
