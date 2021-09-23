import 'package:gobites/models/feedback.dart';

abstract class FeedbackService {
  Future<List<Feedback>> getFeedbackList();
  Future makeFeedback(int oid, int rid, double rating, String comment);
}
