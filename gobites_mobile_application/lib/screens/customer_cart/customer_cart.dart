import 'package:flutter/material.dart';
import 'package:gobites/app/dependencies.dart';
import 'package:gobites/models/cart.dart';
import 'package:gobites/screens/customer_cart/customer_cart_viewmodel.dart';
import 'package:gobites/screens/view.dart';

// class CartPage extends StatefulWidget {
//   @override
//   _CartPageState createState() => _CartPageState();
// }

// List<Cart> parseCart(String responseBody) {
//   final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

//   return parsed.map<Cart>((json) => Cart.fromJson(json)).toList();
// }

// Future<List<Cart>> fetchCart() async {
//   final response = await http_get('/viewcart/' + cust.CID.toString());
//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return parseCart(response.body);
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load, code = ' + response.statusCode.toString());
//   }
// }

// class _CartPageState extends State<CartPage> {
//   Future<CustDetail> futureCustDetail;
//   bool _isButtonDisabled;
//   double _totalPrice;

//   cartItemDelete(int kid) async {
//     final msg = jsonEncode({
//       /*"itemName": itemName,
//       "itemPrice": itemPrice,
//       "itemPhoto": "default.png",
//       "itemDesc": itemDesc,*/
//       "KID": kid,
//     });
//     final result = await http_post("/cartdelete", msg);
//     String status = jsonDecode(result.body);
//     //String status = loginResult.getStatus();
//     if (status == "Delete Sucessful") {
//       showDialog<void>(
//           context: context,
//           barrierDismissible: false,
//           builder: (BuildContext context) => AlertDialog(
//                 title: Text("Delete Successful"),
//                 actions: <Widget>[
//                   TextButton(
//                     child: Text('Continue'),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       Navigator.pushReplacement(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   new CartPage()));
//                     },
//                   )
//                 ],
//               ));
//     } else {
//       // AlertDialog(
//       //   title: Text(status),
//       //   actions: <Widget>[
//       //     TextButton(
//       //       child: Text('Continue'),
//       //       onPressed: () {
//       //         Navigator.of(context).pop();
//       //       },
//       //     ),
//       //   ],
//       // );
//     }
//   }

//   @override
//   void initState() {
//     _isButtonDisabled = false;
//     super.initState();
//   }

class CustomerCart extends StatelessWidget {
  static route() => MaterialPageRoute(builder: (context) => CustomerCart());

  @override
  Widget build(BuildContext context) {
    return ConsumerView(
        viewmodel: dependency<CustomerCartViewmodel>()..init(),
        builder: (context, viewmodel, _) {
          CustomerCartViewmodel _viewmodel = viewmodel;
          return Scaffold(
              body: Column(children: [
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20),
              child: Stack(children: [
                Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.orange,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back, color: Colors.white)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text("My Cart",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 30))),
                )
              ]),
            ),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: cartListView(context, _viewmodel.cartList,
                        _viewmodel.totalPrice, _viewmodel.deleteCardItem))),
          ]));
        });
  }

  Widget cartListView(BuildContext context, List<Cart> carts, double totalPrice,
      Function deleteCardItem) {
    return Stack(children: <Widget>[
      Container(
          padding: EdgeInsets.only(bottom: 70),
          child: ListView.builder(
              padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
              itemCount: carts.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 4.0,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              flex: 2,
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage('assets/default.png'),
                                radius: 30.0,
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Text(carts[index].itemName),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                  child:
                                      Text(carts[index].quantity.toString())),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                    'RM ${carts[index].itemPrice.toStringAsFixed(2)}'),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Icon(Icons.delete),
                                color: Colors.black,
                                onPressed: () {
                                  deleteAlertDialog(
                                      context: context,
                                      onDelete: () {
                                        deleteCardItem(carts[index].kid);
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    'One Item is successfully remove from the cart.')));
                                      });
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              })),
      Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          padding: EdgeInsets.symmetric(vertical: 10),
          width: double.infinity,
          child: RaisedButton(
            child: Text(
              'Total (RM ${totalPrice.toStringAsFixed(2)}) \n Check Out',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
            onPressed: () {
              carts.length == 0 ? null : null;
              // Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) =>
              //               Checkoutpage(totalPrice: _totalPrice)));
            },
            color: Colors.orange,
            textColor: Colors.white,
          ),
        ),
      )
    ]);
  }

  deleteAlertDialog({BuildContext context, Function onDelete}) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget yesButton = FlatButton(
      child: Text("Yes"),
      onPressed: onDelete,
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Item"),
      content: Text("Are you sure to delete this item?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
