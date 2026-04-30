import 'package:flutter/foundation.dart';

/// A global [ValueNotifier] that holds the current profile image URL.
///
/// Any widget that needs to react to profile image changes should listen to
/// this notifier using [ValueListenableBuilder].
///
/// Usage:
///   - After a successful image upload, call:
///       profileImageNotifier.value = newUrl;
///   - In any widget (e.g. SearchBarWidget):
///       ValueListenableBuilder<String?>(
///         valueListenable: profileImageNotifier,
///         builder: (context, imageUrl, _) { ... },
///       )
final ValueNotifier<String?> profileImageNotifier = ValueNotifier<String?>(null);
