import 'package:flutter/material.dart';

class CrudPage extends StatefulWidget {
  const CrudPage({super.key});

  @override
  State<CrudPage> createState() => _CrudPageState();
}

class _CrudPageState extends State<CrudPage> {
  final List<String> _items = [];
  final TextEditingController _addController = TextEditingController();
  final TextEditingController _editController = TextEditingController();

  void _addItem() {
    if (_addController.text.isNotEmpty) {
      setState(() {
        _items.add(_addController.text);
        _addController.clear();
      });
    }
  }

  void _editItem(int index) {
    _editController.text = _items[index];
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'ແກ້ໄຂຂໍ້ມູນ',
            style: TextStyle(fontFamily: 'Noto Sans Lao'),
          ),
          content: TextField(
            controller: _editController,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'ປ້ອນຂໍ້ມູນທີ່ຕ້ອງການແກ້ໄຂ',
              hintStyle: TextStyle(fontFamily: 'Noto Sans Lao'),
            ),
            style: const TextStyle(fontFamily: 'Noto Sans Lao'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _editController.clear();
                Navigator.pop(context);
              },
              child: const Text(
                'ຍົກເລີກ',
                style: TextStyle(fontFamily: 'Noto Sans Lao'),
              ),
            ),
            TextButton(
              onPressed: () {
                if (_editController.text.isNotEmpty) {
                  setState(() {
                    _items[index] = _editController.text;
                  });
                  _editController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text(
                'ບັນທຶກ',
                style: TextStyle(fontFamily: 'Noto Sans Lao'),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteItem(int index) {
    setState(() {
      _items.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _addController,
                    decoration: const InputDecoration(
                      hintText: 'ເພີ່ມຂໍ້ມູນໃໝ່...',
                      hintStyle: TextStyle(fontFamily: 'Noto Sans Lao'),
                      border: OutlineInputBorder(),
                    ),
                    style: const TextStyle(fontFamily: 'Noto Sans Lao'),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _addItem,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  child: const Text(
                    'ເພີ່ມ',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Noto Sans Lao',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _items.isEmpty
                  ? const Center(
                      child: Text(
                        'ຍັງບໍ່ມີຂໍ້ມູນ',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey,
                          fontFamily: 'Noto Sans Lao',
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _items.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(
                              _items[index],
                              style: const TextStyle(fontFamily: 'Noto Sans Lao'),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.blue,
                                  ),
                                  onPressed: () => _editItem(index),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                  onPressed: () => _deleteItem(index),
                                ),
                              ],
                            ),
                          ),
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
    _editController.dispose();
    super.dispose();
  }
}
