import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'device_info.g.dart';

@JsonSerializable()
class DeviceInfo extends Equatable {
  final String deviceName;
  final String platform;
  final String osVersion;
  final String appVersion;
  const DeviceInfo({
    required this.deviceName,
    required this.platform,
    required this.osVersion,
    required this.appVersion,
  });
  factory DeviceInfo.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoToJson(this);
  @override
  List<Object?> get props => [deviceName, platform, osVersion, appVersion];
}
