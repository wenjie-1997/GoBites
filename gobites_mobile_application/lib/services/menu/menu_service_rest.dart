import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/menu.dart';
import 'package:gobites/services/menu/menu_service.dart';
import 'package:gobites/services/rest.dart';

class MenuServiceRest extends MenuService {
  RestService get rest => dependency();

  Future<List<Menu>> getMenuList({int rid}) async {
    final result = await rest
        .get('menu/' + (rid == null ? user.rid.toString() : rid.toString()));
    List<Menu> menuList =
        result.map<Menu>((json) => Menu.fromJson(json)).toList();
    return menuList;
  }

  @override
  Future<void> addMenu(Map<String, dynamic> json) async {
    await rest.post('menu/' + user.rid.toString(), data: json);
  }

  @override
  Future updateMenu(Map<String, dynamic> json) async {
    await rest.put('menu/' + json['MID'].toString(), data: json);
  }

  @override
  Future deleteMenu(int mid) async {
    await rest.delete('menu/' + mid.toString());
  }
}
