import 'package:gobites/models/menu.dart';

abstract class MenuService {
  Future<List<Menu>> getMenuList({int rid});
  Future<void> addMenu(Map<String, dynamic> json);
  Future updateMenu(Map<String, dynamic> json);
  Future deleteMenu(int mid);
}
