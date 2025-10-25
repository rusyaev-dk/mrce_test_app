abstract class AppRoutes {
  static const home = "/home";
  static const settings = "/home/settigns";

  static String somePageWithArg(String arg) => "/home/somepage/$arg";
}
