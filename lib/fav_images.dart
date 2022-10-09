import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'bloc/bloc.dart';
import 'bloc/imagesModel/images_bloc.dart';
import 'imagePreview.dart';
import 'model/Images_model.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({Key? key}) : super(key: key);

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  @override
  var images = [];

  final ImagesBloc _newsBloc = ImagesBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _newsBloc.add(FavImages());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Favorates  ',
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
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
