import 'package:flutter/material.dart';

class ExamDetailPage extends StatefulWidget {
  const ExamDetailPage({super.key});

  @override
  State<ExamDetailPage> createState() => _ExamDetailPageState();
}

class _ExamDetailPageState extends State<ExamDetailPage> {
  final TextEditingController _answerController = TextEditingController();

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  void _submitExam(String subjectName) {
    int score = _answerController.text.length > 10 ? 10 : 0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text(
            'ສົ່ງບົດສອບ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Noto Sans Lao',
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ວິຊາ: $subjectName',
                style: const TextStyle(fontFamily: 'Noto Sans Lao'),
              ),
              const SizedBox(height: 4),
              Text(
                'ຄຳຕອບ: ${_answerController.text}',
                style: const TextStyle(fontFamily: 'Noto Sans Lao'),
              ),
              const SizedBox(height: 4),
              Text(
                'ຄະແນນ: $score/10',
                style: const TextStyle(
                  fontFamily: 'Noto Sans Lao',
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(true); // Close page and return true
              },
              child: const Text(
                'ປິດ',
                style: TextStyle(
                  color: Colors.deepPurple,
                  fontFamily: 'Noto Sans Lao',
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get subject name from arguments, fallback if null
    final args = ModalRoute.of(context)?.settings.arguments as String?;
    final subjectName = args ?? 'ວິຊາບໍ່ຮູ້ຈັກ';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          subjectName,
          style: const TextStyle(
            color: Colors.black,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '1. Widget ໃດທີ່ໃຊ້ຈັດການ State?',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Noto Sans Lao',
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'ຈົ່ງອະທິບາຍຄຳຕອບຂອງທ່ານ:',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: 'Noto Sans Lao',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _answerController,
              maxLines: 5,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _submitExam(subjectName),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text(
                  'ສົ່ງບົດສອບ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Noto Sans Lao',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
