import 'package:flutter/material.dart';

import 'app/dependencies.dart' as di;
import 'app/router.dart';

void main() {
  di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Listener(
        onPointerDown: (_) {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
          }
        },
        child: MaterialApp(
          title: 'Gobites',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: '/login',
          onGenerateRoute: createRoute,
        ));
  }
}
