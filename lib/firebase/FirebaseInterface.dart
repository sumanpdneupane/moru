import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class FirebaseInterface {
  FirebaseFirestore? _instance;

  FirebaseFirestore get getInstance {
    return FirebaseFirestore.instance;
  }

  @visibleForTesting
  FirebaseFirestore getMockInstance(FirebaseFirestore? firebaseFirestore) {
    _instance = firebaseFirestore;
    return _instance!;
  }

  SetOptions setOptions = SetOptions(merge: true);

  GetOptions getOptions(String connectionName) {
    return GetOptions(
      source: connectionName == 'ConnectivityResult.none'
          ? Source.cache
          : Source.serverAndCache,
    );
  }
}
