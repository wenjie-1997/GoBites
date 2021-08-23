import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/customer.dart';
import 'package:gobites/services/rest.dart';
import 'package:gobites/services/customer/customer_service.dart';


class CustomerServiceRest extends CustomerService {
  RestService get rest => dependency();

  @override
  Future<Customer> getCustomerProfile() async {
    final json = await rest.get("customer/" + user.id.toString());
    return Customer.fromJson(json);
  }

}
