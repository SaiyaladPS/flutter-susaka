import 'package:flutter/material.dart';

class CallList extends StatefulWidget {
  const CallList({super.key});

  @override
  State<CallList> createState() => _CallListState();
}

class _CallListState extends State<CallList> {
  static const List<_CallEntry> _sampleCalls = [
    _CallEntry(
      name: 'ໄຊຍະລາດ',
      phone: '+856 20 5566 1122',
      timeLabel: '09:15 AM',
      dateLabel: 'Today',
      type: _CallType.incoming,
      duration: '12 min',
      avatarColor: Color(0xFFF57C00),
    ),
    _CallEntry(
      name: 'ໄຊຊະນະ',
      phone: 'ນັກຮຽນ IT ປີ 2',
      timeLabel: '08:40 AM',
      dateLabel: 'Today',
      type: _CallType.missed,
      duration: 'Missed',
      avatarColor: Color(0xFFD84315),
    ),
    _CallEntry(
      name: 'ສົມພານ',
      phone: 'ນັກຮຽນ IT ປີ 2',
      timeLabel: 'Yesterday',
      dateLabel: 'Apr 22',
      type: _CallType.outgoing,
      duration: '26 min',
      avatarColor: Color(0xFF1565C0),
    ),
    _CallEntry(
      name: 'ຂຽວຄຳ',
      phone: 'ນັກຮຽນ IT ປີ 2',
      timeLabel: 'Yesterday',
      dateLabel: 'Apr 22',
      type: _CallType.incoming,
      duration: '4 min',
      avatarColor: Color(0xFF2E7D32),
    ),
    _CallEntry(
      name: 'Delivery Rider',
      phone: 'ນັກຮຽນ IT ປີ 2',
      timeLabel: '04:25 PM',
      dateLabel: 'Apr 21',
      type: _CallType.missed,
      duration: 'Missed',
      avatarColor: Color(0xFF6A1B9A),
    ),
    _CallEntry(
      name: 'Sisavath',
      phone: 'ນັກຮຽນ IT ປີ 2',
      timeLabel: '01:10 PM',
      dateLabel: 'Apr 21',
      type: _CallType.outgoing,
      duration: '8 min',
      avatarColor: Color(0xFF00838F),
    ),
    _CallEntry(
      name: 'Office Admin',
      phone: 'ນັກຮຽນ IT ປີ 2',
      timeLabel: '11:58 AM',
      dateLabel: 'Apr 20',
      type: _CallType.incoming,
      duration: '16 min',
      avatarColor: Color(0xFF5D4037),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final missedCount = _sampleCalls
        .where((entry) => entry.type == _CallType.missed)
        .length;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),
      appBar: AppBar(
        title: const Text(
          'ລາຍການການໂທ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFA726), Color(0xFFF57C00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.call, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Call History',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'ມີຂໍ້ມູນຕົວຢ່າງ ${_sampleCalls.length} ລາຍການ, ພາດສາຍ $missedCount ລາຍການ',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Noto Sans Lao',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              itemCount: _sampleCalls.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final call = _sampleCalls[index];
                return _CallListTile(entry: call);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add, size: 30),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
    );
  }
}

class _CallListTile extends StatelessWidget {
  const _CallListTile({required this.entry});

  final _CallEntry entry;

  @override
  Widget build(BuildContext context) {
    final typeColor = switch (entry.type) {
      _CallType.incoming => Colors.green,
      _CallType.outgoing => Colors.blue,
      _CallType.missed => Colors.red,
    };

    final typeIcon = switch (entry.type) {
      _CallType.incoming => Icons.call_received_rounded,
      _CallType.outgoing => Icons.call_made_rounded,
      _CallType.missed => Icons.call_missed_rounded,
    };

    final typeLabel = switch (entry.type) {
      _CallType.incoming => 'Incoming',
      _CallType.outgoing => 'Outgoing',
      _CallType.missed => 'Missed',
    };

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          radius: 26,
          backgroundColor: entry.avatarColor,
          child: Text(
            entry.name.substring(0, 1),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        title: Text(
          entry.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(entry.phone),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(typeIcon, size: 16, color: typeColor),
                  const SizedBox(width: 6),
                  Text(
                    '$typeLabel • ${entry.duration}',
                    style: TextStyle(
                      color: typeColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              entry.timeLabel,
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
            ),
            const SizedBox(height: 4),
            Text(
              entry.dateLabel,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _CallEntry {
  const _CallEntry({
    required this.name,
    required this.phone,
    required this.timeLabel,
    required this.dateLabel,
    required this.type,
    required this.duration,
    required this.avatarColor,
  });

  final String name;
  final String phone;
  final String timeLabel;
  final String dateLabel;
  final _CallType type;
  final String duration;
  final Color avatarColor;
}

enum _CallType { incoming, outgoing, missed }
