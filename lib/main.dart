import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final _duration = Duration(milliseconds: 10000);
  AnimationController _animationController;

  DateTime _startTime;
  DateTime _endTime;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,

      duration: _duration,
    )..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            setState(() {
              _endTime = DateTime.now();
            });
          }
        },
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, _) {
              return Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                        'AnimationController duration: ${_animationController.duration.inMilliseconds} milliseconds'),
                    Text(
                        'AnimationController value: ${_animationController.value.toStringAsFixed(3)}'),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    Text(_startTime != null
                        ? 'Start Time: ${_startTime.millisecondsSinceEpoch}'
                        : ''),
                    Text(_endTime != null
                        ? 'End Time: ${_endTime.millisecondsSinceEpoch}'
                        : ''),
                    Text(_startTime != null && _endTime != null
                        ? 'Animation ran in ${_endTime.millisecondsSinceEpoch - _startTime.millisecondsSinceEpoch} milliseconds'
                        : ''),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.only(top: 10.0),
                      child: InkWell(
                        onTap: () {
                          _startTime = DateTime.now();
                          _endTime = null;
                          _animationController.forward(from: 0.0);
                        },
                        child: Center(
                          child: Container(
                            padding: EdgeInsets.all(12.0),
                            child: Text('Run Animation'),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
