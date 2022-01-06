<h1 align="center">Welcome to Flutter Web Navigation 2.0 👋</h1>
<p>
  <a href="http://www.apache.org/licenses/LICENSE-2.0" target="_blank">
    <img alt="License: Apache License, Version 2.0 (the &#34;License&#34;)" src="https://img.shields.io/badge/License-Apache License, Version 2.0 (the &#34;License&#34;)-yellow.svg" />
  </a>
     <a href="https://twitter.com/95Pushkar" target="_blank">
      <img alt="Twitter: 95Pushkar" src="https://img.shields.io/twitter/follow/95Pushkar.svg?style=social" />
    </a>
     <a href="https://twitter.com/ruchikaSjv" target="_blank">
      <img alt="Twitter: ruchikaSjv" src="https://img.shields.io/twitter/follow/ruchikaSjv.svg?style=social" />
    </a>
</p>


The github repository consist of a working example of flutter web routing with private and
protected routes along with params.

  <h2 align="center">Navigator2.0</h2>

<p>Navigator 2.0 uses a declarative style. Understanding Navigator 2.0 involves understanding a few of its concepts such as:</p>

<li> Router: A class that manages opening and closing pages of an application. </li>
<br>
The Router widget gets the configuration from the RouteInformationParser and sends it to the RouterDelegate by calling its setNewRoutePath method and asks to the RouterDelegate to build a new Navigator widget according to the current app state.
.
<br>

```dart
(new) MaterialApp MaterialApp.router({
  Key? key,
  GlobalKey<ScaffoldMessengerState>? scaffoldMessengerKey,
  RouteInformationProvider? routeInformationProvider,
  required RouteInformationParser<Object> routeInformationParser,
  required RouterDelegate<Object> routerDelegate,
  BackButtonDispatcher? backButtonDispatcher,
  Widget Function(BuildContext, Widget?)? builder,
})
```
<br>
<li> RouteInformationParser: An abstract class used by the Router‘s widget to parse route information into a configuration. parseRouteInformation will convert the given route information into parsed data to pass to RouterDelegate. </li>
<br>

RouteInformation holds location and state information of a route. The location field is a String and it is equivalent to a Web URL.
RouteInformationParser delegate parses the location field of the RouteInformation and returns an instance of a custom-defined data type. The instance of this data type is called a configuration in the design documents because it interprets the current app state.
<br>
```dart
@override
 parseRouteInformation()
```
<br>
<li> RouteInformationProvider: An abstract class that provides route information for the Router‘s widget.  </li>
<br>


RouteInformationProvider receives the route name String (URL) from the OS.
RouteInformationProvider generates RouteInformation instance from the route name and notifies the Router widget.
The Router widget gets the RouteInformation and passes it to the RouteInformationParser delegate by calling its parseRouteInformation method.
<br>

<li> RouterDelegate: An abstract class used by the Router‘s widget to build and configure a navigating widget. </li>
<br>

The role of the RouterDelegate in the flow 2 (Router to OS) is providing the currentConfiguration to Router widget. Then theRouter widget restores the RouteInformation with the help of its RouteInformationParser delegate.
<br>

<li> BackButtonDispatcher: Reports to a Router when the user taps the back button on platforms that support back buttons (such as Android). </li>
<br>
<li> TransitionDelegate: The delegate that decides how pages transition in or out of the screen when it’s added or removed. </li>
<br>
  <h2 align="center">Auth- Private and Protected Routes</h2>

![Auth.gif](screenshots/Auth.gif)
<br>
  <h2 align="center">Routes with custom params</h2>

![Param.gif](screenshots/Param.gif)
<br>
<br>
<br>
## Author

👤 **Pushkar Kumar**

- Twitter: [@95Pushkar](https://twitter.com/95Pushkar)
- Github: [@Pushkar952](https://github.com/Pushkar952)
- LinkedIn:
  [@https:\/\/www.linkedin.com\/in\/Pushkar-Kumar\/](https://www.linkedin.com/in/pushkar-kumar-84183091/)

👤 **Ruchika Gupta**

- Twitter: [@ruchikaSjv](https://twitter.com/ulusoyapps)
- Github: [@geekruchika](https://github.com/geekruchika)
- LinkedIn:
  [@https:\/\/www.linkedin.com\/in\/ruchika-gupta\/](https://www.linkedin.com/in/ruchika-gupta-b18946134/)

## Show your support

Give a ⭐️ if this project helped you!

## 📝 License

Copyright © 2020 [Pushkar Kumar](https://github.com/Pushkar952).<br />
This project is
[Apache License, Version 2.0 (the &#34;License&#34;)](http://www.apache.org/licenses/LICENSE-2.0)
licensed.

---

_This README was generated with ❤️ by
[readme-md-generator](https://github.com/kefranabg/readme-md-generator)_
