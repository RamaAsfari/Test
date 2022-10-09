import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImagePreview extends StatefulWidget {
  final String imageUrl;
  final String id;

  const ImagePreview({super.key, required this.imageUrl, required this.id});

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(30), topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            child: BottomNavigationBar(
              selectedItemColor: Colors.grey,
              selectedLabelStyle: const TextStyle(color: Colors.grey),
              unselectedLabelStyle: const TextStyle(color: Colors.grey),
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: IconButton(
                      icon: Icon(Icons.save_alt_outlined),
                      onPressed: () async {
                        try {
                          // Saved with this method.
                          var imageId = await ImageDownloader.downloadImage(
                            widget.imageUrl,
                            destination: AndroidDestinationType.directoryDCIM,
                          );

                          if (imageId == null) {
                            return;
                          }

                          // Below is a method of obtaining saved image information.
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Image Saved Succeesfully!'),
                            ),
                          );
                          await AddImagesToDownloads(widget.id);
                        } on PlatformException catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(error.toString()),
                            ),
                          );
                        }
                      },
                    ),
                    label: 'Save'),
                BottomNavigationBarItem(
                    label: 'Favourite',
                    icon: IconButton(
                      onPressed: () async {
                        await addImageToFavourate(widget.id);
                      },
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.grey,
                      ),
                    ))
              ],
            ),
          )),
      appBar: AppBar(elevation: 0, backgroundColor: Colors.transparent),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
              image: NetworkImage(
                widget.imageUrl,
              ),
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  addImageToFavourate(id) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    List<String> array = prefs.getStringList('fav') ?? [];
    array.add(id);
    var seen = Set<String>();
    final uniqe = array.where((item) => seen.add(item)).toList();
    prefs.setStringList('fav', uniqe);
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('AddedTo Favourates !')));
  }

  AddImagesToDownloads(id) async {
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;
    List<String> array = prefs.getStringList('downloaded') ?? [];
    array.add(id);
    var seen = Set<String>();
    final uniqe = array.where((item) => seen.add(item)).toList();
    prefs.setStringList('downloaded', uniqe);
  }
}
