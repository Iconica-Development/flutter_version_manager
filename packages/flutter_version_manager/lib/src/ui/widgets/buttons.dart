import "dart:async";

import "package:flutter/material.dart";

/// Contains the default accept button for the update dialog.
/// By default this will be a [FilledButton].
class DefaultAcceptButton extends StatelessWidget {
  /// Creates a new instance of [DefaultAcceptButton].
  const DefaultAcceptButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  /// The function to call when the button is pressed.
  final FutureOr<void> Function()? onPressed;

  /// The content to show in the button.
  final Widget child;

  /// The builder for the accept button.
  static Widget builder(
    BuildContext context,
    FutureOr<void>? Function()? onPressed,
    Widget child,
  ) =>
      DefaultAcceptButton(
        onPressed: onPressed,
        child: child,
      );

  @override
  Widget build(BuildContext context) => Expanded(
        child: FilledButton(
          onPressed: onPressed,
          child: child,
        ),
      );
}

/// Contains the default decline button for the update dialog.
/// By default this will be a [OutlinedButton].
class DefaultDeclineButton extends StatelessWidget {
  /// Creates a new instance of [DefaultDeclineButton].
  const DefaultDeclineButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  /// The function to call when the button is pressed.
  final FutureOr<void> Function()? onPressed;

  /// The content to show in the button.
  final Widget child;

  /// The builder for the decline button.
  static Widget builder(
    BuildContext context,
    FutureOr<void>? Function()? onPressed,
    Widget child,
  ) =>
      DefaultDeclineButton(
        onPressed: onPressed,
        child: child,
      );

  @override
  Widget build(BuildContext context) => Expanded(
        child: OutlinedButton(
          onPressed: onPressed,
          child: child,
        ),
      );
}

/// Contains the default update button for the update dialog.
/// By default this will be a [FilledButton].
class DefaultUpdateButton extends StatelessWidget {
  /// Creates a new instance of [DefaultUpdateButton].
  const DefaultUpdateButton({
    required this.onPressed,
    required this.child,
    super.key,
  });

  /// The function to call when the button is pressed.
  final FutureOr<void> Function()? onPressed;

  /// The content to show in the button.
  final Widget child;

  /// The builder for the update button.
  static Widget builder(
    BuildContext context,
    FutureOr<void>? Function()? onPressed,
    Widget child,
  ) =>
      DefaultUpdateButton(
        onPressed: onPressed,
        child: child,
      );

  @override
  Widget build(BuildContext context) => FilledButton(
        onPressed: onPressed,
        child: child,
      );
}
