import 'package:bookie_buddy_web/features/printer/domain/entities/printer_device_entity/printer_device_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'printer_device_model.freezed.dart';
part 'printer_device_model.g.dart';

@freezed
abstract class PrinterDeviceModel with _$PrinterDeviceModel {
  const factory PrinterDeviceModel({required String name}) =
      _PrinterDeviceModel;

  factory PrinterDeviceModel.fromJson(Map<String, dynamic> json) =>
      _$PrinterDeviceModelFromJson(json);

  factory PrinterDeviceModel.fromEntity(PrinterDeviceEntity entity) =>
      PrinterDeviceModel(name: entity.name);
}

extension PrinterDeviceModelMapper on PrinterDeviceModel {
  PrinterDeviceEntity toEntity() => PrinterDeviceEntity(name: name);
}
