import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:greengrocer/src/config/app_data.dart' as appData;
import 'package:greengrocer/src/pages/orders/components/order_tile.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pedidos', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),

      body: ListView.separated(
        padding: const EdgeInsets.all(16.0),
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) =>
            // return Text(appData.orders[index].id);
            OrderTile(orderrr: appData.orders[index]),

        separatorBuilder: (_, index) => const SizedBox(height: 10.0),
        itemCount: appData.orders.length,
      ),
    );
  }
}
