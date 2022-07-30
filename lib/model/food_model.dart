class FoodModel {
  String picturePath;
  String name;
  String ingredients;
  int price;

  FoodModel({
    this.picturePath,
    this.name,
    this.ingredients,
    this.price,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
        name: json['name'],
        picturePath: json['picturePath'],
        ingredients: json['ingredients'],
        price: json['price']);
  }
}
