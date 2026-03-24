import 'package:freezed_annotation/freezed_annotation.dart';

part 'document_file_entity.freezed.dart';

@freezed
abstract class DocumentFileEntity with _$DocumentFileEntity {
  const factory DocumentFileEntity({
    required String name,
    required String path,
    List<int>? bytes,
  }) = _DocumentFileEntity;
}
