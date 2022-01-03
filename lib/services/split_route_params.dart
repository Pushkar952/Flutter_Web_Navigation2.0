List<String> getRouteParams(String routeName) {
  List<String> _temp = [];
  _temp = routeName.split('/');
  return _temp;
}
