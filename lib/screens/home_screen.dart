import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
            canvasColor: Theme.of(context).primaryColor,
            primaryColor: Colors.white,
            textTheme: Theme.of(context)
                .textTheme
                .copyWith(caption: TextStyle(color: Colors.white54))),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p) {
            _pageController.animateToPage(p,
                duration: Duration(microseconds: 700), curve: Curves.ease);
          },
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.person), title: Text("Clientes")),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), title: Text("Pedidos")),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), title: Text("Produtos")),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: (p){
          setState(() {
            _page = p;
          });
        },
        controller: _pageController,
        children: [
          Container(
            color: Colors.white,
          ),
          Container(
            color: Colors.red,
          ),
          Container(color: Colors.green),
        ],
      ),
    );
  }
}
