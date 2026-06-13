import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/config/form_field_config.dart';

final GenreForm = [
  const FormFieldConfig(
      name: 'genre_name',
      label: 'Genre Name (eg : melody,hip hop)',
      type: FieldType.text,
      required: true),
  const FormFieldConfig(
    name: 'description',
    label: 'Description',
    type: FieldType.multiline,
  ),
];
