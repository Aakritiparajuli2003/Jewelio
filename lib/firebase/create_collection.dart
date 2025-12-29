import 'package:flutter/material.dart';
import 'package:jewelio/firebase/firebase_services.dart';


class CreateCollectionsPage extends StatelessWidget {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Collections")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await firestoreService.createAllCollections();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("All collections created!"))
            );
          },
          child: Text("Create Firestore Collections"),
        ),
      ),
    );
  }
}
