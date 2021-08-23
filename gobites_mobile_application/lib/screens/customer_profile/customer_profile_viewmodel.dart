import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/customer.dart';
import 'package:gobites/services/customer/customer_service.dart';

import '../viewmodel.dart';

class CustProfileViewmodel extends Viewmodel {
  CustomerService get _service => dependency();
  Customer customer;

  void init() async {
    turnBusy();
    customer = await _service.getCustomerProfile();
    turnIdle();
  }
}
