class Feedbacks {
  final double rating;
  final String comment;
  final int RID;
  final int FID;

  Feedbacks({this.FID, this.rating, this.comment, this.RID});

  factory Feedbacks.fromJson(Map<String, dynamic> json) {
    return Feedbacks(
        FID: json['fid'],
        rating:
            ((json['rating'] is int) ? json['rating'] + .0 : json['rating']),
        comment: json['comment'],
        RID: json['rid']);
  }
}
