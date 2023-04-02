import 'package:flutter/material.dart';

import 'screens/Productlist.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ankit_Test',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          children: <Widget>[
            ProductList(),
            ProductList(),
            ProductList(),
            ProductList(),
          ],
          // If you want to disable swiping in tab the use below code
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 70,
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              elevation: 10,
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(0.0),
                ),
                child: TabBar(

                  labelColor: Colors.indigo,
                  unselectedLabelColor: Colors.black,
                  labelStyle: TextStyle(fontSize: 10.0),
                  indicator: UnderlineTabIndicator(
                    borderSide: BorderSide(color: Colors.black54, width: 0.0),
                    insets: EdgeInsets.fromLTRB(50.0, 0.0, 50.0, 40.0),
                  ),
                  //For Indicator Show and Customization
                  indicatorColor: Colors.black54,
                  tabs: <Widget>[
                    Tab(
                      icon: Icon(
                        Icons.home,
                        size: 34.0,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.favorite_border_rounded,
                        size: 34.0,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 34.0,
                      ),
                    ),
                    Tab(
                      icon: Icon(
                        Icons.person_outline,
                        size: 34.0,
                      ),
                    ),
                  ],
                  controller: _tabController,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}