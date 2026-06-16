enum FieldType {
  text,
  multiline,
  number,
  multipleArtistSelection,
  multipleGenreSelection,
  multipleAlbumSelection,
  image,
  date,
}

class FormFieldConfig {
  final String name;
  final String label;
  final FieldType type;
  final bool required;

  const FormFieldConfig({
    required this.name,
    required this.label,
    required this.type,
    this.required = false,
  });
}
