import 'dart:ffi';

class dbModel
{
  String?product,image,qua,id,price;


  dbModel({this.product,this.price,this.qua,this.id,this.image});
  factory dbModel.mapToModel(Map m1, String Docid)
  {
    return dbModel(id:Docid ,product:m1['product'] ,price:m1['price'] ,qua:m1['qua'],image: m1['image']);
  }
}