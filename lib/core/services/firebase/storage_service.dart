import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage;

  StorageService(this._storage);

  Future<String> uploadImage({
    required String path,
    required List<int> bytes,
  }) async {
    final ref = _storage.ref().child(path);
    final uploadTask = ref.putData(Uint8List.fromList(bytes));
    final snapshot = await uploadTask;
    return snapshot.ref.getDownloadURL();
  }
}
