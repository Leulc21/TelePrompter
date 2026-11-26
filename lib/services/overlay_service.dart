import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';

class OverlayService {
  static Future<bool> isActive() async {
    final active = await FlutterOverlayWindow.isActive();
    debugPrint('>>> OverlayService.isActive -> $active');
    return active;
  }

  static Future<bool> ensurePermission() async {
    var granted = await FlutterOverlayWindow.isPermissionGranted();
    debugPrint('>>> ensurePermission: initial granted=$granted');
    if (!granted) {
      granted = await FlutterOverlayWindow.requestPermission() ?? false;
      debugPrint('>>> ensurePermission: after request granted=$granted');
    }
    return granted;
  }

  static Future<void> show({
    required BuildContext context,
    required Map<String, dynamic> payload,
  }) async {
    debugPrint('>>> OverlayService.show: ENTERED');

    if (await FlutterOverlayWindow.isActive()) {
      debugPrint('>>> OverlayService.show: closing old overlay first');
      await FlutterOverlayWindow.closeOverlay();
      await Future.delayed(const Duration(milliseconds: 300));
    }

    final mq = MediaQuery.of(context);
    final heightPx = (mq.size.height * 0.45 * mq.devicePixelRatio).round();
    debugPrint('>>> OverlayService.show: heightPx=$heightPx');

    await FlutterOverlayWindow.showOverlay(
      height: heightPx,
      width: WindowSize.matchParent,
      alignment: OverlayAlignment.topCenter,
      enableDrag: true,
      overlayTitle: 'Teleprompter',
      overlayContent: 'Teleprompter is running',
      flag: OverlayFlag.defaultFlag,
      visibility: NotificationVisibility.visibilityPublic,
      positionGravity: PositionGravity.none,
    );
    debugPrint('>>> OverlayService.show: showOverlay RETURNED');

    // Do NOT block on shareData — fire it with a timeout so a stuck
    // channel doesn't freeze the UI. Retry a few times.
    _pushWithRetry(payload, attempts: 10);
  }

  static Future<void> _pushWithRetry(
    Map<String, dynamic> payload, {
    required int attempts,
  }) async {
    for (var i = 1; i <= attempts; i++) {
      await Future.delayed(const Duration(milliseconds: 400));
      debugPrint('>>> pushWithRetry: attempt $i/$attempts');
      try {
        // Add a timeout so a hung call doesn't block forever.
        await FlutterOverlayWindow.shareData(payload)
            .timeout(const Duration(seconds: 2));
        debugPrint('>>> pushWithRetry: SUCCESS on attempt $i');
        return;
      } on TimeoutException {
        debugPrint('>>> pushWithRetry: attempt $i timed out, retrying...');
      } catch (e) {
        debugPrint('>>> pushWithRetry: attempt $i error: $e');
      }
    }
    debugPrint('>>> pushWithRetry: gave up after $attempts attempts');
  }

  static Future<void> close() async {
    debugPrint('>>> OverlayService.close: called');
    await FlutterOverlayWindow.closeOverlay();
    debugPrint('>>> OverlayService.close: done');
  }

  static Future<void> pushData(Map<String, dynamic> payload) async {
    if (await FlutterOverlayWindow.isActive()) {
      debugPrint('>>> OverlayService.pushData: sending');
      try {
        await FlutterOverlayWindow.shareData(payload)
            .timeout(const Duration(seconds: 2));
      } catch (e) {
        debugPrint('>>> OverlayService.pushData: error/timeout: $e');
      }
    } else {
      debugPrint('>>> OverlayService.pushData: overlay not active, skipped');
    }
  }
}
