import 'package:flutter/material.dart';


class OrderPage extends StatefulWidget {
  final String foodName;
  final String foodPrice;
  final String foodImage;

  // Constructor to receive the data
  const OrderPage({
    required this.foodName,
    required this.foodPrice,
    required this.foodImage,
    Key? key,
  }) : super(key: key);

  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  int quantity = 1;
  late double pricePerItem;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    pricePerItem = double.parse(widget.foodPrice.replaceAll('Rp ', '').replaceAll('.', ''));
    totalPrice = pricePerItem * quantity;
  }

  void updateQuantity(int newQuantity) {
    setState(() {
      quantity = newQuantity;
      totalPrice = pricePerItem * quantity;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Page'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  widget.foodImage,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  widget.foodName,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Price per item: ${widget.foodPrice}',
                  style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Quantity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: quantity > 1 ? () => updateQuantity(quantity - 1) : null,
                              ),
                              Text('$quantity', style: const TextStyle(fontSize: 24)),
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () => updateQuantity(quantity + 1),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        'Total Price: Rp ${totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirm Order'),
                        content: Text(
                          'You are about to order ${widget.foodName} x$quantity\nTotal: Rp ${totalPrice.toStringAsFixed(0)}',
                        ),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('Confirm'),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Confirm Order'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
