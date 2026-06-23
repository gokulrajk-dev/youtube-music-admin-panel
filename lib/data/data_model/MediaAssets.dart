import 'package:basic_fundamental/data/data_model/song_module.dart';

class MediaAssets {
  final int id;
  final String originalFile;
  final String checksum;
  final String storageProvider;
  final String processingStatus;
  final String createdAt;
  final Song? song;

  MediaAssets({
    required this.id,
    required this.originalFile,
    required this.checksum,
    required this.storageProvider,
    required this.processingStatus,
    required this.createdAt,
    required this.song,
  });

  factory MediaAssets.fromJson(Map<String, dynamic> json) {
    return MediaAssets(
      id: json['id'],
      originalFile: json['original_file'],
      checksum: json['checksum'],
      storageProvider: json['storage_provider'],
      processingStatus: json['processing_status'],
      createdAt: json['created_at'],
      song: json['song'] !=null ? Song.fromJson(json['song']) : null,
    );
  }
}