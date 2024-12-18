import 'package:admin_panel/Screens/appdrawer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();
  final TextEditingController _regularPriceController = TextEditingController();
  final TextEditingController _stockQuantityController =
      TextEditingController();
  final TextEditingController _discountController =
      TextEditingController(); // Added discount field

  Future<void> _addProduct() async {
    try {
      await FirebaseFirestore.instance.collection('products').add({
        'name': _nameController.text,
        'description': _descriptionController.text,
        'category': _categoryController.text,
        'brand': _brandController.text,
        'regularPrice': double.tryParse(_regularPriceController.text) ?? 0,
        'stockQuantity': int.tryParse(_stockQuantityController.text) ?? 0,
        'discount':
            double.tryParse(_discountController.text) ?? 0, // Capture discount
      });
      // Optionally clear the text fields
      _nameController.clear();
      _descriptionController.clear();
      _categoryController.clear();
      _brandController.clear();
      _regularPriceController.clear();
      _stockQuantityController.clear();
      _discountController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Product added successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add product: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7F2E4),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE7F2E4),
        elevation: 0,
        title: Center(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, color: Colors.black),
            onPressed: () {
              // Handle profile action
            },
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Products',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Home > Add New Product',
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 20),
                      _buildTextField(
                          'Product Name', _nameController, 'Type name here'),
                      _buildTextField('Description', _descriptionController,
                          'Type Description here',
                          maxLines: 3),
                      _buildTextField('Category', _categoryController,
                          'Type Category here'),
                      _buildTextField('Brand Name', _brandController,
                          'Type brand name here'),
                      Row(
                        children: [
                          Expanded(
                            child: _buildTextField('Regular Price',
                                _regularPriceController, '₹1000'),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: _buildTextField('Stock Quantity',
                                _stockQuantityController, '1258'),
                          ),
                        ],
                      ),
                      _buildTextField('Discount', _discountController,
                          'Type discount here'), // Added discount field
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: _addProduct,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFE7F2E4),
                              ),
                              child: const Text('ADD'),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                // Handle Cancel button
                                Navigator.pop(context); // Go back
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade300,
                              ),
                              child: const Text('CANCEL'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Gallery',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      DottedBorderBox(),
                      SizedBox(height: 10),
                      ProductThumbnailList(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, String placeholder,
      {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        const SizedBox(height: 5),
        TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: placeholder,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            contentPadding: const EdgeInsets.all(10),
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class DottedBorderBox extends StatelessWidget {
  const DottedBorderBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.image, size: 40, color: Colors.grey),
            SizedBox(height: 5),
            Text('Drop your image here, or browse'),
            Text('Jpeg, png are allowed'),
          ],
        ),
      ),
    );
  }
}

class ProductThumbnailList extends StatelessWidget {
  const ProductThumbnailList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildThumbnail('Product thumbnail.png'),
        _buildThumbnail('Product thumbnail.png'),
        _buildThumbnail('Product thumbnail.png'),
      ],
    );
  }

  Widget _buildThumbnail(String fileName) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        color: Colors.grey.shade300,
      ),
      title: Text(fileName),
      trailing: const Icon(Icons.check_circle, color: Color(0xFF005843)),
    );
  }
}
