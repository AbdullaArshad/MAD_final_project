import 'package:flutter/material.dart';
import '../../data/mock_data.dart';
import '../../data/models.dart';
import '../../widgets/course_card.dart';
import '../course/course_detail_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Course> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
      _searchResults = courses.where((course) {
        final titleMatch = course.title.toLowerCase().contains(
          query.toLowerCase(),
        );
        final instructorMatch = course.instructor.toLowerCase().contains(
          query.toLowerCase(),
        );
        final categoryMatch = course.category.name.toLowerCase().contains(
          query.toLowerCase(),
        );
        return titleMatch || instructorMatch || categoryMatch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Courses'), elevation: 0),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.05),
              border: Border(
                bottom: BorderSide(
                  color: Colors.grey.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
            ),
            child: TextField(
              controller: _searchController,
              autofocus: true,
              decoration: InputDecoration(
                hintText: 'Search by course, instructor, or category...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _performSearch('');
                        },
                      )
                    : null,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _performSearch,
            ),
          ),

          // Search Results
          Expanded(child: _buildSearchResults()),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (!_isSearching && _searchController.text.isEmpty) {
      return _buildSuggestions();
    }

    if (_searchResults.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 80, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'No courses found',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Try searching with different keywords',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            '${_searchResults.length} courses found',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.68,
              crossAxisSpacing: 12,
              mainAxisSpacing: 16,
            ),
            itemCount: _searchResults.length,
            itemBuilder: (context, index) {
              return CourseCard(
                course: _searchResults[index],
                isHorizontal: false,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSuggestions() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Popular Searches',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSearchChip('Flutter'),
              _buildSearchChip('Design'),
              _buildSearchChip('Python'),
              _buildSearchChip('Business'),
              _buildSearchChip('Marketing'),
              _buildSearchChip('Photography'),
            ],
          ),
          const SizedBox(height: 32),
          const Text(
            'Browse by Category',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ...categories.map((category) => _buildCategoryTile(category)),
        ],
      ),
    );
  }

  Widget _buildSearchChip(String label) {
    return ActionChip(
      label: Text(label),
      onPressed: () {
        _searchController.text = label;
        _performSearch(label);
      },
      backgroundColor: Theme.of(
        context,
      ).colorScheme.primary.withValues(alpha: 0.1),
      labelStyle: TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildCategoryTile(Category category) {
    final coursesInCategory = courses
        .where((c) => c.category.id == category.id)
        .length;

    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(category.iconEmoji, style: const TextStyle(fontSize: 24)),
      ),
      title: Text(
        category.name,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Text('$coursesInCategory courses'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        _searchController.text = category.name;
        _performSearch(category.name);
      },
    );
  }
}
