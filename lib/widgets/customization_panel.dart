import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/customization_provider.dart';

class CustomizationPanel extends ConsumerWidget {
  const CustomizationPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final customizationNotifier = ref.read(customizationProvider.notifier);
    final customizationState = ref.watch(customizationProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('Font Size:'),
              Expanded(
                child: Slider(
                  value: customizationState.fontSize,
                  min: 10,
                  max: 30,
                  divisions: 10,
                  label: customizationState.fontSize.toString(),
                  onChanged: (value) {
                    customizationNotifier.updateFontSize(value);
                  },
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text('Font Color:'),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (ctx) {
                      return AlertDialog(
                        title: const Text('Pick Font Color'),
                        content: SingleChildScrollView(
                          child: ColorPicker(
                            pickerColor: customizationState.fontColor,
                            onColorChanged: (color) {
                              customizationNotifier.updateFontColor(color);
                            },
                          ),
                        ),
                        actions: [
                          TextButton(
                            child: const Text('Close'),
                            onPressed: () => Navigator.of(ctx).pop(),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Container(
                  width: 24,
                  height: 24,
                  color: customizationState.fontColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
