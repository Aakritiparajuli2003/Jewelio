import 'package:flutter/material.dart';
import 'package:jewelio/firebase/firebase_services.dart';

class CreateCollectionsPage extends StatelessWidget {
  const CreateCollectionsPage({super.key}); // added key

  @override
  Widget build(BuildContext context) {
    final FirestoreService firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: const Text("Create Collections")),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await firestoreService.createAllCollections();
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("All collections created!")),
              );
            }
          },
          child: const Text("Create Firestore Collections"),
        ),
      ),
    );
  }
}
