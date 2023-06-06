import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = 'a';
  String _password = 'a';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
                onSaved: (value) {
                  _username = value!;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a password';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    if (_username == "a" && _password == "a") {
                      // Perform successful login logic here
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MenuPage()),
                      );
                    } else {
                      // Display login error message
                      print("Invalid username or password");
                    }
                  }
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FoodItem {
  final String name;
  final double price;
  final String description;
  final String imagePath;

  FoodItem({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
  });
}

class MenuPage extends StatefulWidget {
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<FoodItem> _foodItems = [
    FoodItem(
      name: 'Meal-Deal Burger',
      price: 2.70,
      description: 'Delicious cheeseburger with juicy patty, comes with chips!',
      imagePath:
          'https://c8.alamy.com/comp/B8RAGM/cheeseburger-isolated-on-a-white-studio-background-B8RAGM.jpg', // Replace with actual image path or URL
    ),
    FoodItem(
      name: 'Meal-Deal Pizza',
      price: 2.70,
      description: 'Cheesy pizza with pepperoni or just cheese and fries',
      imagePath:
          'https://images-gmi-pmc.edge-generalmills.com/2a88c35a-1c88-470b-bc52-ea014206bd46.jpg', // Replace with actual image path or URL
    ),
    FoodItem(
      name: 'Main meat',
      price: 3.50,
      description: 'Chicken curry',
      imagePath:
          'https://hips.hearstapps.com/del.h-cdn.co/assets/17/31/1501791674-delish-chicken-curry-horizontal.jpg?crop=0.665xw:0.998xh;0.139xw,0.00240xh&resize=1200:*', // Replace with actual image path or URL
    ),
    FoodItem(
      name: 'Dessert',
      price: 1.90,
      description: 'Sweet and rich brownie',
      imagePath:
      'https://www.inspiredtaste.net/wp-content/uploads/2022/05/Chewy-Brownie-Recipe-3-1200.jpg', // Replace with actual image path or URL
    ),
  ];

  List<FoodItem> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    var _scrollController;
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: Scrollbar(
        controller: _scrollController,
        child: ListView.builder(
          controller: _scrollController,
          itemCount: _foodItems.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Image.network(
                _foodItems[index].imagePath,
                width: 80,
                height: 80,
              ),
              title: Text(_foodItems[index].name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_foodItems[index].description),
                  Text(
                    '\$${_foodItems[index].price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              trailing: Checkbox(
                value: _selectedItems.contains(_foodItems[index]),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      _selectedItems.add(_foodItems[index]);
                    } else {
                      _selectedItems.remove(_foodItems[index]);
                    }
                  });
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SummaryPage(orderList: _selectedItems),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final List<FoodItem> orderList;

  SummaryPage({required this.orderList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
      ),
      body: ListView.builder(
        itemCount: orderList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(orderList[index].name),
            subtitle: Text(orderList[index].description),
            trailing: Text('\$${orderList[index].price.toStringAsFixed(2)}'),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // TODO: Implement checkout logic
          },
          child: const Text('Checkout'),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
