class dbModel
{
  String?product,image,price,qua;
  int?id;

  dbModel({this.product,this.price,this.qua,this.id,this.image});
  factory dbModel.mapToModel(Map m1)
  {
    return dbModel(id:m1['id'] ,product:m1['product'] ,price:m1['price'] ,qua:m1['qua'],image: m1['image']);
  }
}