import 'package:flutter/material.dart';
import 'package:gobites/models/menu.dart';

Card customCard(Menu menu, Function onUpdate, Function onDelete) {
  return Card(
    elevation: 4.0,
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          menu.name,
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text('RM ${menu.price.toStringAsFixed(2)}')
                      ],
                    ),
                  )),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.edit),
                  color: Colors.black,
                  onPressed: onUpdate,
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: Icon(Icons.delete),
                  color: Colors.black,
                  onPressed: onDelete,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
