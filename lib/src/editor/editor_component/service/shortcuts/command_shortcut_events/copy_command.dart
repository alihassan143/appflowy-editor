import 'package:appflowy_editor/appflowy_editor.dart';
import 'package:flutter/material.dart';

/// Copy.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent copyCommand = CommandShortcutEvent(
  key: 'copy the selected content',
  command: 'ctrl+c',
  macOSCommand: 'cmd+c',
  handler: _copyCommandHandler,
);

CommandShortcutEventHandler _copyCommandHandler = (editorState) {
  if (PlatformExtension.isMobile) {
    assert(false, 'copyCommand is not supported on mobile platform.');
    return KeyEventResult.ignored;
  }

  var selection = editorState.selection?.normalized;
  if (selection == null || selection.isCollapsed) {
    return KeyEventResult.ignored;
  }

  // plain text.
  final text = editorState.getTextInSelection(selection).join('\n');

  // rich text.
  // TODO: support rich text. the below code is not working.

  final nodes = editorState.getSelectedNodes(selection);

  final html = documentToHTML(
    Document(
      root: Node(
        type: 'page',
        children: nodes,
      ),
    ),
  );
  AppFlowyClipboard.setData(
    text: text,
    html: html.isEmpty ? null : html,
  );

  return KeyEventResult.handled;
};
