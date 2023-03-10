// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Provider/favorite_provider.dart';
import 'package:wallpaper_app/view/details_page.dart';

import 'package:wallpaper_app/widgets/customAppBar.dart';

import '../model/Item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Item> dataItems = [];
  var isLoaded = true;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('images')
        .snapshots()
        .listen((records) {
      mapRecords(records);
    });
    fetchRecords();
  }

  fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('images').get();
    mapRecords(records);
  }

  mapRecords(QuerySnapshot<Map<String, dynamic>> records) {
    var list = records.docs
        .map(
          (item) => Item(
            id: item.id,
            images: item['images'],
            name: item['name'],
            price: item['price'],
          ),
        )
        .toList();
    setState(() {
      dataItems = list;
      isLoaded = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  // Container(
                  //     padding: const EdgeInsets.symmetric(horizontal: 10),
                  //     child: const SearchBar()),
                  // Container(
                  //   margin: const EdgeInsets.symmetric(vertical: 20),
                  //   child: SizedBox(
                  //     height: 50,
                  //     width: MediaQuery.of(context).size.width,
                  //     child: ListView.builder(
                  //         scrollDirection: Axis.horizontal,
                  //         itemCount: 30,
                  //         itemBuilder: (context, index) {
                  //           return const CategoryBlock();
                  //         }),
                  //   ),
                  // ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: dataItems.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 13,
                        mainAxisExtent: 300,
                      ),
                      itemBuilder: (context, index) {
                        final url = dataItems[index];
                        return Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => DetailsPage(
                                        url: url,
                                      )));
                            },
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 50),
                                  height: 800,
                                  width: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(
                                      height: 400,
                                      width:
                                          MediaQuery.of(context).size.width / 2,
                                      fit: BoxFit.fill,
                                      dataItems[index].images,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  bottom: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    child: Text(
                                      dataItems[index].name,
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 3),
                                    child: IconButton(
                                      icon: provider.isExist(dataItems[index])
                                          ? const Icon(
                                              Icons.favorite,
                                              color: Colors.red,
                                            )
                                          : const Icon(Icons.favorite_border),
                                      onPressed: (() {
                                        provider
                                            .toggleFavorite(dataItems[index]);
                                      }),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
