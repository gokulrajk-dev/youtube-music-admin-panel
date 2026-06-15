import 'dart:io';

import 'package:basic_fundamental/data/data_model/album_module.dart';
import 'package:basic_fundamental/data/data_model/genre.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/network/ApiEndpoint.dart';
import '../../../../../../data/data_model/Artist.dart';
import '../../../controller/modelEditPageController.dart';
import '../config/form_field_config.dart';

class DynamicFormPage extends StatefulWidget {
  final String title;
  final List<FormFieldConfig> fields;
  final dynamic model;

  const DynamicFormPage({
    super.key,
    required this.title,
    required this.fields,
    this.model,
  });

  @override
  State<DynamicFormPage> createState() => _DynamicFormPageState();
}

class _DynamicFormPageState extends State<DynamicFormPage> {
  final Map<String, TextEditingController> controller = {};
  final Map<String, FocusNode> focusNode = {};
  final _formKey = GlobalKey<FormState>();
  final GetModelEditController formController =
      Get.find<GetModelEditController>();

  bool get editing => widget.model != null;
  String model_img = '';
  String save_update = 'Save';

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      controller[field.name] = TextEditingController();
      focusNode[field.name] = FocusNode();
    }
    GetListModel(widget.title);
    if (editing) {
      updateListModel(widget.title);
      save_update ='Update';
    }
  }

  Future<void> GetListModel(String title) async {
    switch (title) {
      case "Album":
        await formController.getArtistDetails();
        print(" album artist :${formController.artistList.length}");
    }
  }

  void updateListModel(String title) {
    switch (title) {
      case "Artist":
        final artist = widget.model as Artist;
        controller['artist_name']!.text = artist.artistName!;
        controller['artist_bio']!.text = artist.artistBio!;
        model_img = artist.artistImage!;
        controller['country']!.text = artist.country!;

        return;

      case "Genre":
        final genre = widget.model as Genre;
        controller['genre_name']!.text = genre.genreName!;
        controller['description']!.text = genre.description!;
        return;

      case "Album":
        final album = widget.model as Album;
        controller['title']!.text = album.title ?? '';
        controller['release_date']!.text = album.releaseDate ?? '';
        controller['description']!.text = album.description ?? '';
        model_img = album.coverImage!;
        // Pre-select the artist checkbox
        for (var artistId in album.artists!.map((e) => e.id)) {
          formController.artist_id.add(artistId);
        }
        return;
    }
  }

  Future<void> _saveForm(final photo) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (photo && widget.title != "Genre" && !editing) {
      Get.snackbar(
        "Failed",
        "pls add the Artist photo",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    await dynamicFormDataPost(widget.title);
    Get.back();
    Get.snackbar(
      "Success",
      "Saved successfully",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  Future<dynamic> dynamicFormDataPost(String title) async {
    if (title.isEmpty) return;
    switch (title) {
      case "Artist":
        if (editing) {
          final artist = widget.model as Artist;
          final response = await formController.updated(
            endpoint: "${ApiEndpoint.artist}${artist.id}/",
            data: {
              "artist_name": controller['artist_name']!.text,
              "artist_bio": controller['artist_bio']!.text,
              "artist_image": formController.selectedImage.value,
              "country": controller['country']!.text,
            },
          );
          if (response != null) {
            final updated = Artist.fromJson(response.data);
            final index = formController.items
                .indexWhere((e) => (e as Artist).id == updated.id);
            if (index != -1) formController.items[index] = updated;
          }
        } else {
          final response = await formController.submit(
            endpoint: ApiEndpoint.artist,
            data: {
              "artist_name": controller['artist_name']!.text,
              "artist_bio": controller['artist_bio']!.text,
              "artist_image": formController.selectedImage.value,
              "country": controller['country']!.text,
            },
          );
          if (response != null) {
            final artist = Artist.fromJson(response.data);
            formController.items.add(artist);
          }
        }
        return;

      case "Genre":
        if (editing) {
          final genre = widget.model as Genre;
          final response = await formController.updated(
            endpoint: "${ApiEndpoint.genre}${genre.id}/",
            data: {
              "genre_name": controller['genre_name']!.text,
              "description": controller['description']!.text,
            },
          );
          if (response != null) {
            final updated = Genre.fromJson(response.data);
            final index = formController.items
                .indexWhere((e) => (e as Genre).id == updated.id);
            if (index != -1) formController.items[index] = updated;
          }
        } else {
          final response = await formController.submit(
            endpoint: ApiEndpoint.genre,
            data: {
              "genre_name": controller['genre_name']!.text,
              "description": controller['description']!.text,
            },
          );
          if (response != null) {
            final genre = Genre.fromJson(response.data);
            formController.items.add(genre);
          }
        }
        return;

      case "Album":
        if (editing) {
          final album = widget.model as Album;
          final response = await formController.updated(
            endpoint: "${ApiEndpoint.get_album_song}${album.id}/",
            data: {
              "title": controller["title"]!.text,
              "cover_image": formController.selectedImage.value,
              "release_date": controller['release_date']!.text,
              "artist_id": formController.artist_id,
              "description": controller["description"]!.text,
            },
          );
          if (response != null) {
            final updated = Album.fromJson(response.data);
            final index = formController.items
                .indexWhere((e) => (e as Album).id == updated.id);
            if (index != -1) formController.items[index] = updated;
          }
        } else {
          final response = await formController.submit(
            endpoint: ApiEndpoint.get_album_song,
            data: {
              "title": controller["title"]!.text,
              "cover_image": formController.selectedImage.value,
              "release_date": controller['release_date']!.text,
              "artist_id": formController.artist_id,
              "description": controller["description"]!.text,
            },
          );
          if (response != null) {
            final album = Album.fromJson(response.data);
            formController.items.add(album);
          }
        }
        return;
    }
  }

  @override
  void dispose() {
    for (var controllers in controller.values) {
      controllers.dispose();
    }
    for (var node in focusNode.values) {
      node.dispose();
    }
    formController.selectedImage.value = null;
    formController.artist_id.value=[];
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              ...widget.fields
                  .asMap()
                  .entries
                  .map((e) => _buildField(e.value, e.key)),
              const SizedBox(height: 12),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF7C3AED),
                  minimumSize: const Size(double.infinity, 54),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () async {
                  await _saveForm(formController.selectedImage.value == null);
                },
                child:Text("$save_update ${widget.title}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(FormFieldConfig field, int index) {
    switch (field.type) {
      case FieldType.text:
      case FieldType.multiline:
        return _buildTextField(field, index);
      case FieldType.number:
        return const SizedBox();
      case FieldType.multipleSelection:
        return _buildMultipleSelect(field);
      case FieldType.image:
        return _buildImagePicker();
      case FieldType.date:
        return _buildDateTextField(field, index);
    }
  }

  Widget _buildTextField(FormFieldConfig field, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        autofocus: index == 0,
        controller: controller[field.name],
        focusNode: focusNode[field.name],
        maxLines: field.type == FieldType.multiline ? 5 : 1,
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (field.required && (value == null || value.trim().isEmpty)) {
            return "${field.name} is empty pls fill";
          }
          return null;
        },
        onFieldSubmitted: (_) {
          if (index < widget.fields.length - 1) {
            final nextField = widget.fields[index + 1];

            FocusScope.of(context).requestFocus(focusNode[nextField.name]);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        decoration: InputDecoration(
          labelText: field.label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }

  Widget _buildDateTextField(FormFieldConfig field, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        readOnly: true,
        controller: controller[field.name],
        focusNode: focusNode[field.name],
        style: const TextStyle(color: Colors.white),
        validator: (value) {
          if (field.required && (value == null || value.trim().isEmpty)) {
            return "${field.name} is empty pls fill";
          }
          return null;
        },
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
              context: context,
              firstDate: DateTime(1900),
              lastDate: DateTime.now(),
              initialDate: DateTime.now());
          if (pickedDate != null) {
            controller['release_date']!.text = "${pickedDate.year}-"
                "${pickedDate.month.toString().padLeft(2, '0')}-"
                "${pickedDate.day.toString().padLeft(2, '0')}";
          }
        },
        onFieldSubmitted: (_) {
          if (index < widget.fields.length - 1) {
            final nextField = widget.fields[index + 1];

            FocusScope.of(context).requestFocus(focusNode[nextField.name]);
          } else {
            FocusScope.of(context).unfocus();
          }
        },
        decoration: InputDecoration(
          suffixIcon: const Icon(
            Icons.calendar_month,
            color: Colors.white,
          ),
          labelText: field.label,
          labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
          ),
        ),
      ),
    );
  }

  Widget _buildMultipleSelect(FormFieldConfig field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.04),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
            width: 0.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                field.label.toUpperCase(),
                style: const TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                  color: Color(0x4DF0ECE4),
                ),
              ),
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: formController.artistList.length,
                  itemBuilder: (context, index) {
                    print(" album artist :${formController.artistList.length}");
                    final artist = formController.artistList[index];
                    final artist_id = formController.artist_id;
                    return CheckboxListTile(
                      title: Text(
                        artist.artistName ?? "",
                        style: const TextStyle(color: Colors.white),
                      ),
                      value: formController.artist_id.contains(artist.id),
                      onChanged: (value) {
                        setState(() {
                          if (value!) {
                            if (!artist_id.contains(artist.id)) {
                              artist_id.add(artist.id);
                            }
                          } else {
                            artist_id.remove(artist.id);
                          }
                        });
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePicker() {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await formController.imagePickers();
          },
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 6),
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.08),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.white.withOpacity(0.1),
              ),
            ),
            child: Obx(
                    () {
                      if(editing && formController.selectedImage.value==null){
                        return  ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            model_img,
                            fit: BoxFit.cover,
                          ),
                        );
                      }
                      if (formController.selectedImage.value == null) {
                        return const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo,
                              size: 100,
                              color: Colors.white,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Click To Select Image",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        );
                      }
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          formController.selectedImage.value as File,
                          fit: BoxFit.cover,
                        ),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }
}