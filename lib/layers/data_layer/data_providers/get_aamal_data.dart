import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:islamisbest/layers/data_layer/models/aamal_model.dart';

class GetAamalData {
  Future<List<AamalModel>> getAamalData() async {
    List<AamalModel> aamalList = [];
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    QuerySnapshot data = await firestore.collection('Amal').get();

    aamalList = data.docs
        .map((doc) => AamalModel(
              aamalId: doc.data()['aamalId'],
              aamalInfo: doc.data()['aamalInfo'],
              aamalNumber: doc.data()['aamalNumber'],
              aamalText: doc.data()['aamalText'],
            ))
        .toList();

    return aamalList;
  }
}
