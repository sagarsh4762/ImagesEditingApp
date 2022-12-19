// ignore_for_file: sized_box_for_whitespace, unused_element, avoid_unnecessary_containers

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Provider/favorite_provider.dart';
import 'package:wallpaper_app/view/details_page.dart';
import 'package:wallpaper_app/widgets/customAppBar.dart';

import '../model/Item.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Item> dataItems = [];
  final TextEditingController _controller = TextEditingController();
  String query = "";
  var isLoaded = false;

  @override
  void initState() {
    super.initState();

    fetchRecords(query);
  }

  fetchRecords(String query) async {
    var records = await FirebaseFirestore.instance
        .collection('images')
        .where('name', isEqualTo: query)
        .get();
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
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(66, 184, 182, 182),
                border:
                    Border.all(color: const Color.fromARGB(95, 110, 110, 110)),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: "Search Images",
                        errorBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      query = _controller.text;
                      fetchRecords(query);
                      isLoaded = true;
                    },
                    child: const Icon(Icons.search),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Visibility(
              visible: isLoaded,
              replacement: const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  "Search Images By Name From Above SearchBar",
                  style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.bold,
                      color: Colors.black54),
                ),
              ),
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: dataItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 13,
                  mainAxisSpacing: 10,
                  mainAxisExtent: 400,
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
                            padding: const EdgeInsets.only(top: 10, bottom: 50),
                            height: 800,
                            width: MediaQuery.of(context).size.width / 2,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                height: 400,
                                width: MediaQuery.of(context).size.width / 2,
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
                                  vertical: 2, horizontal: 2),
                              child: IconButton(
                                icon: provider.isExist(dataItems[index])
                                    ? const Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : const Icon(Icons.favorite_border),
                                onPressed: (() {
                                  provider.toggleFavorite(dataItems[index]);
                                }),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
