import 'package:gobites/models/customer.dart';

abstract class CustomerService {
  Future<Customer> getCustomerProfile();
  Future updateProfile(Customer customer);
  Future uploadImage(String name, String image);
  Future<bool> checkPassword(String password);
  Future updatePassword(String password);
}
