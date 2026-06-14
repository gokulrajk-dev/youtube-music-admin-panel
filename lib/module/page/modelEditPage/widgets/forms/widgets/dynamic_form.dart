import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../core/network/ApiEndpoint.dart';
import '../../../controller/modelEditPageController.dart';
import '../config/form_field_config.dart';

class DynamicFormPage extends StatefulWidget {
  final String title;
  final List<FormFieldConfig> fields;

  const DynamicFormPage({
    super.key,
    required this.title,
    required this.fields,
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

  @override
  void initState() {
    super.initState();
    for (var field in widget.fields) {
      controller[field.name] = TextEditingController();
      focusNode[field.name] = FocusNode();
    }
    GetListModel(widget.title);
  }

  Future<void> GetListModel(String title) async {
    switch (title) {
      case "Album":
        await formController.getArtistDetails();
        print(" album artist :${formController.artistList.length}");
    }
  }

  Future<void> _saveForm(final photo) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    if (photo && widget.title != "Genre") {
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
        return await formController.submit(
          endpoint: ApiEndpoint.artist,
          data: {
            "artist_name": controller['artist_name']!.text,
            "artist_bio": controller['artist_bio']!.text,
            "artist_image": formController.selectedImage.value,
            "country": controller['country']!.text,
          },
        );
      case "Genre":
        return await formController.submit(
          endpoint: ApiEndpoint.genre,
          data: {
            "genre_name": controller['genre_name']!.text,
            "description": controller['description']!.text,
          },
        );
      case "Album":
         final result = await formController.submit(
          endpoint: ApiEndpoint.get_album_song,
          data: {
            "title": controller["title"]!.text,
            "cover_image": formController.selectedImage.value,
            // "release_date": controller["release_date"]!.text,
            "artist_id": formController.artist_id,
            "description": controller["description"]!.text
          },
        );
         print("result :$result");
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
                child: Text("Save ${widget.title}",
                    style: const TextStyle(color: Colors.white, fontSize: 16)),
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
        return const SizedBox();
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

  Widget _buildMultipleSelect(FormFieldConfig field) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 300,
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
