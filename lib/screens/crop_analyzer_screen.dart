import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

class CropAnalyzerScreen extends StatefulWidget {
  const CropAnalyzerScreen({super.key});

  @override
  State<CropAnalyzerScreen> createState() => _CropAnalyzerScreenState();
}

class _CropAnalyzerScreenState extends State<CropAnalyzerScreen>
    with TickerProviderStateMixin {
  File? _selectedImage;
  bool _isAnalyzing = false;
  Map<String, dynamic>? _analysisResult;
  final ImagePicker _picker = ImagePicker();
  
  late AnimationController _animationController;

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
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
        maxWidth: 800,
      );
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
          _analysisResult = null;
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  Future<void> _analyzeCrop() async {
    if (_selectedImage == null) return;
    
    setState(() => _isAnalyzing = true);
    
    // Simulate AI analysis
    await Future.delayed(const Duration(seconds: 3));
    
    // Mock analysis result
    setState(() {
      _analysisResult = {
        'crop': 'Tomato Plant',
        'health': 'Moderate',
        'disease': 'Early Blight Detected',
        'confidence': 0.87,
        'recommendations': [
          'Apply copper-based fungicide',
          'Reduce watering frequency',
          'Improve air circulation',
          'Remove affected leaves',
        ],
        'growth_stage': 'Flowering',
        'estimated_yield': 'Good (8-10 kg per plant)',
        'next_action': 'Monitor closely for 7 days',
      };
      _isAnalyzing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Crop Photo Analyzer'),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.tertiary,
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: FadeTransition(
          opacity: _animationController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green[50]!,
                      Colors.blue[50]!,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, color: Theme.of(context).colorScheme.primary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Take a clear photo of your crop to get AI-powered health analysis and recommendations',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ).animate().slideY(duration: 600.ms),
              
              const SizedBox(height: 24),
              
              // Image Selection Section
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.grey[300]!, width: 2, style: BorderStyle.solid),
                ),
                child: _selectedImage == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 64, color: Colors.grey[400]),
                          const SizedBox(height: 16),
                          Text(
                            'No image selected',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Take a photo or select from gallery',
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(14),
                        child: Image.file(
                          _selectedImage!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                        ),
                      ),
              ).animate().scale(duration: 600.ms, delay: 200.ms),
              
              const SizedBox(height: 20),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => _pickImage(ImageSource.camera),
                      icon: const Icon(Icons.camera_alt),
                      label: const Text('Take Photo'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _pickImage(ImageSource.gallery),
                      icon: const Icon(Icons.photo_library),
                      label: const Text('Gallery'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                ],
              ).animate().slideX(duration: 600.ms, delay: 400.ms),
              
              const SizedBox(height: 20),
              
              // Analyze Button
              if (_selectedImage != null)
                ElevatedButton.icon(
                  onPressed: _isAnalyzing ? null : _analyzeCrop,
                  icon: _isAnalyzing 
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.analytics),
                  label: Text(_isAnalyzing ? 'Analyzing...' : 'Analyze Crop Health'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ).animate().scale(duration: 400.ms, delay: 600.ms),
              
              const SizedBox(height: 24),
              
              // Analysis Results
              if (_analysisResult != null)
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 12),
                          Text(
                            'Analysis Results',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      
                      _buildResultRow('Crop Type', _analysisResult!['crop'], Icons.eco, Colors.green),
                      _buildResultRow('Health Status', _analysisResult!['health'], Icons.health_and_safety, Colors.orange),
                      _buildResultRow('Disease', _analysisResult!['disease'], Icons.warning, Colors.red),
                      _buildResultRow('Growth Stage', _analysisResult!['growth_stage'], Icons.timeline, Colors.blue),
                      _buildResultRow('Est. Yield', _analysisResult!['estimated_yield'], Icons.agriculture, Colors.purple),
                      
                      const SizedBox(height: 20),
                      
                      // Confidence Score
                      Row(
                        children: [
                          Icon(Icons.verified, color: Colors.green[600]),
                          const SizedBox(width: 12),
                          Text(
                            'Confidence: ${(_analysisResult!['confidence'] * 100).toInt()}%',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green[600],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
                      
                      // Recommendations
                      Text(
                        'Recommendations',
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      
                      ...(_analysisResult!['recommendations'] as List<String>).map((rec) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.blue[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.lightbulb_outline, color: Colors.blue[600], size: 20),
                              const SizedBox(width: 12),
                              Expanded(child: Text(rec)),
                            ],
                          ),
                        );
                      }).toList(),
                      
                      const SizedBox(height: 20),
                      
                      // Action Buttons
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Save report functionality
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Report saved to your profile')),
                                );
                              },
                              icon: const Icon(Icons.save_alt),
                              label: const Text('Save Report'),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                context.go('/complaint');
                              },
                              icon: const Icon(Icons.report_problem),
                              label: const Text('Get Help'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.orange,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultRow(String label, String value, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}