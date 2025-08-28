#include "include/pixcellate/pixcellate_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "pixcellate_plugin.h"

void PixcellatePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  pixcellate::PixcellatePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
