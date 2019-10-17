import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pastore_app/CarPage.dart';
import 'package:pastore_app/favorites_database.dart';
import 'package:pastore_app/myflexibleappbar.dart';
import 'package:pastore_app/ui2.dart';
import 'car.dart';
import 'favorite.dart';
import 'firebase_utils.dart';
import 'searchPage.dart';
import 'style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pastore Autoveicoli',
      theme: ThemeData(
          scaffoldBackgroundColor: AppTheme.notWhite,
          canvasColor: AppTheme.notWhite,
          accentColor: AppTheme.orange,
          appBarTheme: new AppBarTheme(color: AppTheme.notWhite),
          primaryColor: AppTheme.orange),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

const kExpandedHeight = 240.0;

class HomeState extends State<Home> {
  FirebaseUtils databaseUtils;
  PageController _pageController;
  var _page = 0;
  List<Car> carList = new List<Car>();

  Query _carQuery;

  StreamSubscription<Event> _onAddedSubscription;
  StreamSubscription<Event> _onChangedSubscription;

  MyDatabase myDatabase;

  @override
  void initState() {
    databaseUtils = new FirebaseUtils();
    databaseUtils.initState();
    _pageController = PageController();

    _carQuery = databaseUtils.getRef();
    _onAddedSubscription = _carQuery.onChildAdded.listen(_onEntryAdded);
    _onChangedSubscription = _carQuery.onChildChanged.listen(_onEntryChanged);

    // _scrollController = ScrollController()..addListener(() => setState(() {}));

    myDatabase = MyDatabase();

    super.initState();
  }

  @override
  void dispose() {
    databaseUtils.dispose();
    _pageController.dispose();

    _onAddedSubscription.cancel();
    _onChangedSubscription.cancel();
    super.dispose();
  }

  void navigationTapped(int page) {
    _pageController.animateToPage(
      page,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  _onEntryChanged(Event event) {
    var oldEntry = carList.singleWhere((entry) {
      print(entry.key);
      print(event.snapshot.key);
      return entry.key == event.snapshot.key;
    });

    setState(() {
      carList[carList.indexOf(oldEntry)] = Car.fromSnapshot(event.snapshot);
    });
  }

  _onEntryAdded(Event event) {
    setState(() {
      carList.add(Car.fromSnapshot(event.snapshot));
    });
  }

  Widget _showListView() {
    if (carList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: carList.length,
          itemBuilder: (BuildContext context, int index) {
            return HomePageUi(carList[index], myDatabase);
          });
    } else {
      return new Center(
          child:
              CircularProgressIndicator() //new Text("Nessun veicolo presente"),
          );
    }
  }
/*
  ScrollController _scrollController;

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - kToolbarHeight;
  }
  */
/*
  Widget _silverList() {
    if (carList.length > 0) {
/*      return SliverList(
          delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return HomePageUi(carList[index]);
        },
        childCount: carList.length,
      ));
      */

      return SliverFillRemaining(
        child: _showListView(),
      );
    } else {
      return new Center(child: CircularProgressIndicator());
    }
  }
*/
/*
  Widget _showList() {
    return new CustomScrollView(
//      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          elevation: 0.0,
          expandedHeight: kExpandedHeight,
  //        floating: false,
   //       pinned: true,
     //     title: MyFlexiableAppBar(),//_showTitle ? MyAppBar() : null,
          //bottom: PreferredSize(preferredSize: Size(10.0,10.0),child: Text(''),),
          flexibleSpace: /*_showTitle
              ? null
              : */FlexibleSpaceBar(background: MyFlexiableAppBar()),
        ),
        _silverList(),
      ],
    );
  }
*/

  Widget _showList() {
    return new SafeArea(
      child: Column(
        children: <Widget>[
          new Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              width: MediaQuery.of(context).size.width,
              height: kExpandedHeight,
              child: MyFlexiableAppBar()),
          new Expanded(child: _showListView())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _myPages = [
      _showList(),
      Container(),
      FavoritesScreen(carList, myDatabase)
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppTheme.darkerBlue,
        fixedColor: AppTheme.orangeText,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: navigationTapped,
        currentIndex: _page,
        items: [
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.home)),
          new BottomNavigationBarItem(
              title: new Text(''),
              icon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () async {
                  final Car searchRes = await showSearch<Car>(
                      context: context, delegate: searchPage(carList));
                  if (searchRes != null)
                    Navigator.of(context).push(new PageRouteBuilder(
                        pageBuilder: (_, __, ___) =>
                            new CarPage(searchRes, myDatabase)));
                },
              )),
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.favorite_border))
        ],
      ),
      body: new PageView.builder(
          controller: _pageController,
          onPageChanged: onPageChanged,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemCount: _myPages.length,
          itemBuilder: (BuildContext context, int position) =>
              _myPages[position]),
    );
  }
}
