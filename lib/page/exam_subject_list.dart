import 'package:flutter/material.dart';

class ExamSubjectListPage extends StatefulWidget {
  const ExamSubjectListPage({super.key});

  @override
  State<ExamSubjectListPage> createState() => _ExamSubjectListPageState();
}

class _ExamSubjectListPageState extends State<ExamSubjectListPage> {
  // ເກັບສະຖານະການສອບເສັງຂອງແຕ່ລະວິຊາ
  final Map<String, bool> _completionStatus = {
    'ວິຊາ Flutter': false,
    'ວິຊາ HTML/CSS': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ລາຍຊື່ວິຊາສອບເສັງ SIT',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        backgroundColor: const Color(0xFF3F51B5), // Indigo
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSubjectCard(
            context,
            'ວິຊາ Flutter',
            Colors.blue,
          ),
          const SizedBox(height: 12),
          _buildSubjectCard(
            context,
            'ວິຊາ HTML/CSS',
            Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, String title, Color iconColor) {
    final isDone = _completionStatus[title] ?? false;
    final subtitle = isDone ? 'ສອບເສັງແລ້ວ' : 'ຄລິກເພື່ອເຂົ້າສອບເສັງ';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: iconColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            isDone ? Icons.check_circle : Icons.assignment,
            color: isDone ? Colors.green : iconColor,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: isDone ? Colors.green : Colors.grey[600],
            fontSize: 14,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () async {
          final result = await Navigator.pushNamed(
            context,
            '/exam-detail',
            arguments: title,
          );
          
          if (result == true) {
            setState(() {
              _completionStatus[title] = true;
            });
          }
        },
      ),
    );
  }
}
