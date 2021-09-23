import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/customer.dart';
import 'package:gobites/services/rest.dart';
import 'package:gobites/services/customer/customer_service.dart';

class CustomerServiceRest extends CustomerService {
  RestService get rest => dependency();

  @override
  Future<Customer> getCustomerProfile() async {
    final json = await rest.get("customer/" + user.id.toString());
    if (json['image'] != null)
      json['image'] = rest.baseUrl + '/' + json['image'];
    return Customer.fromJson(json);
  }

  @override
  Future updateProfile(Customer customer) async {
    print(customer.toJson());
    await rest.put('customer/' + user.cid.toString(), data: customer.toJson());
  }

  Future uploadImage(String name, String image) async {
    await rest.post('user/upload_image',
        data: {'cid': user.cid, 'name': name, 'image': image});
  }

  @override
  Future<bool> checkPassword(String password) async {
    bool result = await rest.post('user/check_password/' + user.id.toString(),
        data: {'password': password});
    return result;
  }

  Future updatePassword(String password) async {
    await rest.post('user/update_password/' + user.id.toString(),
        data: {'password': password});
  }
}
