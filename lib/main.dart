import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final words = WordPair.random();

    return MaterialApp(
      title: 'Welcome to Flutter',
      theme: new ThemeData(primaryColor: Colors.black),
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

  //使用Set集合是因为  Set 相比 List 不允许重复的值
  final Set<WordPair> _savedWords = new Set<WordPair>();

  //定义一个函数，构建出一个ListView
  Widget _buildListView() {
    return ListView.builder(
      padding: const EdgeInsets.all(1.0), //内边距 padding
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
    //是否已经存储在了Saved集合里面
    final bool isSaved = _savedWords.contains(word);

    return new ListTile(
      title: Text(word.asPascalCase, style: _textStyle),

      //增加了一个图标在尾部
      trailing: new Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),

      onTap: () {
        setState(() {
          if (isSaved) {
            _savedWords.remove(word);
          } else {
            _savedWords.add(word);
          }
        });
      },
    );
  }

  void _pushSaved() {
    Navigator
        .of(context)
        .push(new MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = _savedWords.map((WordPair pair) {
        return new ListTile(
          title: new Text(
            pair.asPascalCase,
            style: _textStyle,
          ),
        );
      });
      final List<Widget> divided = ListTile
          .divideTiles(
            context: context,
            tiles: tiles,
          )
          .toList();

      return new Scaffold(
        // 新增 6 行代码开始 ...
        appBar: new AppBar(
          title: const Text('Saved Suggestions'),
        ),
        body: new ListView(children: divided),
      ); // ... 新增代码段结束.
    }));
  }

  @override
  Widget build(BuildContext context) {
//    final WordPair pair = WordPair.random();
//    return new Text(pair.asPascalCase);

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("随机生成单词"),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved)
        ],
      ),
      body: _buildListView(),
    );
  }
}
