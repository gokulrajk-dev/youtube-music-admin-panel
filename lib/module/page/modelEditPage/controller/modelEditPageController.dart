import 'dart:io';

import 'package:basic_fundamental/core/base/base_class.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/album_form.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/artist_form.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/network/Dio_pri_client.dart';
import '../../../../data/registry/model_definition.dart';
import '../../../../data/repo/custom_api.dart';
import '../widgets/forms/definitions/genre_form.dart';
import '../widgets/forms/definitions/song_form.dart';
import '../widgets/forms/widgets/dynamic_form.dart';

class GetModelEditController extends base_controller {
  RxList<dynamic> items = <dynamic>[].obs;
  final ImagePicker picker = ImagePicker();
  final model_details = Rxn<dynamic>();
  final load = false.obs;
  OverlayEntry? overlayEntry;
  Rxn<File> selectedImage = Rxn<File>();
  final dio.Dio dioClient = DioPrivateClient().dio;

  Future<dio.Response?> submit({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    try {
      dio.FormData formData = dio.FormData();

      for (var entry in data.entries) {
        if (entry.value == null) continue;

        if (entry.value is File) {
          formData.files.add(
            MapEntry(
              entry.key,
              await dio.MultipartFile.fromFile(
                entry.value.path,
              ),
            ),
          );
        } else {
          formData.fields.add(
            MapEntry(
              entry.key,
              entry.value.toString(),
            ),
          );
        }
      }

      dio.Response response = await dioClient.post(
        endpoint,
        data: formData,
      );

      print(response.statusCode);
      print(response.data);

      return response;
    } on dio.DioException catch (e) {
      print("Error type: ${e.type}");
      print("Message: ${e.message}");
      print("Error: ${e.error}");
      print("Response: ${e.response?.data}");
      return null;
    }
  }

  Future<void> imagePickers() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  Future<void> loadData(ModelDefinition definition) async {
    try {
      set_loading(true);
      final result = await dynamicApi().getFunction(
        definition.api,
        definition.fromJson,
      );
      items.assignAll(result);
    } catch (e) {
      set_error(e.toString());
    } finally {
      set_loading(false);
    }
  }

  // it suppose to be in the network file

  // Future<Response?> dynamicPostForm(
  //     {required String endpoint, required Map<String, dynamic> data}) async
  // {
  //   try {
  //     FormData formData = FormData();
  //
  //     for (var entry in data.entries) {
  //       if (entry.value == null) continue;
  //       if (entry.value is File) {
  //         formData.files.add(
  //           MapEntry(
  //             entry.key,
  //             await MultipartFile.fromFile(
  //               entry.value.path,
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   } catch (e) {}
  // }

  Future<void> loadDetailData(
      ModelDetailDefinition definition, dynamic item) async {
    load.value = true;
    model_details.value = null;
    try {
      final api = definition.apiBuilder!(item);
      final result = await dynamicApi().getDetailFunction(
        api,
        definition.fromJson,
      );
      model_details.value = result;
    } catch (e) {
      set_error(e.toString());
    } finally {
      load.value = false;
    }
  }

  void dynamicCreateButton(String title) {
    switch (title) {
      case "Artist":
        hideMenu();
        Get.to(
          () => DynamicFormPage(
            title: title,
            fields: artistForm,
          ),
        );

      case "Genre":
        hideMenu();
        Get.to(
          () => DynamicFormPage(
            title: title,
            fields: GenreForm,
          ),
        );

      case "Album":
        hideMenu();
        Get.to(
          () => DynamicFormPage(
            title: title,
            fields: AlbumForm,
          ),
        );

      case "Song":
        hideMenu();
        Get.to(
          () => DynamicFormPage(
            title: title,
            fields: songForm,
          ),
        );
    }
  }

  void showMenu(BuildContext context, VoidCallback ontap) {
    if (overlayEntry != null) return;
    overlayEntry = OverlayEntry(
      builder: (context) => Stack(
        children: [
          // Full screen dismiss layer
          Positioned.fill(
            child: GestureDetector(
              onTap: hideMenu,
              child: Container(color: Colors.transparent),
            ),
          ),

          Positioned(
            top: 50,
            right: 20,
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E1E1E),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
                      child: Text(
                        "Artist",
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    menuItem(Icons.add, "Create", ontap),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );

    Overlay.of(context, rootOverlay: true).insert(overlayEntry!);
  }

  void hideMenu() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  Widget menuItem(IconData icon, String title, VoidCallback ontap,
      {Color color = Colors.white}) {
    return ListTile(
      dense: true,
      leading: Icon(icon, color: color, size: 22),
      title: Text(
        title,
        style: TextStyle(
          color: color,
          fontSize: 15,
        ),
      ),
      onTap: ontap,
    );
  }
}

