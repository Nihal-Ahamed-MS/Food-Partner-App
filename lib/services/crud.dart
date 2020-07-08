import 'package:cloud_firestore/cloud_firestore.dart';
class Crud{

  getData() async{
    return await Firestore.instance.collection('hotelinfo').getDocuments();
  }

}