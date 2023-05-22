import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(
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
              SizedBox(height: 16.0),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
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
              SizedBox(height: 24.0),
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
                child: Text('Login'),
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
      name: 'Burger',
      price: 9.99,
      description: 'Delicious burger with juicy patty',
      imagePath:
          'assets/images/burger.jpg', // Replace with actual image path or URL
    ),
    FoodItem(
      name: 'Pizza',
      price: 12.99,
      description: 'Cheesy pizza with various toppings',
      imagePath:
          './assets/images/pizza.jpg', // Replace with actual image path or URL
    ),
    FoodItem(
      name: 'Salad',
      price: 6.99,
      description: 'Fresh and healthy salad',
      imagePath:
          'assets/images/salad.jpg', // Replace with actual image path or URL
    ),
  ];

  List<FoodItem> _selectedItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),
      ),
      body: ListView.builder(
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
        title: Text('Order Summary'),
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}
