// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, dynamic> data = {
    'Мои фото': [
      'https://picsum.photos/1200/501',
      'https://picsum.photos/1200/502',
      'https://picsum.photos/1200/503',
      'https://picsum.photos/1200/504',
      'https://picsum.photos/1200/505',
      'https://picsum.photos/1200/506',
      'https://picsum.photos/1200/507',
      'https://picsum.photos/1200/508',
      'https://picsum.photos/1200/509',
      'https://picsum.photos/1200/510',
    ],
    'Галерея': [
      'https://picsum.photos/1200/511',
      'https://picsum.photos/1200/512',
      'https://picsum.photos/1200/513',
      'https://picsum.photos/1200/514',
      'https://picsum.photos/1200/515',
      'https://picsum.photos/1200/516',
      'https://picsum.photos/1200/517',
      'https://picsum.photos/1200/518',
      'https://picsum.photos/1200/519',
      'https://picsum.photos/1200/520',
    ]
  };

  final List<String> nav = ['Мои фото', 'Галерея'];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: data.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Scrolling Tabs'),
          bottom: TabBar(
              tabs: nav.map((item) => Tab(text: item)).toList()),
        ),
        body: TabBarView(
          children: [
            TabPage(
              data: data,
              mapKey: 0,
              pageStorageKey: PageStorageKey(nav[0]),
            ),
            TabPage(
              data: data,
              mapKey: 1,
              pageStorageKey: PageStorageKey(nav[1]),
            )
          ],
        ),
      ),
    );
  }
}

class TabPage extends StatelessWidget {
  final data;
  final mapKey;
  final pageStorageKey;

  const TabPage({Key? key, this.data, this.mapKey, this.pageStorageKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tabCategories = data.keys.toList();
    final dataKey = tabCategories[mapKey];
    return ListView.builder(
      key: pageStorageKey,
      itemCount: data[dataKey].length,
      itemBuilder: (context, index) => SizedBox(
        height: 120,
        child: Image.network(data[dataKey][index], fit: BoxFit.fill,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        }),
      ),
    );
  }
}
