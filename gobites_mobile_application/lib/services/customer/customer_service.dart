import 'package:gobites/models/customer.dart';

abstract class CustomerService {
  Future<Customer> getCustomerProfile();
}
