class Feedback {
  final double rating;
  final String comment;
  final int id;

  Feedback({this.id, this.rating, this.comment});

  Feedback.fromJson(Map<String, dynamic> json)
      : this(
          id: json['fid'],
          rating:
              ((json['rating'] is int) ? json['rating'] + .0 : json['rating']),
          comment: json['comment'],
        );
}
