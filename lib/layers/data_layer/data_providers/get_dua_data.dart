import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamisbest/layers/data_layer/models/dua_model.dart';

class GetDuaData {
  List<DuaModel> duaList;
  Future<List<DuaModel>> getDuaData() async {
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    QuerySnapshot data = await fireStore.collection("Duaa").get();
    duaList = data.docs
        .map((e) => DuaModel(
            duaId: e.data()['duaId'],
            duaInfo: e.data()['duaInfo'],
            duaNumber: e.data()['duaNumber'],
            duaText: e.data()['duaText']))
        .toList();

    return duaList;
  }
}
