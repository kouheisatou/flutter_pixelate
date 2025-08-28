import 'package:flutter_test/flutter_test.dart';
import 'package:pixelate/pixelate.dart';
import 'package:pixelate/pixelate_platform_interface.dart';
import 'package:pixelate/pixelate_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockPixelatePlatform
    with MockPlatformInterfaceMixin
    implements PixelatePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final PixelatePlatform initialPlatform = PixelatePlatform.instance;

  test('$MethodChannelPixelate is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelPixelate>());
  });

  test('getPlatformVersion', () async {
    Pixelate pixelatePlugin = Pixelate();
    MockPixelatePlatform fakePlatform = MockPixelatePlatform();
    PixelatePlatform.instance = fakePlatform;

    expect(await pixelatePlugin.getPlatformVersion(), '42');
  });
}
