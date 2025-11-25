import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CommunityFeedScreen extends StatefulWidget {
  const CommunityFeedScreen({super.key});

  @override
  State<CommunityFeedScreen> createState() => _CommunityFeedScreenState();
}

class _CommunityFeedScreenState extends State<CommunityFeedScreen> {
  final List<Map<String, dynamic>> _posts = [
    {
      'id': 1,
      'author': 'राम शर्मा (Ram Sharma)',
      'location': 'Mathura, UP',
      'time': '2 hours ago',
      'content': 'Great harvest this season! My wheat yield increased by 30% using organic fertilizers. Sharing some tips with fellow farmers.',
      'hindi_content': 'इस सीजन बहुत अच्छी फसल हुई! जैविक खाद का उपयोग करके मेरी गेहूं की उपज 30% बढ़ गई।',
      'image': 'https://via.placeholder.com/400x300',
      'likes': 45,
      'comments': 12,
      'category': 'Success Story',
      'crop': 'Wheat',
    },
    {
      'id': 2,
      'author': 'सुनीता देवी (Sunita Devi)',
      'location': 'Jaipur, Rajasthan',
      'time': '5 hours ago',
      'content': 'Need urgent help! My tomato plants are showing yellow leaves. Has anyone faced this issue?',
      'hindi_content': 'तुरंत मदद चाहिए! मेरे टमाटर के पौधों में पीले पत्ते आ रहे हैं। क्या किसी को यह समस्या हुई है?',
      'image': null,
      'likes': 23,
      'comments': 8,
      'category': 'Help Needed',
      'crop': 'Tomato',
    },
    {
      'id': 3,
      'author': 'कृष्णा पाटील (Krishna Patil)',
      'location': 'Pune, Maharashtra',
      'time': '8 hours ago',
      'content': 'Weather alert! Heavy rains expected in next 3 days. Please cover your crops and ensure proper drainage.',
      'hindi_content': 'मौसम चेतावनी! अगले 3 दिनों में भारी बारिश की संभावना। कृपया अपनी फसलों को ढकें और उचित जल निकासी सुनिश्चित करें।',
      'image': 'https://via.placeholder.com/400x200',
      'likes': 67,
      'comments': 15,
      'category': 'Weather Alert',
      'crop': 'General',
    },
    {
      'id': 4,
      'author': 'अजय कुमार (Ajay Kumar)',
      'location': 'Ludhiana, Punjab',
      'time': '1 day ago',
      'content': 'New irrigation technique is working great! Drip irrigation has reduced water usage by 40% and improved crop quality.',
      'hindi_content': 'नई सिंचाई तकनीक बहुत अच्छा काम कर रही है! ड्रिप सिंचाई से पानी का उपयोग 40% कम हो गया है।',
      'image': 'https://via.placeholder.com/400x300',
      'likes': 89,
      'comments': 21,
      'category': 'Innovation',
      'crop': 'Rice',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text('Community Feed'),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // Implement refresh functionality
          await Future.delayed(const Duration(seconds: 1));
        },
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _posts.length + 1,
            itemBuilder: (context, index) {
              if (index == 0) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildCreatePostCard(),
                    ),
                  ),
                );
              }
              
              final post = _posts[index - 1];
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: FadeInAnimation(
                    child: _buildPostCard(post),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreatePostDialog();
        },
        icon: const Icon(Icons.add),
        label: const Text('New Post'),
        backgroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }

  Widget _buildCreatePostCard() {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Theme.of(context).colorScheme.primary.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: _showCreatePostDialog,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Text(
                  'Share your farming experience...',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.camera_alt, color: Theme.of(context).colorScheme.primary),
            onPressed: _showCreatePostDialog,
          ),
        ],
      ),
    );
  }

  Widget _buildPostCard(Map<String, dynamic> post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    post['author'].substring(0, 1).toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post['author'],
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '${post['location']} • ${post['time']}',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildCategoryChip(post['category']),
              ],
            ),
          ),
          
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post['content'],
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                if (post['hindi_content'] != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    post['hindi_content'],
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Image
          if (post['image'] != null) ...[
            const SizedBox(height: 12),
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.grey[300],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  post['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.agriculture, size: 48, color: Colors.grey[600]),
                          const SizedBox(height: 8),
                          Text(
                            'Crop Image',
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 12),
          
          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                _buildActionButton(
                  Icons.thumb_up_outline,
                  '${post['likes']}',
                  Colors.blue,
                  () {},
                ),
                const SizedBox(width: 24),
                _buildActionButton(
                  Icons.chat_bubble_outline,
                  '${post['comments']}',
                  Colors.green,
                  () {},
                ),
                const Spacer(),
                _buildActionButton(
                  Icons.share_outlined,
                  'Share',
                  Colors.grey,
                  () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final colors = {
      'Success Story': Colors.green,
      'Help Needed': Colors.red,
      'Weather Alert': Colors.orange,
      'Innovation': Colors.blue,
    };
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: (colors[category] ?? Colors.grey).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        category,
        style: TextStyle(
          color: colors[category] ?? Colors.grey,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  void _showCreatePostDialog() {
    final titleController = TextEditingController();
    final contentController = TextEditingController();
    String? selectedCategory;
    
    final categories = ['Success Story', 'Help Needed', 'Weather Alert', 'Innovation', 'General'];
    
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Create New Post'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  labelText: 'Post Title',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((cat) => DropdownMenuItem(
                  value: cat,
                  child: Text(cat),
                )).toList(),
                onChanged: (value) => selectedCategory = value,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: contentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Share your experience...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement post creation
              Navigator.of(ctx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Post created successfully!')),
              );
            },
            child: const Text('Post'),
          ),
        ],
      ),
    ).animate().scale(duration: 300.ms);
  }
}