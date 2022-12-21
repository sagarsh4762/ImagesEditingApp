// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/Provider/favorite_provider.dart';
import 'package:wallpaper_app/view/details_page.dart';

import '../model/Item.dart';
import '../widgets/customAppBar.dart';

class LikedPage extends StatefulWidget {
  const LikedPage({super.key});

  @override
  State<LikedPage> createState() => _LikedPageState();
}

class _LikedPageState extends State<LikedPage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FavouriteProvider>(context);
    List<Item> dataItems = provider.itemsid;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: CustomAppBar(),
      ),
      body: SingleChildScrollView(
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
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 13,
                    mainAxisExtent: 250,
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
                              padding:
                                  const EdgeInsets.only(top: 10, bottom: 50),
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
                                    // fit: BoxFit.cover,
                                    fit: BoxFit.fill,
                                    dataItems[index].images),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              bottom: 0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 18, horizontal: 5),
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
                  }),
            )
          ],
        ),
      ),
    );
  }
}
