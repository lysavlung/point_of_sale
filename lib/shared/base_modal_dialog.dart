import 'package:flutter/material.dart';

/// A base class for creating custom modal dialogs that can be extended.
///
/// This abstract class provides the foundation for creating consistent
/// modal dialogs throughout the application with customizable appearance
/// and behavior.
abstract class BaseModalDialog {
  /// The title displayed at the top of the dialog
  final String title;

  /// Whether the dialog can be dismissed by tapping outside
  final bool barrierDismissible;

  /// The color of the overlay/barrier behind the dialog
  final Color? barrierColor;

  /// The maximum width constraint for the dialog
  final double? maxWidth;

  /// The maximum height constraint for the dialog
  final double? maxHeight;

  /// Padding around the dialog content
  final EdgeInsetsGeometry contentPadding;

  /// Border radius of the dialog
  final BorderRadius borderRadius;

  /// The primary button text (usually for confirmation)
  final String? primaryButtonText;

  /// The secondary button text (usually for cancellation)
  final String? secondaryButtonText;

  const BaseModalDialog({
    required this.title,
    this.barrierDismissible = true,
    this.barrierColor = Colors.black54,
    this.maxWidth = 560.0,
    this.maxHeight,
    this.contentPadding = const EdgeInsets.all(24.0),
    this.borderRadius = const BorderRadius.all(Radius.circular(8.0)),
    this.primaryButtonText,
    this.secondaryButtonText,
  });

  /// Build the content of the dialog - to be implemented by subclasses
  Widget buildContent(BuildContext context);

  /// Optional method to handle primary button action
  void onPrimaryButtonPressed(BuildContext context) {
    Navigator.of(context).pop(true);
  }

  /// Optional method to handle secondary button action
  void onSecondaryButtonPressed(BuildContext context) {
    Navigator.of(context).pop(false);
  }

  /// Shows the dialog and returns a Future that completes when the dialog is dismissed
  Future<T?> show<T>(BuildContext context) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      barrierColor: barrierColor,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: borderRadius),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth ?? double.infinity,
              maxHeight: maxHeight ?? double.infinity,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildHeader(context),
                Flexible(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: contentPadding,
                      child: buildContent(context),
                    ),
                  ),
                ),
                _buildFooter(context),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Builds the header section of the dialog with title and close button
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24.0, 16.0, 16.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
            splashRadius: 24,
          ),
        ],
      ),
    );
  }

  /// Builds the footer section with action buttons
  Widget _buildFooter(BuildContext context) {
    if (primaryButtonText == null && secondaryButtonText == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (secondaryButtonText != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: TextButton(
                onPressed: () => onSecondaryButtonPressed(context),
                child: Text(secondaryButtonText!),
              ),
            ),
          if (primaryButtonText != null)
            ElevatedButton(
              onPressed: () => onPrimaryButtonPressed(context),
              child: Text(primaryButtonText!),
            ),
        ],
      ),
    );
  }
}
