import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_fingerprint.g.dart';

@JsonSerializable()
class DeviceFingerprint extends Equatable {
  final String hardwareId;
  final String deviceModel;
  final String deviceName;
  final String osFamily;
  const DeviceFingerprint({
    required this.hardwareId,
    required this.deviceModel,
    required this.deviceName,
    required this.osFamily,
  });
  factory DeviceFingerprint.fromJson(Map<String, dynamic> json) =>
      _$DeviceFingerprintFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceFingerprintToJson(this);
  @override
  List<Object?> get props => [hardwareId, deviceModel, deviceName, osFamily];
}
