import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final words = WordPair.random();

    return MaterialApp(
      title: 'Welcome to Flutter',

      home: new RandomWords(),

//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Welcome to Flutter'),
//          backgroundColor: Color.fromARGB(255, 255, 0, 0),
//        ),
//        body: Center(
////          child: Text(words.asPascalCase),
//          child: RandomWords(),
//        ),
//      ),
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
  //下划线开头变量代表私有 变量
  final List<WordPair> _pairs = <WordPair>[];

  //字体格式
  final TextStyle _textStyle = const TextStyle(fontSize: 18.0);

  //定义一个函数，构建出一个ListView
  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0), //内边距 padding
      itemBuilder: (BuildContext _context, int i) {
        if (i.isOdd) {
          return new Divider();
        }

        final index = i ~/ 2;
        if (index >= _pairs.length) {
          _pairs.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_pairs[index]);
      },
    );
  }

  Widget _buildRow(WordPair word) {
    return new ListTile(title: Text(word.asPascalCase, style: _textStyle));
  }

  @override
  Widget build(BuildContext context) {
//    final WordPair pair = WordPair.random();
//    return new Text(pair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("随机生成单词"),
      ),
      body: _buildListView(),
    );
  }
}
