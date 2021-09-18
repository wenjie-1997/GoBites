import 'package:gobites/models/feedback.dart';

abstract class FeedbackService {
  Future<List<Feedback>> getFeedbackList();
}
