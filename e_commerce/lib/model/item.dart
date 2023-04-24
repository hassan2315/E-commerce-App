class Item {
  String imgPath;
  double price;
  String location;
  String name;
  bool isFavorite;

  Item({
    required this.imgPath,
    required this.price,
    required this.location,
    required this.name,
    this.isFavorite = false,
  });

  get id => null;
}

final List<Item> items = [
  Item(
      name: "item1",
      price: 12.99,
      imgPath: "Assets/p1.jpg",
      location: "Armani shop"),
  Item(
      name: "item2",
      price: 13.99,
      imgPath: "Assets/p2.jpg",
      location: "American shop"),
  Item(
      name: "item3",
      price: 14.99,
      imgPath: "Assets/p3.webp",
      location: "CK shop"),
  Item(
      name: "item4",
      price: 11.99,
      imgPath: "Assets/p4.jpg",
      location: "CK shop"),
  Item(
      name: "item5",
      price: 15.99,
      imgPath: "Assets/p5.jpg",
      location: "Armani shop"),
  Item(
      name: "item6",
      price: 19.99,
      imgPath: "Assets/p6.jpg",
      location: "Armani shop"),
  Item(
      name: "item7",
      price: 10.99,
      imgPath: "Assets/p7.webp",
      location: "American shop"),
  Item(
      name: "item8",
      price: 9.99,
      imgPath: "Assets/p8.webp",
      location: "CK shop"),
];
