// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print, unnecessary_import, prefer_final_fields
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grid Selection App',
      home: GridSelectionScreen(),
    );
  }
}

class GridSelectionScreen extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _GridSelectionScreenState createState() => _GridSelectionScreenState();
}

class _GridSelectionScreenState extends State<GridSelectionScreen> {
  final List<String> items = [
    'Cyber Bullying',
    'Ransomware',
    'Credit Card Scam',
    'Identity theft',
    'Test',
    'test1',
    'test4',
    'test'
  ];

  final List<IconData> icons = [
    Icons.security,
    Icons.lock_outline,
    Icons.credit_card,
    Icons.person_outline,
    Icons.help_outline,
    Icons.help_outline,
    Icons.help_outline,
    Icons.help_outline,
  ];

  ScrollController _scrollController = ScrollController();
  bool _showFooter = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _showFooter = false;
        });
      } else if (_scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _showFooter = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: EdgeInsets.only(top: 8),
          child: AppBar(
            backgroundColor: Colors.lightBlue[100],
            elevation: 0,
            title: Icon(Icons.shield, size: 40, color: Colors.blue),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.menu, size: 30),
              onPressed: () {
                // Handle sidebar menu button press
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.account_circle, size: 30),
                onPressed: () {
                  // Handle profile button press
                },
              ),
            ],
          ),
        ),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (scrollNotification is ScrollStartNotification) {
            setState(() {
              _showFooter = false;
            });
          } else if (scrollNotification is ScrollEndNotification) {
            setState(() {
              _showFooter = true;
            });
          }
          return true;
        },
        child: Column(
          children: [
            SizedBox(height: 0), // Adjust space below AppBar
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Text(
                    'Cyber Security',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Learn how to protect yourself',
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Neumorphic(
              style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.roundRect(
                  BorderRadius.circular(10),
                ),
                depth: 4,
                intensity: 0.6,
                color: Colors.grey[300]!,
                shadowLightColor: Colors.white,
                shadowDarkColor: Colors.grey[500]!,
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
          ),
          Text(
            'Discover Our Topics',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(9),
              child: GridView.count(
                controller: _scrollController,
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 9,
                mainAxisSpacing: 9,
                children: List.generate(items.length, (index) {
                  return Neumorphic(
                    style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.roundRect(
                        BorderRadius.circular(40),
                      ),
                      depth: 4,
                      intensity: 0.6,
                      color: Colors.grey[300]!,
                      shadowLightColor: Colors.white,
                      shadowDarkColor: Colors.grey[500]!,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        print('Selected: ${items[index]}');
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            size: 40,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            items[index],
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          if (_showFooter)
              Neumorphic(
                style: NeumorphicStyle(
                  boxShape: NeumorphicBoxShape.roundRect(
                    BorderRadius.circular(10),
                  ),
                  depth: 4,
                  intensity: 0.6,
                  color: Colors.grey[300]!,
                  shadowLightColor: Colors.white,
                  shadowDarkColor: Colors.grey[500]!,
                ),
         child: Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            color: Colors.grey[200]!,
            child: Center(
              child: Text(
                'Dummy Footer Text',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}