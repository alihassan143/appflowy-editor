import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

/// Copy.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent cutCommand = CommandShortcutEvent(
  key: 'cut the selected content',
  command: 'ctrl+x',
  macOSCommand: 'cmd+x',
  handler: _cutCommandHandler,
);

CommandShortcutEventHandler _cutCommandHandler = (editorState) {
  if (PlatformExtension.isMobile) {
    assert(false, 'cutCommand is not supported on mobile platform.');
    return KeyEventResult.ignored;
  }

  // plain text.
  handleCut(editorState);
  return KeyEventResult.handled;
};
