import 'dart:async';
// In order to *not* need this ignore, consider extracting the "web" version
// of your plugin as a separate package, instead of inlining it in the same
// package as the core of your plugin.
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html show window;

import 'package:flutter/services.dart';
import 'package:flutter_barcode_sdk/barcode_manager.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// A web implementation of the FlutterBarcodeSdk plugin.
class FlutterBarcodeSdkWeb {
  BarcodeManager _barcodeManager = BarcodeManager();

  static void registerWith(Registrar registrar) {
    final MethodChannel channel = MethodChannel(
      'flutter_barcode_sdk',
      const StandardMethodCodec(),
      registrar,
    );

    final pluginInstance = FlutterBarcodeSdkWeb();
    channel.setMethodCallHandler(pluginInstance.handleMethodCall);
  }

  /// Handles method calls over the MethodChannel of this plugin.
  /// Note: Check the "federated" architecture for a new way of doing this:
  /// https://flutter.dev/go/federated-plugins
  Future<dynamic> handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'getPlatformVersion':
        return getPlatformVersion();
      case 'decodeFile':
        return decodeFile(call.arguments['filename']);
      case 'decodeVideo':
        decodeVideo();
        break;
      default:
        throw PlatformException(
          code: 'Unimplemented',
          details:
              'flutter_barcode_sdk for web doesn\'t implement \'${call.method}\'',
        );
    }
  }

  /// Returns a [String] containing the version of the platform.
  Future<String> getPlatformVersion() {
    final version = html.window.navigator.userAgent;
    return Future.value(version);
  }

  Future<List<Map<dynamic, dynamic>>> decodeFile(String file) async {
    return _barcodeManager.decodeFile(file);
  }

  Future<void> decodeVideo() async {
    _barcodeManager.decodeVideo();
  }
}
