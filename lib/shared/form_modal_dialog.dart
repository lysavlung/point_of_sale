import 'package:flutter/material.dart';
import 'base_modal_dialog.dart';

/// A form dialog that extends the BaseModalDialog
class FormDialog extends BaseModalDialog {
  /// The form key to validate form inputs
  final GlobalKey<FormState> formKey;

  /// Function that builds the form content
  final Widget Function(BuildContext) formBuilder;

  /// Callback when form is submitted (primary button)
  final Function(BuildContext)? onSubmit;

  const FormDialog({
    required super.title,
    required this.formKey,
    required this.formBuilder,
    this.onSubmit,
    String submitText = 'Submit',
    String cancelText = 'Cancel',
  }) : super(primaryButtonText: submitText, secondaryButtonText: cancelText);

  @override
  Widget buildContent(BuildContext context) {
    return Form(key: formKey, child: formBuilder(context));
  }

  @override
  void onPrimaryButtonPressed(BuildContext context) {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      onSubmit?.call(context);
      super.onPrimaryButtonPressed(context);
    }
  }
}
