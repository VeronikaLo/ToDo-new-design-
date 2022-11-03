import 'package:flutter/material.dart';

class SaveProgressOverlay extends StatelessWidget {
  final bool isSaving;
  const SaveProgressOverlay({super.key, required this.isSaving});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isSaving, // if we're not saving - widget is ignored
      child: Visibility(  
        visible: isSaving,  // visible if we're saving
        child: Center(
          child: CircularProgressIndicator(color: Theme.of(context).colorScheme.tertiary),
        ),
      ),
    );
  }
}