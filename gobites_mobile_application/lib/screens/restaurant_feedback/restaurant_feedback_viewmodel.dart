import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/feedback.dart';
import 'package:gobites/screens/viewmodel.dart';
import 'package:gobites/services/feedback/feecback_service.dart';

class RestaurantFeedbackViewmodel extends Viewmodel {
  FeedbackService get _service => dependency();
  List<Feedback> feedbackList;
  get averageRating =>
      feedbackList.fold(
          0.0, (previousValue, element) => previousValue + element.rating) /
      feedbackList.length.toDouble();

  Future init() async {
    feedbackList = await _service.getFeedbackList();
    turnIdle();
  }
}
