import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final words = WordPair.random();

    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
          backgroundColor: Color.fromARGB(255, 255, 0, 0),
        ),
        body: Center(
//          child: Text(words.asPascalCase),
          child: RandomWords(),
        ),
      ),
    );
  }
}

class RandomWords extends StatefulWidget {
  //单行函数， 可以使用 => 来简写
  @override
  State<StatefulWidget> createState() => new RandomWordsState();
}

/// 两个类：
///   StateFul Widget 状态可变
///   Stateless Widget 状态不可变
///   实现一个 stateful widget 至少需要两个类：1）一个 StatefulWidget 类；2）一个 State 类
class RandomWordsState extends State<RandomWords> {
  @override
  Widget build(BuildContext context) {
    final WordPair pair = WordPair.random();
    return new Text(pair.asPascalCase);
  }
}
