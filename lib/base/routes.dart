import 'package:fish_redux/fish_redux.dart';

abstract class WingsRoutes {
  static PageRoutes routes;

  Map<String, Page<Object, dynamic>> initPages();

  initVisitor(String path, Page<Object, dynamic> page);

  WingsRoutes() {
    routes = PageRoutes(
        pages: initPages(),
        visitor: (path, page) {
          initVisitor(path, page);
        });
  }
}
