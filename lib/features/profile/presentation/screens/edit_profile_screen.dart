import 'package:flutter/material.dart';
import '../../../../../core/theme/color_palette.dart';
import '../../../../../shared/widgets/custom_app_bar.dart';
import '../../../../../shared/widgets/primary_button.dart';
import '../../../../../shared/widgets/input_field.dart';
import '../../../../../shared/services/local_storage_service.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _currentWeightController = TextEditingController();
  final TextEditingController _targetWeightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  bool isLoading = true;
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() => isLoading = true);

    try {
      final user = await LocalStorageService.getUserData();
      if (user != null) {
        setState(() {
          userData = user;
          _nameController.text = user['name'] as String;
          _ageController.text = (user['age'] as int).toString();
          _currentWeightController.text = (user['currentWeight'] as double).toString();
          _targetWeightController.text = (user['targetWeight'] as double).toString();
          _heightController.text = (user['height'] as double).toString();
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      // Update user data
      userData!['name'] = _nameController.text;
      userData!['age'] = int.parse(_ageController.text);
      userData!['currentWeight'] = double.parse(_currentWeightController.text);
      userData!['targetWeight'] = double.parse(_targetWeightController.text);
      userData!['height'] = double.parse(_heightController.text);

      // Recalculate BMI and daily goals
      final height = double.parse(_heightController.text);
      final weight = double.parse(_currentWeightController.text);
      final age = int.parse(_ageController.text);
      final gender = userData!['gender'] as String;
      final activityLevel = userData!['activityLevel'] as String;

      // Calculate BMR
      double bmr;
      if (gender == 'male') {
        bmr = 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
      } else {
        bmr = 447.593 + (9.247 * weight) + (3.098 * height) - (4.330 * age);
      }

      // Activity multipliers
      final multipliers = {
        'sedentary': 1.2,
        'lightly_active': 1.375,
        'moderately_active': 1.55,
        'very_active': 1.725,
      };

      final tdee = bmr * (multipliers[activityLevel] ?? 1.2);
      final dailyCalories = (tdee - 500).round();
      final protein = (weight * 2).round();
      final water = (weight * 35).round();

      userData!['dailyGoals'] = {
        'calories': dailyCalories,
        'protein': protein,
        'carbs': ((dailyCalories * 0.4) / 4).round(),
        'fats': ((dailyCalories * 0.3) / 9).round(),
        'water': water,
        'sleep': 8,
        'steps': 8000,
      };

      await LocalStorageService.saveUserData(userData!);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Profile updated successfully! 🎉'),
            backgroundColor: ColorPalette.success,
          ),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving changes: $e'),
            backgroundColor: ColorPalette.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Edit Profile',
        showBackButton: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _nameController,
                label: 'Name',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _ageController,
                label: 'Age',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your age';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Body Measurements',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InputField(
                      controller: _currentWeightController,
                      label: 'Current Weight (kg)',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InputField(
                      controller: _targetWeightController,
                      label: 'Target Weight (kg)',
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _heightController,
                label: 'Height (cm)',
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your height';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                text: 'Save Changes',
                onPressed: _saveChanges,
                icon: Icons.check,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _currentWeightController.dispose();
    _targetWeightController.dispose();
    _heightController.dispose();
    super.dispose();
  }
}