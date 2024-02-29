import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:gltest/SecondPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<double> _sizeList = [1, 2];

  bool _isPressed = false;
  double _size = 1;
  void _onClick() {
    // setState(() {
    //   _size = _sizeList[(_sizeList.indexOf(_size) + 1) % _sizeList.length];
    // });

    setState(() {
      // final temp = surfaceList.first;
      // surfaceList.first = surfaceList.last;
      // surfaceList.last = temp;

      _isPressed = !_isPressed;
    });

  }
  List<Widget> surfaceList = [];

  late Widget surfaceA;

  late Widget surfaceB;

  @override
  void initState() {
    // TODO: implement initState

    surfaceA = Container(
        padding: const EdgeInsets.all(10),

        child:PlatformViewLink(
          viewType: "SurfaceView",
          surfaceFactory: (context, controller) {
            return AndroidViewSurface(
              controller: controller as AndroidViewController,
              gestureRecognizers: const <Factory<
                  OneSequenceGestureRecognizer>>{},
              hitTestBehavior: PlatformViewHitTestBehavior.opaque,
            );
          },
          onCreatePlatformView: (params) {
            return PlatformViewsService.initSurfaceAndroidView(
              id: params.id,
              viewType: "SurfaceView",
              layoutDirection: TextDirection.ltr,
              creationParams: {"name" : "A"},
              creationParamsCodec: const StandardMessageCodec(),
              onFocus: () {
                params.onFocusChanged(true);
              },
            )..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();
          },
        ));


    surfaceB = Container(
          padding: const EdgeInsets.all(20),
          child:
          PlatformViewLink(
            viewType: "SurfaceView",
            surfaceFactory: (context, controller) {
              return AndroidViewSurface(
                controller: controller as AndroidViewController,
                gestureRecognizers: const <Factory<
                    OneSequenceGestureRecognizer>>{},
                hitTestBehavior: PlatformViewHitTestBehavior.opaque,
              );
            },
            onCreatePlatformView: (params) {
              return PlatformViewsService.initSurfaceAndroidView(
                id: params.id,
                viewType: "SurfaceView",
                layoutDirection: TextDirection.ltr,
                creationParams: {"name" : "B"},
                creationParamsCodec: const StandardMessageCodec(),
                onFocus: () {
                  params.onFocusChanged(true);
                },
              )..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
                ..create();
            },
          ),
        ) ;


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .devicePixelRatio;
    final size = MediaQuery.of(context).size;
    if (!_isPressed) {
      surfaceList = [surfaceA, surfaceB];
    } else {
      surfaceList = [surfaceB, surfaceA];
    }
    print('');
    print('');
    print('');
    print('');
    print(
        'Flutter screen size: ${size.width * devicePixelRatio} ${size.height * devicePixelRatio}');

    print(
        'first: ${surfaceList.first.hashCode} last: ${surfaceList.last.hashCode}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          width: (MediaQuery.of(context).size.width - 10) / _size,
          height: (MediaQuery.of(context).size.height - 10) / _size,
          padding: const EdgeInsets.all(10),
          child:
          // const AndroidView(
          //   viewType: "SurfaceView",
          //   layoutDirection: TextDirection.ltr,
          //   creationParamsCodec: StandardMessageCodec(),
          //   hitTestBehavior:
          //       PlatformViewHitTestBehavior.transparent, //禁止native可交互
          // )
          Stack(children: surfaceList,)

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClick,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
