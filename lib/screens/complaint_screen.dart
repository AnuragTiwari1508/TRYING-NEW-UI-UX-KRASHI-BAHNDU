import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  String? _selectedCategory;
  String? _selectedPriority;
  List<File> _selectedImages = [];
  bool _isSubmitting = false;
  
  late AnimationController _animationController;
  final ImagePicker _picker = ImagePicker();

  final List<Map<String, dynamic>> _categories = [
    {'name': 'Pest & Disease', 'icon': Icons.bug_report, 'color': Colors.red[400]},
    {'name': 'Irrigation Problem', 'icon': Icons.water_drop, 'color': Colors.blue[400]},
    {'name': 'Seed Quality', 'icon': Icons.eco, 'color': Colors.green[400]},
    {'name': 'Fertilizer Issue', 'icon': Icons.science, 'color': Colors.orange[400]},
    {'name': 'Weather & Calamity', 'icon': Icons.cloud, 'color': Colors.purple[400]},
    {'name': 'Equipment Problem', 'icon': Icons.build, 'color': Colors.brown[400]},
    {'name': 'Market/Price Issue', 'icon': Icons.monetization_on, 'color': Colors.teal[400]},
    {'name': 'Other', 'icon': Icons.help_outline, 'color': Colors.grey[400]},
  ];

  final List<String> _priorities = ['Low', 'Medium', 'High', 'Critical'];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 800,
      );
      if (image != null) {
        setState(() {
          _selectedImages.add(File(image.path));
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 800,
      );
      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((img) => File(img.path)).toList());
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking images: $e')),
      );
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _submitComplaint() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isSubmitting = true);
      
      try {
        // Simulate uploading images (in real implementation, upload to Firebase Storage)
        List<String> imageUrls = [];
        for (int i = 0; i < _selectedImages.length; i++) {
          // Simulate upload delay
          await Future.delayed(const Duration(milliseconds: 500));
          imageUrls.add('https://example.com/image_${DateTime.now().millisecondsSinceEpoch}_$i.jpg');
        }
        
        await FirebaseFirestore.instance.collection('complaints').add({
          'title': _titleController.text,
          'description': _descriptionController.text,
          'category': _selectedCategory,
          'priority': _selectedPriority,
          'location': _locationController.text,
          'status': 'Submitted',
          'submittedAt': Timestamp.now(),
          'imageUrls': imageUrls,
          'complaintId': 'CMP${DateTime.now().millisecondsSinceEpoch}',
          // Add farmer ID later for authentication
          // 'farmerId': FirebaseAuth.instance.currentUser!.uid,
        });

        if (mounted) {
          setState(() => _isSubmitting = false);
          _showSuccessDialog();
        }
      } catch (e) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error submitting complaint: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.green[600], size: 28),
            const SizedBox(width: 12),
            const Text('Success!'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Your complaint has been submitted successfully.'),
            const SizedBox(height: 12),
            Text(
              'Complaint ID: CMP${DateTime.now().millisecondsSinceEpoch}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'You will receive updates on your registered phone number.',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.go('/farmer_dashboard');
            },
            icon: const Icon(Icons.home),
            label: const Text('Back to Dashboard'),
          ),
        ],
      ),
    ).animate().scale(duration: 300.ms, curve: Curves.easeOut);
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to submit complaint: $e')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submit a Complaint'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title / Subject',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                hint: const Text('Select a category'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (value) => value == null ? 'Please select a category' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please provide a description.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitComplaint,
                child: const Text('Submit Complaint'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
