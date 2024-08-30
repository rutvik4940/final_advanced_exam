class cartModel
{
  String?product,image,price,qua;
  int?id;

  cartModel({this.product,this.price,this.qua,this.id,this.image});
  factory cartModel.mapToModel(Map m1)
  {
    return cartModel(id:m1['id'] ,product:m1['product'] ,price:m1['price'] ,qua:m1['qua'],image: m1['image']);
  }
}