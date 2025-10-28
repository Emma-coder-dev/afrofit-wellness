import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/theme/color_palette.dart';
import '../../../../core/constants/string_constants.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../../../../shared/widgets/input_field.dart';
import '../../../../shared/widgets/primary_button.dart';
import 'body_goal_screen.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
  final _currentWeightController = TextEditingController();
  final _targetWeightController = TextEditingController();
  final _heightController = TextEditingController();
  
  // Selected values
  String? _selectedGender;
  String? _selectedActivityLevel;

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _currentWeightController.dispose();
    _targetWeightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Personal Information',
        showBackButton: true,
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Header
            Text(
              StringConstants.personalInfoTitle,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              StringConstants.personalInfoSubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ColorPalette.textSecondary,
              ),
            ),
            
            const SizedBox(height: 32),
            
            // Name Field
            InputField(
              controller: _nameController,
              label: StringConstants.labelName,
              hintText: 'Enter your full name',
              prefixIcon: Icons.person,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return StringConstants.validationRequired;
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Age and Gender Row
            Row(
              children: [
                // Age Field
                Expanded(
                  child: InputField(
                    controller: _ageController,
                    label: StringConstants.labelAge,
                    hintText: 'Age',
                    prefixIcon: Icons.cake,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(2),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final age = int.tryParse(value);
                      if (age == null || age < 13 || age > 100) {
                        return 'Invalid age';
                      }
                      return null;
                    },
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Gender Dropdown
                Expanded(
                  child: DropdownButtonFormField<String>(
                    value: _selectedGender,
                    decoration: InputDecoration(
                      labelText: StringConstants.labelGender,
                      prefixIcon: const Icon(Icons.wc, color: ColorPalette.primary),
                      filled: true,
                      fillColor: ColorPalette.inputBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ColorPalette.border),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ColorPalette.border),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: ColorPalette.primary, width: 2),
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(
                        value: 'male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem(
                        value: 'female',
                        child: Text('Female'),
                      ),
                      DropdownMenuItem(
                        value: 'other',
                        child: Text('Other'),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Height Field
            InputField(
              controller: _heightController,
              label: StringConstants.labelHeight,
              hintText: 'e.g., 170',
              prefixIcon: Icons.height,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return StringConstants.validationRequired;
                }
                final height = int.tryParse(value);
                if (height == null || height < 100 || height > 250) {
                  return 'Enter valid height (100-250 cm)';
                }
                return null;
              },
            ),
            
            const SizedBox(height: 16),
            
            // Weight Fields Row
            Row(
              children: [
                Expanded(
                  child: InputField(
                    controller: _currentWeightController,
                    label: StringConstants.labelCurrentWeight,
                    hintText: 'kg',
                    prefixIcon: Icons.monitor_weight,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final weight = double.tryParse(value);
                      if (weight == null || weight < 30 || weight > 300) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  child: InputField(
                    controller: _targetWeightController,
                    label: StringConstants.labelTargetWeight,
                    hintText: 'kg',
                    prefixIcon: Icons.flag,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Required';
                      }
                      final weight = double.tryParse(value);
                      if (weight == null || weight < 30 || weight > 300) {
                        return 'Invalid';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 24),
            
            // Activity Level Section
            Text(
              StringConstants.labelActivityLevel,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            
            // Activity Level Options
            ...AppConstants.activityLevelDescriptions.map((level) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _ActivityLevelOption(
                  title: level['title']!,
                  description: level['description']!,
                  value: level['id']!,
                  groupValue: _selectedActivityLevel,
                  onChanged: (value) {
                    setState(() {
                      _selectedActivityLevel = value;
                    });
                  },
                ),
              );
            }).toList(),
            
            const SizedBox(height: 32),
            
            // Continue Button
            PrimaryButton(
              text: StringConstants.buttonContinue,
              onPressed: _handleContinue,
              icon: Icons.arrow_forward,
            ),
          ],
        ),
      ),
    );
  }

  void _handleContinue() {
    if (_formKey.currentState!.validate() && _selectedActivityLevel != null) {
      // TODO: Save data to state management (will implement later)
      
      // For now, just navigate to next screen
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BodyGoalScreen(
            userData: {
              'name': _nameController.text.trim(),
              'age': int.parse(_ageController.text),
              'gender': _selectedGender!,
              'height': double.parse(_heightController.text),
              'currentWeight': double.parse(_currentWeightController.text),
              'targetWeight': double.parse(_targetWeightController.text),
              'activityLevel': _selectedActivityLevel!,
            },
          ),
        ),
      );
    } else if (_selectedActivityLevel == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select your activity level'),
          backgroundColor: ColorPalette.error,
        ),
      );
    }
  }
}

// Activity Level Option Widget
class _ActivityLevelOption extends StatelessWidget {
  final String title;
  final String description;
  final String value;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const _ActivityLevelOption({
    required this.title,
    required this.description,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    
    return GestureDetector(
      onTap: () => onChanged(value),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected 
              ? ColorPalette.primary.withValues(alpha: 0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? ColorPalette.primary : ColorPalette.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
              activeColor: ColorPalette.primary,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorPalette.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 14,
                      color: ColorPalette.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}