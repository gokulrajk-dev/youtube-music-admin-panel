// Empty file


import '../../../../../../data/registry/model_type.dart';
import '../definitions/artist_form.dart';

class FormRegistry {
  static final forms = {
    ModelType.artist: artistForm,
    // ModelType.song: songForm,
    // ModelType.album: albumForm,
    // ModelType.genre: genreForm,
  };
}