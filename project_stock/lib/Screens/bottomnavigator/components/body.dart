import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_stock/Screens/cart/cart_screen.dart';
import 'package:project_stock/Screens/history/history_screen.dart';
import 'package:project_stock/Screens/login/login_screen.dart';
import 'package:project_stock/Screens/sell/sell_product_screen.dart';
import 'package:project_stock/Screens/stock/stock_screen.dart';
import 'package:project_stock/Service/service.dart';
import 'package:project_stock/constants.dart';

class Body extends StatefulWidget {
  int? index = 0;
  Body({Key? key, this.index}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    if (widget.index != null) {
      header = widget.index!;
    }
    // header = widget.index!;
    // TODO: implement initState
    super.initState();
  }

  int header = 0;
  int currentIndex = 0;
  final screens = [StockPage(), History_Page(),
   //Container()
   ];
  final unSelectedIcon = [
    Icon(
      Icons.add_business_outlined,
    ),
    Icon(
      Icons.folder_outlined,
    ),
    // Icon(
    //   Icons.settings_outlined,
    // ),
  ];
  final SelectedIcon = [
    Icon(
      Icons.add_business,
      size: 40,
    ),
    Icon(Icons.folder, size: 40),
    // Icon(Icons.settings, size: 40),
  ];
  final titleScreen = [
    Text(
      "YOUR STOCKIE",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "LEMONMILKBOLD",
          fontSize: 25,
          fontWeight: FontWeight.bold),
    ),
    Text(
      "HISTORY",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.black,
          fontFamily: "LEMONMILKBOLD",
          fontSize: 25,
          fontWeight: FontWeight.bold),
    ),
    // Text(
    //   "YOUR STOCKIE",
    //   style: TextStyle(
    //       color: Colors.black,
    //       fontFamily: "LEMONMILKBOLD",
    //       fontSize: 25,
    //       fontWeight: FontWeight.bold),
    // ),
    // Text(
    //   "SELL",
    //   style: TextStyle(
    //       color: Colors.black,
    //       fontFamily: "LEMONMILKBOLD",
    //       fontSize: 25,
    //       fontWeight: FontWeight.bold),
    // )
  ];
  changePage() {
    if (header == 0) {
      return screens[currentIndex];
    } else {
      return CartPage();
    }
  }

  changeTitle() {
    if (header == 0) {
      return titleScreen[currentIndex];
    } else {
      return Text(
        "Cart",
        style: TextStyle(
            color: Colors.black,
            fontFamily: "LEMONMILKBOLD",
            fontSize: 25,
            fontWeight: FontWeight.bold),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: changeTitle(),
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.black,
              size: 40,
            ),
            padding: EdgeInsets.only(left: (30.0)),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    header = 1;
                  });
                },
                icon: Icon(
                  Icons.shopping_bag,
                  color: Colors.black,
                )),
            IconButton(
                onPressed: () {
                  DatabaseService().signout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                icon: Icon(
                  Icons.logout_outlined,
                  color: Colors.black,
                )),
          ],
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: changePage(),
        // length: 4,
        // child: Scaffold(
        //     body: TabBarView(children: [
        //       StockPage(),
        //       Container(),
        //       Container(),
        //       Container(),
        //     ]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              setState(() {
                currentIndex = index;
                header = 0;
              });
            },
            selectedItemColor: Color(0XFF242844),
            iconSize: 30,
            unselectedItemColor: bottomNavColor,
            // showUnselectedLabels: true,
            selectedLabelStyle: TextStyle(color: (bottomNavColor)),
            items: [
              BottomNavigationBarItem(
                icon: unSelectedIcon[0],
                activeIcon: SelectedIcon[0],
                label: "Stock and Sell",
              ),
              BottomNavigationBarItem(
                icon: unSelectedIcon[1],
                activeIcon: SelectedIcon[1],
                label: "History",
              ),
              // BottomNavigationBarItem(
              //   icon: unSelectedIcon[2],
              //   activeIcon: SelectedIcon[2],
              //   label: "Setting",
              // ),
            ],
          ),
        )); //);
  }
}
