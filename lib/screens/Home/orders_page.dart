import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant/models/order_in_card.dart';
import '../../models/category_list.dart';
import '../../services/firebase.dart';

class OrdersPage extends StatefulWidget {

  OrdersPage({Key? key}) : super(key: key);

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final DataService dataService = DataService();


  @override
  Widget build(BuildContext context) {
    double total = 0;
    var user = Provider.of<User>(context);
    return FutureBuilder(
      future: dataService.getProductList(user.uid),
      builder:(context, snapshot) {
        if (snapshot.hasData) {
        var productList = snapshot.data!;
        if (productList.length == 0) {
          return Text('Your list is empty', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),);
        }
        else {
          return Scaffold(
            body: ListView.builder(
              itemCount: productList.length,
              itemBuilder:(context, index) {
              return OrderInCardWidget(
                orderInCard: OrderInCard(userId: user.uid, product: Product(id: 0,name:productList[index]['name'],image_url: '', price: productList[index]['price'], description: '',), quantity: productList[index]['quantity']), 
                onRemove: (product) async {
                  await dataService.deleteAProduct(user.uid, productList[index]['id']);
                  setState(() {
                    productList.removeWhere((item) => item['id'] == product.id);
                  });
                },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.shopping_bag),
              onPressed: () {
                total = 0;
                for (var item in productList) {
                  total += item['price'] * item['quantity'];
                }
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Total'),
                      content: Text('The total is $total.'),
                      actions: [
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
          ),
          );
        }
      }
      else if (snapshot.hasError) {
        return const Text('There was an error while rendring the data');
      }
      else {
        return const CircularProgressIndicator();
      }
      },
    );
  }
}

class OrderInCardWidget extends StatelessWidget {
  final Function onRemove;
  OrderInCard orderInCard;
  OrderInCardWidget({Key? key, required this.orderInCard, required this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("${orderInCard.quantity}x"),
                )),
            Expanded(
                flex: 6,
                child: Text(
                  orderInCard.product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 2,
                child: Text("\$${(orderInCard.product.price * orderInCard.quantity).toStringAsFixed(2)}"),
                ),
            Expanded(
                flex: 1,
                child: IconButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      onRemove(orderInCard.product);
                    },
                    icon: const Icon(Icons.delete)))
          ],
        ),
      ),
    );
  }
}


class DialogExample extends StatelessWidget {
  double total;
  DialogExample({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
          title: const Text('Total'),
          content: Text('The total is $total'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              child: const Text('OK'),
            ),
          ],
        );
  }
}




    /*    body: ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            String user = snapshot.data![index];
            return ListTile(
              title: Text('1 * ${user['name']} = ${user['price'].toString()}'),
              subtitle: Text('-------------'),
            );
          },
        ),
    return StreamBuilder(
      stream: DataService().getBoughtElementsOfUser(user.uid),
      builder: ((context, snapshot) {
          return Scaffold(
            appBar: AppBar(title: Text('My Bill'),),
            body: Container(),
            body: Column(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data == null ? 0 : snapshot.data!.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = snapshot.data![index];
                    total += document["price"];
                    print(total);
                    return Column(
                      children: [
                        ListTile(
                          title: Text(document["name"]),
                          subtitle: Text(document["price"].toString()),
                        ),
                        if (index == snapshot.data!.length - 1) ...[
                          Text('total is ${total.toString()}'),
                        ],
                      ],
                    );
                  },
                ),
              ],
            ),
        );
      }),
    );*/