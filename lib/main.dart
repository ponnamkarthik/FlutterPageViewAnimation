import 'package:flutter_pageview_animation/page_transform.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'PageView Animation',
      home: new MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  State createState() => new MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {

  final _kArrowColor = Colors.black.withOpacity(0.8);

  final List<Widget> _pages = <Widget>[
    new Container(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(colors: Colors.blue),
    ),
    new Container(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.stacked, colors: Colors.red),
    ),
    new Container(
      constraints: const BoxConstraints.expand(),
      child: new FlutterLogo(style: FlutterLogoStyle.horizontal, colors: Colors.green),
    ),
  ];


  @override
  Widget build(BuildContext context) {


    return new Scaffold(
      body: new IconTheme(
        data: new IconThemeData(color: _kArrowColor),
        child: new Stack(
          children: <Widget>[
            new PageTransformer(
              pageViewBuilder: (context, visibilityResolver) {
                return new PageView.builder(
                  scrollDirection: Axis.vertical,
                  controller: new PageController(viewportFraction: 0.85),
                  itemCount: _pages.length,
                  itemBuilder: (context, index) {
                    final pageVisibility =
                    visibilityResolver.resolvePageVisibility(index);

                    return new Transform(
                      alignment: Alignment(0.0, 0.0),
                      transform: new Matrix4.identity()..scale(pageVisibility.visibleFraction, pageVisibility.visibleFraction, pageVisibility.visibleFraction),
                      child: new Opacity(
                          opacity: pageVisibility.visibleFraction,
                          child: _pages[index]
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}