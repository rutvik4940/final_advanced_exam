import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalexam/screen/home/model/db_model.dart';

class FBHelper
{
  static FBHelper helper =FBHelper._();
  FBHelper._();
  var db=FirebaseFirestore.instance;
  Future<void> add(dbModel model)
  async {
    await db.collection("shop").add({"product":model.product,"price":model.price,"qua":model.qua,"image":model.image});
  }
  Future<List<dbModel>> read()
  async {
    QuerySnapshot qds=await db.collection("shop").get();
    List<QueryDocumentSnapshot<Object?>> qd=qds.docs;
    List<dbModel> model=qd.map((e) => dbModel.mapToModel(e.data()! as Map,e.id),).toList();
    return model;
  }
  Future<void> update(dbModel model)
  async {
    await db.collection("shop").doc(model.id).set({"product":model.product,"price":model.price,"qua":model.qua,"image":model.image});
  }
  Future<void> delete(String dId)
  async {
    await db.collection("shop").doc(dId).delete();
  }
}