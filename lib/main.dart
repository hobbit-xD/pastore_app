//import 'dart:io';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
//import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:pastore_app/CarPage.dart';
import 'package:pastore_app/ui.dart';
import 'car.dart';
import 'favorite.dart';
import 'firebase_utils.dart';
//import 'package:camera/camera.dart';
//import 'package:path_provider/path_provider.dart';
import 'searchPage.dart';
import 'style.dart';

//List<CameraDescription> cameras;
/*
Future<void> main() async {
  cameras = await availableCameras();
  runApp(MyApp());
}
*/
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
          accentColor: AppTheme.blue,
          appBarTheme: new AppBarTheme(color: AppTheme.notWhite),
          primaryColor: AppTheme.blue),
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  HomeState createState() => new HomeState();
}

class HomeState extends State<Home> {
  bool _anchorToBottom = false;
  FirebaseUtils databaseUtils;
  PageController _pageController;
  var _page = 0;
  //CameraController _controller;
  List<Car> carList = new List<Car>();

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  Query _carQuery;

  StreamSubscription<Event> _onAddedSubscription;
  StreamSubscription<Event> _onChangedSubscription;

  UniqueKey _keyPageView = new UniqueKey();
  @override
  void initState() {
    databaseUtils = new FirebaseUtils();
    databaseUtils.initState();
    _pageController = PageController();

    _carQuery = databaseUtils.getRef();
    _onAddedSubscription = _carQuery.onChildAdded.listen(_onEntryAdded);
   // _onChangedSubscription = _carQuery.onChildChanged.listen(_onEntryChanged);

/*
    _controller = CameraController(cameras[0], ResolutionPreset.medium);
    _controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
*/
    super.initState();
  }

  @override
  void dispose() {
    databaseUtils.dispose();
    _pageController.dispose();
//    _controller.dispose();

    _onAddedSubscription.cancel();
    _onChangedSubscription.cancel();
    super.dispose();
  }

/*
  void _takePicturePressed() {
    _takePicture().then((String filePath) {
      if (mounted) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ImageDetail(filePath)));
      }
    });
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  Future<String> _takePicture() async {
    if (!_controller.value.isInitialized) {
      print("Controller is not initialized");
      return null;
    }

    final Directory exDir = await getApplicationDocumentsDirectory();
    final String photoDir = '${exDir.path}/Photos/image_test';
    await Directory(photoDir).create(recursive: true);
    final String filePath = '$photoDir/${timestamp()}.jpg';

    if (_controller.value.isTakingPicture) {
      print("Already taking picture");
      return null;
    }

    try {
      await _controller.takePicture(filePath);
    } on CameraException catch (e) {
      print("Camera exception occured: $e");
      return null;
    }

    return filePath;
  }
*/
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

 /* _onEntryChanged(Event event) {
    var oldEntry = carList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      carList[carList.indexOf(oldEntry)] = Car.fromSnapshot(event.snapshot);
    });
  }

  */
  _onEntryAdded(Event event) {
    setState(() {
      carList.add(Car.fromSnapshot(event.snapshot));
    });
  }

  Widget _showList() {
    if (carList.length > 0) {
      return new ListView.builder(
          shrinkWrap: true,
          itemCount: carList.length,
          itemBuilder: (BuildContext context, int index) {
            return new Column(
              children: <Widget>[
                new HomeUI(carList[index]),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
/*
    Widget camera = new Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: CameraPreview(_controller),
        ),
        new Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: RaisedButton.icon(
              icon: Icon(Icons.camera),
              label: new Text("Take Picture"),
              onPressed: _takePicturePressed,
            ),
          ),
        )
      ],
    );
*/

    return Scaffold(
      //backgroundColor: new Color(0xFF4a6575),

      appBar: new AppBar(
        elevation: 0.0,
      ),
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
                        pageBuilder: (_, __, ___) => new CarPage(searchRes)));
                },
              )),
          new BottomNavigationBarItem(
              title: new Text(''), icon: new Icon(Icons.bookmark_border)),
        ],
      ),
      body: new PageView(
        key: _keyPageView,
        scrollDirection: Axis.horizontal,
        pageSnapping: false,
        controller: _pageController,
        physics: BouncingScrollPhysics(),
        onPageChanged: onPageChanged,
        children: <Widget>[
          /*   new FirebaseAnimatedList(
            key: new ValueKey<bool>(_anchorToBottom),
            query: databaseUtils.getRef(),
            reverse: _anchorToBottom,
            sort: _anchorToBottom
                ? (DataSnapshot a, DataSnapshot b) => b.key.compareTo(a.key)
                : null,
            itemBuilder: (BuildContext context, DataSnapshot snapshot,
                Animation<double> animation, int index) {
              return new SizeTransition(
                sizeFactor: animation,
                child: displayCar(snapshot),
              );
            },
          ),*/
          _showList(),
          //camera,
          new Container(),
          new FavoritesScreen(carList),
        ],
      ),
    );
  }
/*
  Widget displayCar(DataSnapshot snapshot) {
    Car car = Car.fromSnapshot(snapshot);
    return new HomeUI(car);
  }
  */

}
