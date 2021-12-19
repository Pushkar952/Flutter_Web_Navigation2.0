/// Class to define path structure
class RoutePath {
  final String? pathName;
  final bool isUnknown;

  RoutePath.home(this.pathName) : isUnknown = false;
  RoutePath.otherPage(this.pathName) : isUnknown = false;
  RoutePath.unknown()
      : pathName = null,
        isUnknown = true;

  bool get isHomePage => pathName == null;
  bool get isOtherPage => pathName != null;
}
