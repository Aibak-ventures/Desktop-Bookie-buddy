import 'package:bookie_buddy_web/features/booking/domain/entities/document_file_entity/document_file_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_file_model.freezed.dart';

@freezed
abstract class DocumentFileModel with _$DocumentFileModel {
  const factory DocumentFileModel({
    required String name,
    required String path,
    List<int>? bytes,
  }) = _DocumentFileModel;

  factory DocumentFileModel.fromEntity(DocumentFileEntity entity) =>
      DocumentFileModel(
        name: entity.name,
        path: entity.path,
        bytes: entity.bytes,
      );

  static List<DocumentFileModel> fromEntityList(
    List<DocumentFileEntity> entities,
  ) => entities.map((e) => DocumentFileModel.fromEntity(e)).toList();
}

extension DocumentFileModelMapper on DocumentFileModel {
  DocumentFileEntity toEntity() =>
      DocumentFileEntity(name: name, path: path, bytes: bytes);
}

extension DocumentFileEntityMapper on DocumentFileEntity {
  DocumentFileModel fromEntity() =>
      DocumentFileModel(name: name, path: path, bytes: bytes);
}
