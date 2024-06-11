import 'package:dars_54/models/eslatma_model.dart';
import 'package:dars_54/views/widgets/eslatmalar.dart';
import 'package:flutter/material.dart';

class EslatmaList extends StatefulWidget {
  @override
  _EslatmaListState createState() => _EslatmaListState();
}

class _EslatmaListState extends State<EslatmaList> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Eslatma> _eslatmalar = [];

  @override
  void initState() {
    super.initState();
    _refreshEslatmalar();
  }

  void _refreshEslatmalar() async {
    final data = await _dbHelper.getEslatmalar();
    setState(() {
      _eslatmalar = data;
    });
  }

  void _addEslatma(Eslatma eslatma) async {
    await _dbHelper.insertEslatma(eslatma);
    _refreshEslatmalar();
  }

  void _deleteEslatma(int id) async {
    await _dbHelper.deleteEslatma(id);
    _refreshEslatmalar();
  }

  void _updateEslatma(Eslatma eslatma) async {
    await _dbHelper.updateEslatma(eslatma);
    _refreshEslatmalar();
  }

  void _showAddEslatmaDialog() {
    TextEditingController titleController = TextEditingController();
    TextEditingController detailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Yangi Eslatma'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Sarlavha'),
              ),
              TextField(
                controller: detailController,
                decoration: InputDecoration(labelText: 'Tafsilot'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty &&
                    detailController.text.isNotEmpty) {
                  _addEslatma(Eslatma(
                      title: titleController.text,
                      detail: detailController.text));
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Qo'shish"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Bekor qilish'),
            ),
          ],
        );
      },
    );
  }

  void _editEslatmaDialog(Eslatma eslatma) {
    TextEditingController titleController =
        TextEditingController(text: eslatma.title);
    TextEditingController detailController =
        TextEditingController(text: eslatma.detail);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Eslatmani O\'zgartirish'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Sarlavha'),
              ),
              TextField(
                controller: detailController,
                decoration: InputDecoration(labelText: 'Tafsilot'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                eslatma.title = titleController.text;
                eslatma.detail = detailController.text;
                _updateEslatma(eslatma);
                Navigator.of(context).pop();
              },
              child: Text('Saqlash'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Bekor qilish'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Eslatmalar'),
      ),
      body: ListView.builder(
        itemCount: _eslatmalar.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_eslatmalar[index].title),
            subtitle: Text(_eslatmalar[index].detail),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editEslatmaDialog(_eslatmalar[index]),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => _deleteEslatma(_eslatmalar[index].id!),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddEslatmaDialog,
        child: Icon(Icons.add),
      ),
    );
  }
}
