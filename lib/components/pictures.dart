import 'package:flutter/material.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key key}) : super(key: key);

  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  var product_list = [
    {
      'picture': 'assets/images/blazer1.jpeg',
    },
    {
      'picture': 'assets/images/dress1.jpeg',
    },
    {
      'picture': 'assets/images/hills1.jpeg',
    },
    {
      'picture': 'assets/images/shoe1.jpg',
    },
    {
      'picture': 'assets/images/blazer2.jpeg',
    },
    {
      'picture': 'assets/images/hills2.jpeg',
    },
    {
      'picture': 'assets/images/dress2.jpeg',
    },
    {
      'picture': 'assets/images/pants1.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: product_list.length,
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 2, right: 2),
            child: single_product(
              product_picture: product_list[index]['picture'],
            ),
          );
        });
  }
}

class single_product extends StatelessWidget {
  final product_picture;

  single_product({this.product_picture});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Hero(
          tag: Text('product'),
          child: Material(
            child: InkWell(
              // onTap: () => Navigator.of(context).push(
              //   // we passing the value to product details
              //     MaterialPageRoute(builder: (context) => ProductDetails(
              //
              //       product_detail_picture: product_picture,
              //
              //     ))),
              child: GridTile(
                footer: Container(
                  alignment: Alignment.centerLeft,
                  height: 40,
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(child: GestureDetector(
                          child: Icon(Icons.save))),
                      InkWell(
                          onTap: (){},
                          child: InkWell(
                              onTap: (){},
                              child: Icon(Icons.share))),
                    ],
                  ),

                ),
                child: Image.asset(
                  product_picture,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          )),
    );
  }
}
