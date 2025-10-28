import 'package:flutter/material.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../data/models/food_model.dart';
import '../../data/datasources/african_food_data.dart';

class SearchFoodScreen extends StatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  State<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends State<SearchFoodScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<FoodModel> allFoods = [];
  List<FoodModel> filteredFoods = [];
  String selectedRegion = 'all';

  final List<Map<String, String>> regions = [
    {'id': 'all', 'name': 'All Regions', 'emoji': '🌍'},
    {'id': 'east_africa', 'name': 'East Africa', 'emoji': '🇰🇪'},
    {'id': 'west_africa', 'name': 'West Africa', 'emoji': '🇳🇬'},
    {'id': 'southern_africa', 'name': 'Southern Africa', 'emoji': '🇿🇦'},
    {'id': 'north_africa', 'name': 'North Africa', 'emoji': '🇪🇬'},
  ];

  @override
  void initState() {
    super.initState();
    _loadFoods();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _loadFoods() {
    setState(() {
      allFoods = AfricanFoodData.allFoods;
      filteredFoods = allFoods;
    });
  }

  void _onSearchChanged() {
    _filterFoods();
  }

  void _filterFoods() {
    final query = _searchController.text.toLowerCase();
    
    setState(() {
      filteredFoods = allFoods.where((food) {
        // Filter by region
        if (selectedRegion != 'all' && food.region != selectedRegion) {
          return false;
        }

        // Filter by search query
        if (query.isEmpty) return true;

        // Search in food name
        if (food.name.toLowerCase().contains(query)) return true;

        // Search in local names
        for (var localName in food.localNames.values) {
          if (localName.toLowerCase().contains(query)) return true;
        }

        return false;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Search African Foods',
        showBackButton: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search foods (e.g., Ugali, Jollof Rice)...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey.shade50,
              ),
            ),
          ),

          // Region Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: regions.length,
              itemBuilder: (context, index) {
                final region = regions[index];
                final isSelected = selectedRegion == region['id'];
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: FilterChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(region['emoji']!),
                        const SizedBox(width: 4),
                        Text(region['name']!),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        selectedRegion = region['id']!;
                        _filterFoods();
                      });
                    },
                    backgroundColor: Colors.white,
                    selectedColor: ColorPalette.primary.withValues(alpha: 0.2),
                    checkmarkColor: ColorPalette.primary,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 8),

          // Results Count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${filteredFoods.length} foods found',
                style: const TextStyle(
                  color: ColorPalette.textSecondary,
                  fontSize: 14,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          // Food List
          Expanded(
            child: filteredFoods.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      return _buildFoodCard(filteredFoods[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No foods found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(FoodModel food) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pop(context, food);
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ColorPalette.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.restaurant,
                      color: ColorPalette.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (food.localNames.isNotEmpty)
                          Text(
                            food.localNames.values.first,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: ColorPalette.textSecondary,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              
              // Portion Size
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  food.portionSize,
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorPalette.textSecondary,
                  ),
                ),
              ),
              
              const SizedBox(height: 12),
              
              // Nutrition Info - FIXED: Using Wrap instead of Row
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _NutrientChip(
                    icon: Icons.local_fire_department,
                    label: '${food.calories.toInt()} kcal',
                    color: Colors.orange,
                  ),
                  _NutrientChip(
                    icon: Icons.fitness_center,
                    label: '${food.protein.toInt()}g protein',
                    color: ColorPalette.secondary,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NutrientChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _NutrientChip({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 100),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 3),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}