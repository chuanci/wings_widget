import 'package:flutter/material.dart';

mixin _WingsPluginLifecycle {
  Future<void> beforeRunApp();

  Function onRunApp(Function fun);

  Widget onCreateApp(Widget widget);

  Future<void> onPage();
}

abstract class WingsPlugins with _WingsPluginLifecycle {
  List<WingsPlugin> get plugins;

  @override
  Future<void> beforeRunApp() async {
    for (WingsPlugin e in plugins ?? []) {
      await e.beforeRunApp();
    }
  }

  @override
  Function onRunApp(Function fun) {
    Function f = fun;
    for (WingsPlugin e in plugins ?? []) {
      f = (e.onRunApp(f));
    }
    return f();
  }

  @override
  Widget onCreateApp(Widget widget) {
    Widget w = widget;
    for (WingsPlugin e in plugins ?? []) {
      e.onCreateApp(w);
    }
    ;
    return w;
  }

  @override
  onPage() async {
    for (WingsPlugin e in plugins ?? []) {
      await e.onPage();
    }
  }
}

abstract class WingsPlugin with _WingsPluginLifecycle {
  @override
  beforeRunApp() async {}

  @override
  Function onRunApp(Function fun) {
    return fun;
  }

  @override
  Widget onCreateApp(Widget widget) {
    return widget;
  }

  @override
  onPage() async {}
}
