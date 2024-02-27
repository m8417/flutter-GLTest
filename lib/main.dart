import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<double> _sizeList = [1, 2];
  double _size = 1;
  void _onClick() {
    setState(() {
      _size = _sizeList[(_sizeList.indexOf(_size) + 1) % _sizeList.length];
    });
  }

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio =
        MediaQueryData.fromWindow(WidgetsBinding.instance.window)
            .devicePixelRatio;
    final size = MediaQuery.of(context).size;
    print('');
    print('');
    print('');
    print('');
    print(
        'Flutter screen size: ${size.width * devicePixelRatio} ${size.height * devicePixelRatio}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Container(
          width: (MediaQuery.of(context).size.width - 10) / _size,
          height: (MediaQuery.of(context).size.height - 10) / _size,
          color: Colors.blue,
          child: const AndroidView(
            viewType: "SurfaceView",
            layoutDirection: TextDirection.ltr,
            creationParamsCodec: StandardMessageCodec(),
            hitTestBehavior:
                PlatformViewHitTestBehavior.transparent, //禁止native可交互
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: _onClick,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
