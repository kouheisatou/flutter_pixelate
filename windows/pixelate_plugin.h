#ifndef FLUTTER_PLUGIN_PIXCELLATE_PLUGIN_H_
#define FLUTTER_PLUGIN_PIXCELLATE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace pixcellate {

class PixcellatePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  PixcellatePlugin();

  virtual ~PixcellatePlugin();

  // Disallow copy and assign.
  PixcellatePlugin(const PixcellatePlugin&) = delete;
  PixcellatePlugin& operator=(const PixcellatePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace pixcellate

#endif  // FLUTTER_PLUGIN_PIXCELLATE_PLUGIN_H_
