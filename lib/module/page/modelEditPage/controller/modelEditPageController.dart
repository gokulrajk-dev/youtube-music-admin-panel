import 'dart:io';

import 'package:basic_fundamental/core/base/base_class.dart';
import 'package:basic_fundamental/core/network/ApiEndpoint.dart';
import 'package:basic_fundamental/data/data_model/album_module.dart';
import 'package:basic_fundamental/data/data_model/artist.dart';
import 'package:basic_fundamental/data/data_model/genre.dart';
import 'package:basic_fundamental/data/data_model/song_module.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/album_form.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/artist_form.dart';
import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/definitions/mediaasset_form.dart';
import 'package:dio/dio.dart' as dio;
import 'package:file_picker/file_picker.dart';
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
  final RxList<Genre> GenreList = <Genre>[].obs;
  final RxList<int> genre_id = <int>[].obs;
  final RxList<Artist> artistList = <Artist>[].obs;
  final RxList<int> artist_id = <int>[].obs;
  final RxList<Album> albumList = <Album>[].obs;
  final song_id = 1.obs;
  final RxList<Song> songList = <Song>[].obs;
  final album_id = 1.obs;
  final Rxn soundtrack = Rxn();

  Future<void> getGenreDetails() async {
    try {
      final result = await dynamicApi().getFunction(
        ApiEndpoint.genre,
        Genre.fromJson,
      );

      GenreList.assignAll(
        result.cast<Genre>(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> getSongDetails() async {
    try {
      final result = await dynamicApi().getFunction(
        ApiEndpoint.get_song,
        Song.fromJson,
      );

      songList.assignAll(
        result.cast<Song>(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> getArtistDetails() async {
    try {
      final result = await dynamicApi().getFunction(
        ApiEndpoint.artist,
        Artist.fromJson,
      );

      artistList.assignAll(
        result.cast<Artist>(),
      );
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAlbumDetails() async {
    try {
      final result = await dynamicApi().getFunction(
        ApiEndpoint.get_album_song,
        Album.fromJson,
      );

      albumList.assignAll(
        result.cast<Album>(),
      );
    } catch (e) {
      print(e);
    }
  }

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
        } else if (entry.value is List) {
          for (var item in entry.value) {
            formData.fields.add(
              MapEntry(
                entry.key,
                item.toString(),
              ),
            );
          }
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

      return response;
    } on dio.DioException catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return null;
    }
  }

  Future<dio.Response?> updated({
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
        } else if (entry.value is List) {
          for (var item in entry.value) {
            formData.fields.add(
              MapEntry(
                entry.key,
                item.toString(),
              ),
            );
          }
        } else {
          formData.fields.add(
            MapEntry(
              entry.key,
              entry.value.toString(),
            ),
          );
        }
      }

      dio.Response response = await dioClient.put(
        endpoint,
        data: formData,
      );

      return response;
    } on dio.DioException catch (e) {
      print(e.response?.statusCode);
      print(e.response?.data);
      return null;
    }
  }

  Future<dio.Response?> delete({
    required String endpoint,
  }) async {
    try{
      dio.Response response = await dioClient.delete(
        endpoint,
      );
      print("${response.statusCode}");
      return response;
    }on dio.DioException catch(e){
      print(e.response?.statusCode);
      print(e.response?.data);
      return null;

    }
  }

  Future<void> songFilePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (result != null && result.files.single.path != null) {
      soundtrack.value = File(result.files.single.path!);
      print("song file: ${soundtrack.value!.path}");
    } else {
      print("file is not found");
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

      case "MediaAssets":
        hideMenu();
        Get.to(
          () => DynamicFormPage(
            title: title,
            fields: mediaAsset_form,
          ),
        );
    }
  }

  void showMenu(BuildContext context, String title,
      {required List<Widget> children}) {
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
                        title,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.6),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Divider(color: Colors.white12, height: 1),
                    ...children,
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
