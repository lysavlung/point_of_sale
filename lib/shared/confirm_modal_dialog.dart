import 'package:flutter/material.dart';
import 'base_modal_dialog.dart';

/// A simple confirmation dialog that extends the BaseModalDialog
class ConfirmationDialog extends BaseModalDialog {
  /// The message displayed in the dialog content
  final String message;

  /// Custom widget to display instead of the message text
  final Widget? customContent;

  /// Callback when primary button is pressed
  final VoidCallback? onConfirm;

  /// Callback when secondary button is pressed
  final VoidCallback? onCancel;

  const ConfirmationDialog({
    required super.title,
    required this.message,
    this.customContent,
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    this.onConfirm,
    this.onCancel,
    super.barrierDismissible,
  }) : super(primaryButtonText: confirmText, secondaryButtonText: cancelText);

  @override
  Widget buildContent(BuildContext context) {
    return customContent ?? Text(message);
  }

  @override
  void onPrimaryButtonPressed(BuildContext context) {
    onConfirm?.call();
    super.onPrimaryButtonPressed(context);
  }

  @override
  void onSecondaryButtonPressed(BuildContext context) {
    onCancel?.call();
    super.onSecondaryButtonPressed(context);
  }
}
