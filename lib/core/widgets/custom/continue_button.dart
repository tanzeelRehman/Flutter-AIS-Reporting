import 'package:flutter/material.dart';

//ignore: must_be_immutable
class ContinueButton extends StatelessWidget {
  ContinueButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.loadingNotifier,
      this.isEnabledNotifier,
      this.backgroundColor})
      : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final ValueNotifier<bool>? loadingNotifier;
  final Color? backgroundColor;
  ValueNotifier<bool>? isEnabledNotifier;

  @override
  Widget build(BuildContext context) {
    if (loadingNotifier == null) {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(backgroundColor),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: Theme.of(context).textTheme.labelLarge,
        ),
      );
    }

    isEnabledNotifier ??= ValueNotifier(true);

    return ValueListenableBuilder<bool>(
      valueListenable: isEnabledNotifier!,
      builder: (context, isEnabled, child) {
        return ValueListenableBuilder<bool>(
          valueListenable: loadingNotifier!,
          builder: (context, isLoading, child) {
            return ElevatedButton(
              onPressed: shouldButtonBeEnabled(isEnabled, isLoading)
                  ? onPressed
                  : null,
              child: (isLoading)
                  ? CircularProgressIndicator.adaptive(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Theme.of(context).scaffoldBackgroundColor),
                    )
                  : Text(text, style: Theme.of(context).textTheme.labelLarge),
            );
          },
        );
      },
    );
  }

  bool shouldButtonBeEnabled(bool isEnabled, bool isLoading) =>
      isEnabled && !isLoading;
}
