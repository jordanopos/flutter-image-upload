import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_picker/src/app/home/bloc/home_bloc.dart';
import 'package:flutter_image_picker/src/app/home/pages/home_page.dart';
import 'package:flutter_image_picker/src/app/home/repository/home_repository.dart';

void main() {
  runApp(ImagePickerApp());
}

class ImagePickerApp extends StatelessWidget {
  const ImagePickerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(HomeImpl()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "CircularStd"),
        home: HomePage(),
      ),
    );
  }
}
