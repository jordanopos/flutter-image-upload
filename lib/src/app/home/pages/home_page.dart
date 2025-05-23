import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_picker/src/app/home/bloc/home_bloc.dart';
import 'package:flutter_image_picker/src/meta/constants.dart';
import 'package:flutter_image_picker/src/meta/widgets/dashed-border.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeBloc? homeBloc;

  @override
  void initState() {
    homeBloc = context.read<HomeBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            actions: [
              Text(
                "Skip for now",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppConstants.mainColor,
                ),
              ),
              SizedBox(width: 20),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload ID",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Upload a photo of yourself holding your valid ID for verification",
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  child: DashedBorderBox(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey[300]!,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                          if (state is HomeLoaded) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,

                                children: [
                                  SizedBox(height: 24),

                                  CircleAvatar(
                                    backgroundColor: Colors.green,
                                    child: Center(
                                      child: Icon(
                                        Icons.done,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 16),

                                  Text("Upload Complete"),

                                  SizedBox(height: 16),

                                  SizedBox(
                                    height: 300,
                                    width: double.infinity,
                                    child: Image.file(
                                      File(state.file!.path),
                                      fit: BoxFit.cover,
                                    ),
                                  ),

                                  SizedBox(height: 16),

                                  GestureDetector(
                                    onTap: () => homeBloc!.add(RemoveFile()),
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete_rounded),

                                          Text("Clear Upload"),
                                        ],
                                      ),
                                    ),
                                  ),

                                  SizedBox(height: 24),
                                ],
                              ),
                            );
                          }

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 24),

                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.grey[200],
                                child: Center(
                                  child: Icon(
                                    Icons.cloud_upload_rounded,
                                    color: AppConstants.mainColor,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8),

                              GestureDetector(
                                onTap:
                                    () => homeBloc!.add(
                                      PickFile(ImageSource.gallery),
                                    ),
                                child: Text(
                                  "Tap to Upload Photo",
                                  style: TextStyle(
                                    color: AppConstants.mainColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),

                              Text("PNG, JPG or PDF (max 800x400px)"),

                              SizedBox(height: 24),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24.0,
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey,
                                        height: .5,
                                        child: Text(""),
                                      ),
                                    ),
                                    SizedBox(width: 4),

                                    Text("OR"),
                                    SizedBox(width: 4),
                                    Expanded(
                                      child: Container(
                                        color: Colors.grey,
                                        height: .5,
                                        child: Text(""),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 24),

                              GestureDetector(
                                onTap:
                                    () => homeBloc!.add(
                                      PickFile(ImageSource.camera),
                                    ),

                                child: Container(
                                  width: 130,
                                  height: 39,
                                  decoration: BoxDecoration(
                                    color: AppConstants.mainColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),

                                  child: Center(
                                    child: Text(
                                      "Open Camera",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ),

                Spacer(),

                Container(color: AppConstants.mainColor),

                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    bool uploaded = state is HomeLoaded;
                    return Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                        color:
                            uploaded
                                ? AppConstants.mainColor
                                : Color(0xffafceff),
                        borderRadius: BorderRadius.circular(5),
                      ),

                      child: Center(
                        child: Text(
                          "Upload ID",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
