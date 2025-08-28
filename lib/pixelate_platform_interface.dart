import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'pixelate_method_channel.dart';

abstract class PixelatePlatform extends PlatformInterface {
  /// Constructs a PixelatePlatform.
  PixelatePlatform() : super(token: _token);

  static final Object _token = Object();

  static PixelatePlatform _instance = MethodChannelPixelate();

  /// The default instance of [PixelatePlatform] to use.
  ///
  /// Defaults to [MethodChannelPixelate].
  static PixelatePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [PixelatePlatform] when
  /// they register themselves.
  static set instance(PixelatePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
