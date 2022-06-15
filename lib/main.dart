import 'dart:collection';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const MyHomePage(title: 'From02Hero'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

String calculateMinStepsToGet(int target) {
  String way = "";

  Queue<int> queue = new Queue();
  List<int> path = List<int>.filled(target + 1, -1);

  queue.add(0);

  while (!queue.isEmpty) {
    int current = queue.removeFirst();
    if (current + 1 <= target && path[current + 1] == -1) {
      path[current + 1] = current;
      queue.add(current + 1);
    }
    if ((0 < current * 2 && current * 2 <= target) && path[current * 2] == -1) {
      path[current * 2] = current;
      queue.add(current * 2);
    }
  }
  for (int u = _target; u != -1; u = path[u]) way = u.toString() + "->" + way;
  return way.substring(0, way.lastIndexOf('-'));
}

final _random = new Random();

int getRandomTarget() {
  int max = 210, min = 10;
  return min + _random.nextInt(max - min);
}

int _target = getRandomTarget();
String _path = calculateMinStepsToGet(_target);

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _minStepsCnt = '-'.allMatches(_path).length;

  @override
  Widget build(BuildContext context) {
    print(_path);
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 30),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Target: \$$_target',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo)),
                        Text('Steps: $_minStepsCnt',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.indigo))
                      ]),
                ]),
                Column(children: [
                  Padding(
                      padding: EdgeInsets.only(top: 50, bottom: 50),
                      child: Text(
                        '\$$_counter',
                        style: TextStyle(
                            fontSize: 100,
                            fontWeight: FontWeight.normal,
                            color: Colors.blueGrey),
                      )),
                ]),
                Align(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      Row(children: [
                        FloatingActionButton(
                            onPressed: () {
                              setState(() {
                                if (_minStepsCnt > 0) {
                                  _minStepsCnt -= 1;
                                  _counter += 1;
                                }
                                if (_counter == _target) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title: Text(
                                              'Congratulations!\nYou Win \$$_target\n^_^',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.indigo),
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _target = getRandomTarget();
                                                    _path =
                                                        calculateMinStepsToGet(
                                                            _target);
                                                    _minStepsCnt = '-'
                                                        .allMatches(_path)
                                                        .length;
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            '/',
                                                            (_) => false);
                                                  },
                                                  child: Text('Play again')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Share.share(
                                                        'I\'ve just won \$$_target in ${'-'.allMatches(_path).length} steps on From02Hero ;)\n\n' +
                                                            'Maybe you can get more, huh?\n\nTry your luck by downloading the game here:\n\nhttps://bit.ly/3IOA0lb',
                                                        subject: 'From02Hero');
                                                  },
                                                  child: Text('Share')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          ));
                                } else if (_minStepsCnt <= 0 &&
                                    _counter != _target) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AlertDialog(
                                            title: Text(
                                              'You run out of steps :(\nToo weak to try again?',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Colors.indigo),
                                            ),
                                            content: Text(
                                              'One way to get \$$_target in ${'-'.allMatches(_path).length} steps is:\n' +
                                                  _path,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.indigo,
                                                  height: 1.5),
                                              textAlign: TextAlign.center,
                                            ),
                                            actionsAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    _target = getRandomTarget();
                                                    _path =
                                                        calculateMinStepsToGet(
                                                            _target);
                                                    _minStepsCnt = '-'
                                                        .allMatches(_path)
                                                        .length;
                                                    Navigator
                                                        .pushNamedAndRemoveUntil(
                                                            context,
                                                            '/',
                                                            (_) => false);
                                                  },
                                                  child: Text('Try again')),
                                              ElevatedButton(
                                                  onPressed: () {
                                                    Navigator.of(ctx).pop();
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          ));
                                }
                              });
                            },
                            child: Text('+1',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                        Padding(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            child: FloatingActionButton.large(
                                onPressed: () {
                                  setState(() {
                                    if (_minStepsCnt > 0) {
                                      _minStepsCnt -= 1;
                                      _counter *= 2;
                                    }
                                    if (_counter == _target) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: Text(
                                                  'Congratulations!\nYou Win \$$_target\n^_^',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.indigo),
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        _target =
                                                            getRandomTarget();
                                                        _path =
                                                            calculateMinStepsToGet(
                                                                _target);
                                                        _minStepsCnt = '-'
                                                            .allMatches(_path)
                                                            .length;
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                                context,
                                                                '/',
                                                                (_) => false);
                                                      },
                                                      child:
                                                          Text('Play again')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Share.share(
                                                            'I\'ve just won \$$_target in ${'-'.allMatches(_path).length} steps on From02Hero ;)\n\n' +
                                                                'Maybe you can get more, huh?\n\nTry your luck by downloading the game here:\n\nhttps://bit.ly/3IOA0lb',
                                                            subject:
                                                                'From02Hero');
                                                      },
                                                      child: Text('Share')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text('Close'))
                                                ],
                                              ));
                                    } else if (_minStepsCnt <= 0 &&
                                        _counter != _target) {
                                      showDialog(
                                          context: context,
                                          builder: (ctx) => AlertDialog(
                                                title: Text(
                                                  'You run out of steps :(\nToo weak to try again?',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      color: Colors.indigo),
                                                ),
                                                content: Text(
                                                  'One way to get \$$_target in ${'-'.allMatches(_path).length} steps is:\n' +
                                                      _path,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.indigo,
                                                      height: 1.5),
                                                  textAlign: TextAlign.center,
                                                ),
                                                actionsAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                actions: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        _target =
                                                            getRandomTarget();
                                                        _path =
                                                            calculateMinStepsToGet(
                                                                _target);
                                                        _minStepsCnt = '-'
                                                            .allMatches(_path)
                                                            .length;
                                                        Navigator
                                                            .pushNamedAndRemoveUntil(
                                                                context,
                                                                '/',
                                                                (_) => false);
                                                      },
                                                      child: Text('Try again')),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      child: Text('Close'))
                                                ],
                                              ));
                                    }
                                  });
                                },
                                child: Text('×2',
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold)))),
                        FloatingActionButton(
                            onPressed: () => setState(() {
                                  if (_minStepsCnt > 0) {
                                    _minStepsCnt -= 1;
                                    _counter -= 1;
                                  }
                                  if (_counter == _target) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text(
                                                'Congratulations!\nYou Win \$$_target\n^_^',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.indigo),
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _target =
                                                          getRandomTarget();
                                                      _path =
                                                          calculateMinStepsToGet(
                                                              _target);
                                                      _minStepsCnt = '-'
                                                          .allMatches(_path)
                                                          .length;
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              '/',
                                                              (_) => false);
                                                    },
                                                    child: Text('Play again')),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('Share')),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Share.share(
                                                          'I\'ve just won \$$_target in ${'-'.allMatches(_path).length} steps on From02Hero ;)\n\n' +
                                                              'Maybe you can get more, huh?\n\nTry your luck by downloading the game here:\n\nhttps://bit.ly/3IOA0lb',
                                                          subject:
                                                              'From02Hero');
                                                    },
                                                    child: Text('Close'))
                                              ],
                                            ));
                                  } else if (_minStepsCnt <= 0 &&
                                      _counter != _target) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text(
                                                'You run out of steps :(\nToo weak to try again?',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    color: Colors.indigo),
                                              ),
                                              content: Text(
                                                'One way to get \$$_target in ${'-'.allMatches(_path).length} steps is:\n' +
                                                    _path,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.indigo,
                                                    height: 1.5),
                                                textAlign: TextAlign.center,
                                              ),
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              actions: <Widget>[
                                                ElevatedButton(
                                                    onPressed: () {
                                                      _target =
                                                          getRandomTarget();
                                                      _path =
                                                          calculateMinStepsToGet(
                                                              _target);
                                                      _minStepsCnt = '-'
                                                          .allMatches(_path)
                                                          .length;
                                                      Navigator
                                                          .pushNamedAndRemoveUntil(
                                                              context,
                                                              '/',
                                                              (_) => false);
                                                    },
                                                    child: Text('Play again')),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('Close'))
                                              ],
                                            ));
                                  }
                                }),
                            child: Text('-1',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold))),
                      ])
                    ])),
              ]),
        ));
  }
}
