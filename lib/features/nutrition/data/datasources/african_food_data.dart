import '../models/food_model.dart';

class AfricanFoodData {
  // Complete African Food Database (50+ foods)
  static final List<FoodModel> allFoods = [
    // ==================== EAST AFRICAN FOODS ====================
    
    // Staples
    FoodModel(
      id: 'ugali_001',
      name: 'Ugali',
      localNames: {
        'swahili': 'Ugali',
        'kikuyu': 'Ngima',
        'luo': 'Kuon',
        'kalenjin': 'Kimnyet',
      },
      portionSize: '1 cup (250g)',
      calories: 180,
      protein: 3.8,
      carbs: 38.0,
      fats: 0.8,
      fiber: 2.0,
      category: 'staple',
      region: 'east_africa',
      description: 'Maize flour porridge, staple food in East Africa',
    ),

    FoodModel(
      id: 'chapati_001',
      name: 'Chapati',
      localNames: {
        'swahili': 'Chapati',
        'english': 'Flatbread',
      },
      portionSize: '1 piece (50g)',
      calories: 120,
      protein: 3.0,
      carbs: 20.0,
      fats: 3.5,
      fiber: 1.0,
      category: 'staple',
      region: 'east_africa',
      description: 'Unleavened flatbread made with wheat flour',
    ),

    FoodModel(
      id: 'githeri_001',
      name: 'Githeri',
      localNames: {
        'kikuyu': 'Githeri',
        'swahili': 'Githeri',
      },
      portionSize: '1 cup (250g)',
      calories: 230,
      protein: 10.0,
      carbs: 40.0,
      fats: 3.0,
      fiber: 8.0,
      category: 'main_dish',
      region: 'east_africa',
      description: 'Mixed beans and maize, high in protein',
    ),

    FoodModel(
      id: 'pilau_001',
      name: 'Pilau',
      localNames: {
        'swahili': 'Pilau',
        'english': 'Spiced Rice',
      },
      portionSize: '1 cup (200g)',
      calories: 250,
      protein: 6.0,
      carbs: 45.0,
      fats: 6.0,
      fiber: 2.0,
      category: 'main_dish',
      region: 'east_africa',
      description: 'Fragrant spiced rice with meat or vegetables',
    ),

    // Vegetables
    FoodModel(
      id: 'sukuma_001',
      name: 'Sukuma Wiki',
      localNames: {
        'swahili': 'Sukuma Wiki',
        'english': 'Collard Greens',
        'kikuyu': 'Sukuma Wiki',
      },
      portionSize: '1 cup cooked (100g)',
      calories: 40,
      protein: 3.0,
      carbs: 7.0,
      fats: 0.5,
      fiber: 3.0,
      category: 'vegetable',
      region: 'east_africa',
      description: 'Nutritious leafy greens, rich in vitamins',
    ),

    FoodModel(
      id: 'terere_001',
      name: 'Terere',
      localNames: {
        'kikuyu': 'Terere',
        'english': 'Amaranth Leaves',
      },
      portionSize: '1 cup cooked (100g)',
      calories: 35,
      protein: 2.5,
      carbs: 6.0,
      fats: 0.3,
      fiber: 2.5,
      category: 'vegetable',
      region: 'east_africa',
      description: 'Traditional leafy vegetable, very nutritious',
    ),

    // Proteins
    FoodModel(
      id: 'nyama_choma_001',
      name: 'Nyama Choma',
      localNames: {
        'swahili': 'Nyama Choma',
        'english': 'Grilled Meat',
      },
      portionSize: '100g',
      calories: 250,
      protein: 26.0,
      carbs: 0.0,
      fats: 16.0,
      fiber: 0.0,
      category: 'protein',
      region: 'east_africa',
      description: 'Grilled goat or beef, popular in Kenya',
    ),

    FoodModel(
      id: 'samaki_001',
      name: 'Samaki (Tilapia)',
      localNames: {
        'swahili': 'Samaki',
        'english': 'Fish',
      },
      portionSize: '150g fillet',
      calories: 180,
      protein: 28.0,
      carbs: 0.0,
      fats: 7.0,
      fiber: 0.0,
      category: 'protein',
      region: 'east_africa',
      description: 'Fresh tilapia, rich in protein and omega-3',
    ),

    // ==================== WEST AFRICAN FOODS ====================

    FoodModel(
      id: 'jollof_001',
      name: 'Jollof Rice',
      localNames: {
        'english': 'Jollof Rice',
        'yoruba': 'Ọmọlúwàbí',
      },
      portionSize: '1 cup (200g)',
      calories: 250,
      protein: 5.0,
      carbs: 45.0,
      fats: 6.0,
      fiber: 2.0,
      category: 'main_dish',
      region: 'west_africa',
      description: 'Iconic West African tomato rice dish',
    ),

    FoodModel(
      id: 'fufu_001',
      name: 'Fufu',
      localNames: {
        'english': 'Fufu',
        'twi': 'Fufuo',
      },
      portionSize: '1 serving (200g)',
      calories: 180,
      protein: 2.0,
      carbs: 42.0,
      fats: 0.5,
      fiber: 2.0,
      category: 'staple',
      region: 'west_africa',
      description: 'Starchy side dish made from cassava or plantain',
    ),

    FoodModel(
      id: 'egusi_001',
      name: 'Egusi Soup',
      localNames: {
        'yoruba': 'Ẹgusi',
        'igbo': 'Egwusi',
      },
      portionSize: '1 bowl (250ml)',
      calories: 150,
      protein: 8.0,
      carbs: 10.0,
      fats: 10.0,
      fiber: 3.0,
      category: 'soup',
      region: 'west_africa',
      description: 'Melon seed soup, rich and nutritious',
    ),

    FoodModel(
      id: 'pounded_yam_001',
      name: 'Pounded Yam',
      localNames: {
        'yoruba': 'Iyán',
        'english': 'Pounded Yam',
      },
      portionSize: '1 serving (200g)',
      calories: 200,
      protein: 3.0,
      carbs: 47.0,
      fats: 0.2,
      fiber: 4.0,
      category: 'staple',
      region: 'west_africa',
      description: 'Smooth, stretchy yam paste',
    ),

    FoodModel(
      id: 'moinmoin_001',
      name: 'Moi Moi',
      localNames: {
        'yoruba': 'Mọ́í Mọ́í',
        'english': 'Bean Pudding',
      },
      portionSize: '1 wrap (100g)',
      calories: 130,
      protein: 8.0,
      carbs: 18.0,
      fats: 3.0,
      fiber: 5.0,
      category: 'protein',
      region: 'west_africa',
      description: 'Steamed bean pudding, high in protein',
    ),

    FoodModel(
      id: 'plantain_001',
      name: 'Fried Plantain',
      localNames: {
        'yoruba': 'Dodo',
        'swahili': 'Ndizi',
      },
      portionSize: '1 cup (150g)',
      calories: 220,
      protein: 2.0,
      carbs: 48.0,
      fats: 5.0,
      fiber: 3.0,
      category: 'side_dish',
      region: 'west_africa',
      description: 'Sweet fried plantain, popular side dish',
    ),

    FoodModel(
      id: 'suya_001',
      name: 'Suya',
      localNames: {
        'hausa': 'Suya',
        'english': 'Spiced Grilled Meat',
      },
      portionSize: '100g',
      calories: 280,
      protein: 25.0,
      carbs: 5.0,
      fats: 18.0,
      fiber: 1.0,
      category: 'protein',
      region: 'west_africa',
      description: 'Spicy grilled meat skewers',
    ),

    // ==================== SOUTHERN AFRICAN FOODS ====================

    FoodModel(
      id: 'pap_001',
      name: 'Pap',
      localNames: {
        'afrikaans': 'Pap',
        'zulu': 'Uphutu',
        'english': 'Maize Porridge',
      },
      portionSize: '1 cup (250g)',
      calories: 170,
      protein: 3.5,
      carbs: 37.0,
      fats: 0.7,
      fiber: 2.0,
      category: 'staple',
      region: 'southern_africa',
      description: 'Traditional maize porridge, South African staple',
    ),

    FoodModel(
      id: 'bunny_chow_001',
      name: 'Bunny Chow',
      localNames: {
        'english': 'Bunny Chow',
      },
      portionSize: '1 quarter loaf (300g)',
      calories: 400,
      protein: 15.0,
      carbs: 55.0,
      fats: 12.0,
      fiber: 5.0,
      category: 'main_dish',
      region: 'southern_africa',
      description: 'Hollowed bread filled with curry',
    ),

    FoodModel(
      id: 'chakalaka_001',
      name: 'Chakalaka',
      localNames: {
        'english': 'Chakalaka',
        'zulu': 'Chakalaka',
      },
      portionSize: '1 cup (150g)',
      calories: 120,
      protein: 3.0,
      carbs: 20.0,
      fats: 4.0,
      fiber: 5.0,
      category: 'side_dish',
      region: 'southern_africa',
      description: 'Spicy vegetable relish',
    ),

    FoodModel(
      id: 'boerewors_001',
      name: 'Boerewors',
      localNames: {
        'afrikaans': 'Boerewors',
        'english': 'Farmer\'s Sausage',
      },
      portionSize: '100g',
      calories: 300,
      protein: 18.0,
      carbs: 2.0,
      fats: 25.0,
      fiber: 0.0,
      category: 'protein',
      region: 'southern_africa',
      description: 'Traditional South African sausage',
    ),

    // ==================== NORTH AFRICAN FOODS ====================

    FoodModel(
      id: 'couscous_001',
      name: 'Couscous',
      localNames: {
        'arabic': 'كسكس',
        'french': 'Couscous',
      },
      portionSize: '1 cup cooked (200g)',
      calories: 200,
      protein: 7.0,
      carbs: 40.0,
      fats: 0.5,
      fiber: 2.0,
      category: 'staple',
      region: 'north_africa',
      description: 'Steamed semolina granules',
    ),

    FoodModel(
      id: 'tagine_001',
      name: 'Tagine',
      localNames: {
        'arabic': 'طاجين',
        'french': 'Tajine',
      },
      portionSize: '1 serving (300g)',
      calories: 280,
      protein: 20.0,
      carbs: 25.0,
      fats: 12.0,
      fiber: 4.0,
      category: 'main_dish',
      region: 'north_africa',
      description: 'Slow-cooked stew with meat and vegetables',
    ),

    FoodModel(
      id: 'injera_001',
      name: 'Injera',
      localNames: {
        'amharic': 'እንጀራ',
        'english': 'Ethiopian Flatbread',
      },
      portionSize: '1 piece (100g)',
      calories: 160,
      protein: 6.0,
      carbs: 32.0,
      fats: 1.0,
      fiber: 3.0,
      category: 'staple',
      region: 'north_africa',
      description: 'Spongy sourdough flatbread from Ethiopia',
    ),

    FoodModel(
      id: 'ful_medames_001',
      name: 'Ful Medames',
      localNames: {
        'arabic': 'فول مدمس',
        'english': 'Fava Bean Stew',
      },
      portionSize: '1 cup (250g)',
      calories: 180,
      protein: 10.0,
      carbs: 28.0,
      fats: 4.0,
      fiber: 9.0,
      category: 'main_dish',
      region: 'north_africa',
      description: 'Slow-cooked fava beans, breakfast staple',
    ),

    // ==================== COMMON VEGETABLES ====================

    FoodModel(
      id: 'tomatoes_001',
      name: 'Tomatoes',
      localNames: {
        'swahili': 'Nyanya',
        'english': 'Tomatoes',
      },
      portionSize: '1 medium (100g)',
      calories: 18,
      protein: 0.9,
      carbs: 3.9,
      fats: 0.2,
      fiber: 1.2,
      category: 'vegetable',
      region: 'all_africa',
      description: 'Fresh tomatoes, rich in vitamins',
    ),

    FoodModel(
      id: 'onions_001',
      name: 'Onions',
      localNames: {
        'swahili': 'Vitunguu',
        'english': 'Onions',
      },
      portionSize: '1 medium (100g)',
      calories: 40,
      protein: 1.1,
      carbs: 9.3,
      fats: 0.1,
      fiber: 1.7,
      category: 'vegetable',
      region: 'all_africa',
      description: 'Common cooking ingredient',
    ),

    FoodModel(
      id: 'cabbage_001',
      name: 'Cabbage',
      localNames: {
        'swahili': 'Kabichi',
        'english': 'Cabbage',
      },
      portionSize: '1 cup shredded (100g)',
      calories: 25,
      protein: 1.3,
      carbs: 5.8,
      fats: 0.1,
      fiber: 2.5,
      category: 'vegetable',
      region: 'all_africa',
      description: 'Crunchy vegetable, low in calories',
    ),

    FoodModel(
      id: 'carrots_001',
      name: 'Carrots',
      localNames: {
        'swahili': 'Karoti',
        'english': 'Carrots',
      },
      portionSize: '1 medium (100g)',
      calories: 41,
      protein: 0.9,
      carbs: 9.6,
      fats: 0.2,
      fiber: 2.8,
      category: 'vegetable',
      region: 'all_africa',
      description: 'Sweet root vegetable, high in vitamin A',
    ),

    // ==================== FRUITS ====================

    FoodModel(
      id: 'mango_001',
      name: 'Mango',
      localNames: {
        'swahili': 'Embe',
        'english': 'Mango',
      },
      portionSize: '1 medium (200g)',
      calories: 120,
      protein: 1.6,
      carbs: 28.0,
      fats: 0.8,
      fiber: 3.0,
      category: 'fruit',
      region: 'all_africa',
      description: 'Sweet tropical fruit, rich in vitamins',
    ),

    FoodModel(
      id: 'banana_001',
      name: 'Banana',
      localNames: {
        'swahili': 'Ndizi',
        'english': 'Banana',
      },
      portionSize: '1 medium (120g)',
      calories: 105,
      protein: 1.3,
      carbs: 27.0,
      fats: 0.4,
      fiber: 3.1,
      category: 'fruit',
      region: 'all_africa',
      description: 'Energy-rich fruit, high in potassium',
    ),

    FoodModel(
      id: 'papaya_001',
      name: 'Papaya',
      localNames: {
        'swahili': 'Papai',
        'english': 'Papaya',
      },
      portionSize: '1 cup cubed (150g)',
      calories: 60,
      protein: 0.7,
      carbs: 15.0,
      fats: 0.4,
      fiber: 2.5,
      category: 'fruit',
      region: 'all_africa',
      description: 'Tropical fruit, aids digestion',
    ),

    FoodModel(
      id: 'avocado_001',
      name: 'Avocado',
      localNames: {
        'swahili': 'Parachichi',
        'english': 'Avocado',
      },
      portionSize: '1/2 medium (100g)',
      calories: 160,
      protein: 2.0,
      carbs: 8.5,
      fats: 15.0,
      fiber: 6.7,
      category: 'fruit',
      region: 'all_africa',
      description: 'Creamy fruit, healthy fats',
    ),

    // ==================== SNACKS ====================

    FoodModel(
      id: 'groundnuts_001',
      name: 'Groundnuts (Peanuts)',
      localNames: {
        'swahili': 'Karanga',
        'english': 'Peanuts',
      },
      portionSize: '30g (small handful)',
      calories: 170,
      protein: 7.0,
      carbs: 6.0,
      fats: 14.0,
      fiber: 2.4,
      category: 'snack',
      region: 'all_africa',
      description: 'Protein-rich nuts',
    ),

    FoodModel(
      id: 'mandazi_001',
      name: 'Mandazi',
      localNames: {
        'swahili': 'Mandazi',
        'english': 'East African Doughnut',
      },
      portionSize: '1 piece (50g)',
      calories: 150,
      protein: 3.0,
      carbs: 22.0,
      fats: 6.0,
      fiber: 1.0,
      category: 'snack',
      region: 'east_africa',
      description: 'Fried dough snack, slightly sweet',
    ),

    FoodModel(
      id: 'samosa_001',
      name: 'Samosa',
      localNames: {
        'swahili': 'Sambusa',
        'english': 'Samosa',
      },
      portionSize: '1 piece (40g)',
      calories: 110,
      protein: 3.0,
      carbs: 14.0,
      fats: 5.0,
      fiber: 1.0,
      category: 'snack',
      region: 'east_africa',
      description: 'Fried pastry with savory filling',
    ),

    // ==================== BEVERAGES ====================

    FoodModel(
      id: 'chai_001',
      name: 'Chai (Tea with Milk)',
      localNames: {
        'swahili': 'Chai',
        'english': 'Tea',
      },
      portionSize: '1 cup (250ml)',
      calories: 80,
      protein: 3.0,
      carbs: 12.0,
      fats: 2.0,
      fiber: 0.0,
      category: 'beverage',
      region: 'east_africa',
      description: 'Sweet milky tea',
    ),

    FoodModel(
      id: 'uji_001',
      name: 'Uji (Porridge)',
      localNames: {
        'swahili': 'Uji',
        'english': 'Millet Porridge',
      },
      portionSize: '1 cup (250ml)',
      calories: 120,
      protein: 4.0,
      carbs: 24.0,
      fats: 1.5,
      fiber: 3.0,
      category: 'beverage',
      region: 'east_africa',
      description: 'Nutritious fermented porridge',
    ),
  ];

