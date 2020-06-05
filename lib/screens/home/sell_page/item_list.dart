import 'package:flutter/material.dart';
import 'package:uni_cart/models/item.dart';
import 'package:provider/provider.dart';
import 'package:uni_cart/screens/home/sell_page/item_tile.dart';

class ItemList extends StatefulWidget {
  @override
  _ItemListState createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  @override
  Widget build(BuildContext context) {
    final items = Provider.of<List<Item>>(context) ?? [];

    if (items.length < 1) {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(24),
              child: Image(
                image: AssetImage('assets/images/empty.png'),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(height: 15,),
            Text('No items to display. Go to page \'Sell\' using bottom bar and add new item.')
          ],
        ),
      );
    } 
    
    else {
      return GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return ItemTile(item: items[index]);
        },
      );
    }
  }
}
