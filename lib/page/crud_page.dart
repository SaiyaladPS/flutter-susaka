import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final List<_CrudItem> _items = [
    _CrudItem(title: 'ລາຍງານປະຈຳວັນ', createdAt: DateTime(2026, 4, 23, 9, 10)),
    _CrudItem(title: 'ລາຍຊື່ລູກຄ້າ', createdAt: DateTime(2026, 4, 22, 14, 20)),
    _CrudItem(title: 'ສະຫຼຸບການຂາຍ', createdAt: DateTime(2026, 4, 21, 16, 45)),
  ];

  final TextEditingController _addController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  String _searchQuery = '';

  List<_CrudItem> get _filteredItems {
    final query = _searchQuery.trim().toLowerCase();
    if (query.isEmpty) return _items;
    return _items
        .where((item) => item.title.toLowerCase().contains(query))
        .toList();
  }

  void _addItem() {
    final text = _addController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _items.insert(0, _CrudItem(title: text, createdAt: DateTime.now()));
      _addController.clear();
    });

    _showMessage('ເພີ່ມຂໍ້ມູນແລ້ວ');
  }

  Future<void> _showEditItemSheet(_CrudItem item) async {
    final controller = TextEditingController(text: item.title);

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return SafeArea(
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'ແກ້ໄຂຂໍ້ມູນ',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Noto Sans Lao',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'ປັບປຸງຂໍ້ມູນໃຫ້ເປັນປັດຈຸບັນ',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                    const SizedBox(height: 18),
                    TextField(
                      controller: controller,
                      autofocus: true,
                      decoration: InputDecoration(
                        labelText: 'ຂໍ້ມູນ',
                        labelStyle: const TextStyle(
                          fontFamily: 'Noto Sans Lao',
                        ),
                        prefixIcon: const Icon(Icons.edit_note_rounded),
                        filled: true,
                        fillColor: const Color(0xFFFFF6EE),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontFamily: 'Noto Sans Lao'),
                      onSubmitted: (_) {
                        _updateItem(item, controller.text);
                        Navigator.pop(sheetContext);
                      },
                    ),
                    const SizedBox(height: 18),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          _updateItem(item, controller.text);
                          Navigator.pop(sheetContext);
                        },
                        icon: const Icon(Icons.save_rounded),
                        label: const Text(
                          'ບັນທຶກການແກ້ໄຂ',
                          style: TextStyle(fontFamily: 'Noto Sans Lao'),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );

    controller.dispose();
  }

  void _updateItem(_CrudItem item, String value) {
    final text = value.trim();
    if (text.isEmpty) return;

    setState(() {
      final index = _items.indexOf(item);
      if (index != -1) {
        _items[index] = item.copyWith(title: text);
      }
    });

    _showMessage('ແກ້ໄຂຂໍ້ມູນແລ້ວ');
  }

  void _deleteItem(_CrudItem item) {
    final index = _items.indexOf(item);
    if (index == -1) return;

    setState(() {
      _items.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'ລົບຂໍ້ມູນແລ້ວ',
          style: TextStyle(fontFamily: 'Noto Sans Lao'),
        ),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _items.insert(index, item);
            });
          },
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontFamily: 'Noto Sans Lao'),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '${date.day} ${months[date.month - 1]} ${date.year} • $hour:$minute';
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = _filteredItems;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F1),
      appBar: AppBar(
        title: const Text(
          'ຈັດການຂໍ້ມູນ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.orange,
        elevation: 10,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25)),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFB74D), Color(0xFFF57C00)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withValues(alpha: 0.25),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor: Colors.white24,
                              child: Icon(
                                Icons.dataset_linked_rounded,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Smart CRUD Manager',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'ເພີ່ມ, ຄົ້ນຫາ, ແກ້ໄຂ ແລະ ລົບຂໍ້ມູນໄດ້ຈາກຫນ້າດຽວ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Noto Sans Lao',
                          ),
                        ),
                        const SizedBox(height: 18),
                        Row(
                          children: [
                            Expanded(
                              child: _SummaryCard(
                                label: 'ທັງໝົດ',
                                value: _items.length.toString(),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: _SummaryCard(
                                label: 'ຜົນຄົ້ນຫາ',
                                value: filteredItems.length.toString(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'ຄົ້ນຫາຂໍ້ມູນ...',
                        hintStyle: const TextStyle(fontFamily: 'Noto Sans Lao'),
                        prefixIcon: const Icon(Icons.search_rounded),
                        suffixIcon: _searchQuery.isEmpty
                            ? null
                            : IconButton(
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                                icon: const Icon(Icons.close_rounded),
                              ),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(fontFamily: 'Noto Sans Lao'),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 16,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _addController,
                            textInputAction: TextInputAction.done,
                            decoration: InputDecoration(
                              hintText: 'ເພີ່ມຂໍ້ມູນໃໝ່...',
                              hintStyle: const TextStyle(
                                fontFamily: 'Noto Sans Lao',
                              ),
                              prefixIcon: const Icon(Icons.note_add_rounded),
                              filled: true,
                              fillColor: const Color(0xFFFFF6EE),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(18),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            style: const TextStyle(fontFamily: 'Noto Sans Lao'),
                            onSubmitted: (_) => _addItem(),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: _addItem,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 18,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.add_rounded),
                              SizedBox(width: 6),
                              Text(
                                'ເພີ່ມ',
                                style: TextStyle(fontFamily: 'Noto Sans Lao'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (filteredItems.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: _EmptyState(hasQuery: _searchQuery.isNotEmpty),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                sliver: SliverList.separated(
                  itemCount: filteredItems.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = filteredItems[index];
                    return _CrudItemCard(
                      index: index,
                      title: item.title,
                      dateText: _formatDate(item.createdAt),
                      onEdit: () => _showEditItemSheet(item),
                      onDelete: () => _deleteItem(item),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _addController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Noto Sans Lao',
            ),
          ),
        ],
      ),
    );
  }
}

class _CrudItemCard extends StatelessWidget {
  const _CrudItemCard({
    required this.index,
    required this.title,
    required this.dateText,
    required this.onEdit,
    required this.onDelete,
  });

  final int index;
  final String title;
  final String dateText;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 14,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 10,
        ),
        leading: CircleAvatar(
          radius: 24,
          backgroundColor: Colors.orange.withValues(alpha: 0.12),
          child: Text(
            '${index + 1}',
            style: const TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            fontFamily: 'Noto Sans Lao',
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Row(
            children: [
              Icon(
                Icons.schedule_rounded,
                size: 16,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  dateText,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_rounded, color: Colors.blue),
            ),
            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_rounded, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.hasQuery});

  final bool hasQuery;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 38,
              backgroundColor: Colors.orange.withValues(alpha: 0.12),
              child: Icon(
                hasQuery ? Icons.search_off_rounded : Icons.inbox_rounded,
                size: 40,
                color: Colors.orange,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              hasQuery ? 'ບໍ່ພົບຂໍ້ມູນ' : 'ຍັງບໍ່ມີຂໍ້ມູນ',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Noto Sans Lao',
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasQuery
                  ? 'ລອງປ່ຽນຄຳຄົ້ນຫາ ຫຼື ເພີ່ມລາຍການໃໝ່'
                  : 'ໃສ່ຂໍ້ມູນດ້ານເທິງເພື່ອເລີ່ມຕົ້ນ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 14,
                fontFamily: 'Noto Sans Lao',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CrudItem {
  const _CrudItem({required this.title, required this.createdAt});

  final String title;
  final DateTime createdAt;

  _CrudItem copyWith({String? title, DateTime? createdAt}) {
    return _CrudItem(
      title: title ?? this.title,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