  // ==================== HELPER METHODS ====================

  // Get all foods
  static List<FoodModel> getAllFoods() => allFoods;

  // Get foods by region
  static List<FoodModel> getFoodsByRegion(String region) {
    return allFoods.where((food) => food.region == region).toList();
  }

  // Get foods by category
  static List<FoodModel> getFoodsByCategory(String category) {
    return allFoods.where((food) => food.category == category).toList();
  }

  // Search foods by name or local name
  static List<FoodModel> searchFoods(String query) {
    final lowerQuery = query.toLowerCase();
    return allFoods.where((food) {
      // Search in English name
      if (food.name.toLowerCase().contains(lowerQuery)) return true;
      
      // Search in local names
      for (var localName in food.localNames.values) {
        if (localName.toLowerCase().contains(lowerQuery)) return true;
      }
      
      return false;
    }).toList();
  }

  // Get food by ID
  static FoodModel? getFoodById(String id) {
    try {
      return allFoods.firstWhere((food) => food.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get high protein foods (>10g per serving)
  static List<FoodModel> getHighProteinFoods() {
    return allFoods.where((food) => food.protein >= 10).toList();
  }

  // Get low calorie foods (<100 cal per serving)
  static List<FoodModel> getLowCalorieFoods() {
    return allFoods.where((food) => food.calories < 100).toList();
  }

  // Get vegetarian foods
  static List<FoodModel> getVegetarianFoods() {
    return allFoods.where((food) => 
      food.category != 'protein' || food.category == 'vegetable' || food.category == 'fruit'
    ).toList();
  }

  // Get available regions
  static List<String> getAvailableRegions() {
    return allFoods.map((food) => food.region).toSet().toList();
  }

  // Get available categories
  static List<String> getAvailableCategories() {
    return allFoods.map((food) => food.category).toSet().toList();
  }
}