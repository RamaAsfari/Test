import 'package:elkood1/bloc/bloc.dart';
import 'package:elkood1/fav_images.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:elkood1/bloc/bloc.dart';
import 'package:elkood1/downloaded_images.dart';
import 'package:elkood1/fav_images.dart';
import 'package:elkood1/model/Images_model.dart';

import 'bloc/imagesModel/images_bloc.dart';
import 'imagePreview.dart';

class TaskOne extends StatefulWidget {
  const TaskOne({Key? key}) : super(key: key);

  @override
  State<TaskOne> createState() => _TaskOneState();
}

class _TaskOneState extends State<TaskOne> {
  final ImagesBloc _newsBloc = ImagesBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getAllImages();
    _newsBloc.add(GetImagesList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Images ',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FavScreen()));
              },
              icon: const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 30,
              )),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ImagesDownloadedScreen()));
            },
            icon: const Icon(Icons.download),
            color: Colors.white,
          )
        ],
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            child: TextField(
              onChanged: (val) async {
                _newsBloc.add(GetSearchImages(value: val));
              },
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                hintText: 'Search..',
                hintStyle: const TextStyle(
                  color: Colors.black,
                ),
                contentPadding: EdgeInsets.zero,
                border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black, width: 3)),
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.6),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 1.6),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
          ),
          Container(
              padding: const EdgeInsets.only(top: 10, left: 5, right: 5),
              child: Center(
                  child: BlocProvider(
                      create: (_) => _newsBloc,
                      lazy: true,
                      child: BlocListener<ImagesBloc, ImagesState>(
                          listener: (context, state) {
                        if (state is ImagesError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message!),
                            ),
                          );
                        }
                      }, child: BlocBuilder<ImagesBloc, ImagesState>(
                              builder: (context, state) {
                        if (state is ImagesInitial) {
                          return _buildLoading();
                        } else if (state is ImagesLoading) {
                          return _buildLoading();
                        } else if (state is ImagesLoaded) {
                          return MyWidget(context, state.imagesModel);
                        } else if (state is ImagesError) {
                          return Container();
                        } else {
                          return Container();
                        }
                      })))))
        ],
      ),
    );
  }

  Center _buildLoading() => Center(
        child: CircularProgressIndicator(),
      );

  GridView MyWidget(BuildContext context, List<ImagesModel> model) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: model == null ? 0 : model.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, mainAxisSpacing: 6, crossAxisSpacing: 6),
      itemBuilder: (context, index) => ImageWidget(
          imageSrc: model[index].urls['regular'], id: model[index].id),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ImageWidget({required String imageSrc, required String id}) {
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ImagePreview(
                        id: id,
                        imageUrl: imageSrc,
                      )));
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  image: NetworkImage(imageSrc), fit: BoxFit.cover)),
        ));
  }
}
