import 'package:basic_fundamental/module/page/modelEditPage/widgets/forms/config/form_field_config.dart';

final mediaAsset_form = [
  const FormFieldConfig(
      name: 'song',
      label: 'song',
      type: FieldType.multipleSongSelection,
      required: true),
  const FormFieldConfig(
      name: 'original song',
      label: 'original song',
      type: FieldType.file,
      required: true),
];
