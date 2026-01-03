import 'package:marshaller/config/app_routes.dart';
import 'package:marshaller/config/go_router.dart';

class AppNavigation {
  static void goNamed(
    String route, {
    Map<String, String>? pathParameters,
    dynamic extra,
  }) {
    goRouter.goNamed(route, pathParameters: pathParameters ?? {}, extra: extra);
  }

  static void pushNamed(
    String route, {
    Map<String, String>? pathParameters,
    dynamic extra,
  }) {
    goRouter.pushNamed(
      route,
      pathParameters: pathParameters ?? {},
      extra: extra,
    );
  }

  static void replaceNamed(
    String route, {
    Map<String, String>? pathParameters,
    dynamic extra,
  }) {
    goRouter.replaceNamed(
      route,
      pathParameters: pathParameters ?? {},
      extra: extra,
    );
  }

  static void push(String path, {dynamic extra}) {
    goRouter.push(path, extra: extra);
  }

  static void go(String path, {dynamic extra}) {
    goRouter.go(path, extra: extra);
  }

  static bool canPop() {
    return true;
  }

  static void pop() {
    if (goRouter.canPop()) {
      goRouter.pop();
    } else {
      goToHome();
    }
  }

  static void goToHome() {
    goRouter.goNamed(AppRoutes.home);
  }

  static void popToHome() {
    goRouter.goNamed(AppRoutes.home);
  }
}
