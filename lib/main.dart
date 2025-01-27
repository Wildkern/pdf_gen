import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Resume Generator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

// State providers for customization
final fontSizeProvider = StateProvider<double>((ref) => 12.0);
final fontColorProvider = StateProvider<Color>((ref) => Colors.black);
final backgroundColorProvider = StateProvider<Color>((ref) => Colors.white);

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fontSize = ref.watch(fontSizeProvider);
    final fontColor = ref.watch(fontColorProvider);
    final backgroundColor = ref.watch(backgroundColorProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resume Generator'),
      ),
      body: Column(
        children: [
          // Customization controls
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Customize Resume',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 16),
                    // Font size slider
                    Row(
                      children: [
                        const Text('Font Size: '),
                        Expanded(
                          child: Slider(
                            value: fontSize,
                            min: 8,
                            max: 24,
                            onChanged: (value) => ref
                                .read(fontSizeProvider.notifier)
                                .state = value,
                          ),
                        ),
                        Text('${fontSize.toStringAsFixed(1)}'),
                      ],
                    ),
                    // Color pickers
                    Row(
                      children: [
                        const Text('Font Color: '),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _showColorPicker(context, ref, true),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: fontColor,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const Text('Background Color: '),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => _showColorPicker(context, ref, false),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: backgroundColor,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // PDF Preview
          Expanded(
            child: PdfPreview(
              build: (format) => generateResume(
                fontSize: fontSize,
                fontColor: fontColor,
                backgroundColor: backgroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showColorPicker(
      BuildContext context, WidgetRef ref, bool isFont) async {
    // Implement color picker dialog here
  }
}

Future<Uint8List> generateResume({
  required double fontSize,
  required Color fontColor,
  required Color backgroundColor,
}) async {
  final pdf = pw.Document();

  final font = await PdfGoogleFonts.robotoRegular();
  final boldFont = await PdfGoogleFonts.robotoBold();

  pdf.addPage(
    pw.Page(
      pageFormat: PdfPageFormat.a4,
      build: (pw.Context context) {
        return pw.Container(
          color: PdfColor.fromInt(backgroundColor.value),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Header(
                child: pw.Text(
                  'John Doe',
                  style: pw.TextStyle(
                    font: boldFont,
                    fontSize: fontSize * 2,
                    color: PdfColor.fromInt(fontColor.value),
                  ),
                ),
              ),
              pw.Text(
                'Software Developer',
                style: pw.TextStyle(
                  font: font,
                  fontSize: fontSize * 1.5,
                  color: PdfColor.fromInt(fontColor.value),
                ),
              ),
              pw.SizedBox(height: 20),
              _buildSection(
                'Contact Information',
                [
                  'Email: john.doe@example.com',
                  'Phone: (123) 456-7890',
                  'Location: New York, NY',
                ],
                font,
                fontSize,
                fontColor,
              ),
              _buildSection(
                'Skills',
                [
                  'Flutter Development',
                  'Dart Programming',
                  'UI/UX Design',
                  'Mobile App Development',
                ],
                font,
                fontSize,
                fontColor,
              ),
              _buildSection(
                'Experience',
                [
                  'Senior Flutter Developer - Tech Corp (2020-Present)',
                  'Mobile Developer - App Inc. (2018-2020)',
                  'Junior Developer - Start Up LLC (2016-2018)',
                ],
                font,
                fontSize,
                fontColor,
              ),
              _buildSection(
                'Education',
                [
                  'Master of Computer Science - University Name (2016)',
                  'Bachelor of Computer Science - College Name (2014)',
                ],
                font,
                fontSize,
                fontColor,
              ),
            ],
          ),
        );
      },
    ),
  );

  return pdf.save();
}

pw.Widget _buildSection(
  String title,
  List<String> items,
  pw.Font font,
  double fontSize,
  Color fontColor,
) {
  return pw.Column(
    crossAxisAlignment: pw.CrossAxisAlignment.start,
    children: [
      pw.SizedBox(height: 20),
      pw.Text(
        title,
        style: pw.TextStyle(
          font: font,
          fontSize: fontSize * 1.2,
          color: PdfColor.fromInt(fontColor.value),
          fontWeight: pw.FontWeight.bold,
        ),
      ),
      pw.SizedBox(height: 10),
      ...items.map(
        (item) => pw.Text(
          item,
          style: pw.TextStyle(
            font: font,
            fontSize: fontSize,
            color: PdfColor.fromInt(fontColor.value),
          ),
        ),
      ),
    ],
  );
}
