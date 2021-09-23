import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/feedback.dart';
import 'package:gobites/services/feedback/feecback_service.dart';
import 'package:gobites/services/rest.dart';

class FeedbackServiceRest extends FeedbackService {
  RestService get rest => dependency();

  @override
  Future<List<Feedback>> getFeedbackList() async {
    final result = await rest.get('feedback/restaurant/' + user.rid.toString());
    List<Feedback> feedbackList =
        result.map<Feedback>((json) => Feedback.fromJson(json)).toList();
    return feedbackList;
  }

  @override
  Future makeFeedback(int oid, int rid, double rating, String comment) async {
    await rest.post('feedback',
        data: {"oid": oid, "rid": rid, "rating": rating, "comment": comment});
  }
}
