import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:parcial04/pages/update_client_page.dart';

class ListClientPage extends StatefulWidget {
  ListClientPage({Key? key}) : super(key: key);

  @override
  _ListClientPageState createState() => _ListClientPageState();
}

class _ListClientPageState extends State<ListClientPage> {
  final Stream<QuerySnapshot> clientsStream =
  FirebaseFirestore.instance.collection('clients').snapshots();

  CollectionReference clients =
  FirebaseFirestore.instance.collection('clients');
  Future<void> deleteUser(id) {
    return clients
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: clientsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          print('Something went Wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List storedocs = [];
        snapshot.data!.docs.map((DocumentSnapshot document) {
          Map a = document.data() as Map<String, dynamic>;
          storedocs.add(a);
          a['id'] = document.id;
        }).toList();

        return Container(
          margin: EdgeInsets.only(bottom: 20.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              border: TableBorder(
                horizontalInside: BorderSide(color: Colors.black.withOpacity(0.2), width: 1.0, style: BorderStyle.solid),
                verticalInside: BorderSide.none,
              ),
              children: [
                _buildTableRow([
                  _buildTableCell('Name', isHeader: true),
                  _buildTableCell('Email', isHeader: true),
                  _buildTableCell('Action', isHeader: true),
                ]),
                for (var i = 0; i < storedocs.length; i++) ...[
                  _buildTableRow([
                    _buildTableCell(storedocs[i]['name']),
                    _buildTableCell(storedocs[i]['email']),
                    _buildActionTableCell(storedocs[i]['id']),
                  ], isOdd: i.isOdd),
                ],
              ],
            ),
          ),
        );

      },
    );
  }

  TableRow _buildTableRow(List<Widget> cells, {bool isOdd = false}) {
    return TableRow(
      decoration: BoxDecoration(
        color: isOdd ? Colors.lightBlue[50]?.withOpacity(0.7) : null,
      ),
      children: cells,
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false, bool borderBottom = false}) {
    return Center(
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          border: Border(
            bottom: isHeader && borderBottom ? BorderSide(color: Colors.black, width: 1.0, style: BorderStyle.solid) : BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
            color: isHeader ? Colors.grey[800] : Colors.black,
          ),
        ),
      ),
    );
  }
  Widget _buildActionTableCell(String id) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateClientPage(
                  id: id,
                ),
              ),
            );
          },
          icon: Icon(
            Icons.edit,
            color: Colors.orange.withOpacity(0.7),
          ),
        ),
        IconButton(
          onPressed: () => deleteUser(id),
          icon: Icon(
            Icons.delete,
            color: Colors.red.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}