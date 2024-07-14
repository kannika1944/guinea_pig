import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:guinea_pig/config/app.dart';
import 'package:guinea_pig/screen/page_detail_screen.dart';
import 'package:guinea_pig/screen/post_detai_screen.dart';
import 'package:guinea_pig/services/Page_Service.dart';
import 'package:guinea_pig/services/auth_service.dart';
import 'package:guinea_pig/services/banner_service.dart';
import 'package:guinea_pig/services/post_service.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> pictures = [];
  List<dynamic> paged = [];
  List<dynamic> Posts = [];

  // Future<void> getpictures() async {
  //   final response = await http.get(Uri.parse('${API_URL}/api/banners'));
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     for (final picture in data) {
  //       print(picture['imageUrl']);
  //       setState(() {
  //         pictures.add(picture['imageUrl']);
  //       });
  //     }
  //   }
  // }

  Future<void> getPosts() async {
    final response = await PostService().fetchPosts();
    setState(() {
      Posts = response;
    });
  }

  Future<void> getpaged() async {
    // final response = await http.get(Uri.parse('${API_URL}/api/pages'));
    // if (response.statusCode == 200) {
    //   final data = jsonDecode(response.body);
    //   for (final page in data) {
    //     print(page['title']);
    //     setState(() {
    //       paged.add(page['title']);
    //     });
    //   }
    // }

    try {
      List<dynamic> data = await PageService.fetchPages();
      setState(() {
        paged = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    BannerService().fetchBanners().then((value) {
      setState(() {
        pictures = value;
      });
    });
    // print(pictures);
    getpaged();
    getPosts();
    print(Posts.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Drawer Header'),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: paged.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(paged[index]['title']),
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PageDetailScreen(id: paged[index]['id']);
                    }));
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 300,
              child: Swiper(
                itemCount: pictures.length,
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    "${API_URL}/${pictures[index]['imageUrl']}",
                    fit: BoxFit.fill,
                  );
                },
                pagination: SwiperPagination(),
                control: SwiperControl(),
              ),
            ),
            Expanded(
              // child: ListView.builder(
              //   itemCount: paged.length,
              //   itemBuilder: (context, index) {
              //     return ListTile(
              //       title: Row(
              //         children: [
              //           Image.asset("/images/t.gif", width: 100, height: 100),
              //           Text(paged[index]['title']),
              //         ],
              //       ),
              //       onTap: () {
              //         Navigator.of(context)
              //             .push(MaterialPageRoute(builder: (context) {
              //           return PageDetailScreen(id: paged[index]['id']);
              //         }));
              //       },
              //     );
              //   },
              // ),
              child: ListView.builder(
                itemCount: Posts.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Row(
                      children: [
                        Image.asset("/images/t.png", width: 100, height: 100),
                        Text(Posts[index]['title']),
                      ],
                    ),
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return PostDetaiScreen(id: Posts[index]['id']);
                      }));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
