import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'pixelate_platform_interface.dart';

/// An implementation of [PixelatePlatform] that uses method channels.
class MethodChannelPixelate extends PixelatePlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('pixelate');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
