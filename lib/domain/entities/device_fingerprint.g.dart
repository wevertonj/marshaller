// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device_fingerprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceFingerprint _$DeviceFingerprintFromJson(Map<String, dynamic> json) =>
    DeviceFingerprint(
      hardwareId: json['hardwareId'] as String,
      deviceModel: json['deviceModel'] as String,
      deviceName: json['deviceName'] as String,
      osFamily: json['osFamily'] as String,
    );

Map<String, dynamic> _$DeviceFingerprintToJson(DeviceFingerprint instance) =>
    <String, dynamic>{
      'hardwareId': instance.hardwareId,
      'deviceModel': instance.deviceModel,
      'deviceName': instance.deviceName,
      'osFamily': instance.osFamily,
    };
