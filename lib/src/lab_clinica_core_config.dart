import 'package:asyncstate/asyncstate.dart';
import 'package:et_lab_clinica_core/et_lab_clinica_core.dart';
import 'package:et_lab_clinica_core/src/theme/lab_clinica_theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_getit/flutter_getit.dart';

class LabClinicaCoreConfig extends StatelessWidget {
  const LabClinicaCoreConfig({
    super.key,
    this.binding,
    this.pages,
    this.pagesBuilders,
    this.modules,
    required this.title,
    this.didStart,
  });

  final ApplicationBindings? binding;
  final List<FlutterGetItPageRouter>? pages;
  final List<FlutterGetItPageBuilder>? pagesBuilders;
  final List<FlutterGetItModule>? modules;
  final String title;
  final VoidCallback? didStart;

  @override
  Widget build(BuildContext context) {
    return FlutterGetIt(
      debugMode: kDebugMode,
      bindings: binding,
      pages: [
        ...pages ?? [],
        ...pagesBuilders ?? [],
      ],
      modules: modules,
      builder: (context, routes, flutterGetItNavObserver) {
        return AsyncStateBuilder(
          loader: LabClinicaLoader(),
          builder: (navigatorObserver) {
            if (didStart != null) {
              didStart!();
            }

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: LabClinicaTheme.lightTheme,
              darkTheme: LabClinicaTheme.dartkTheme,
              navigatorObservers: [
                navigatorObserver,
                flutterGetItNavObserver,
              ],
              routes: routes,
              title: title,
            );
          },
        );
      },
    );
  }
}
