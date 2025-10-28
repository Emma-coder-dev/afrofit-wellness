import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LocalStorageService {
  static const String _userBoxName = 'user_box';
  static const String _onboardingBoxName = 'onboarding_box';
  static const String _dailyLogsBoxName = 'daily_logs_box';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Open boxes
    await Hive.openBox(_userBoxName);
    await Hive.openBox(_onboardingBoxName);
    await Hive.openBox(_dailyLogsBoxName);
  }

  // ==================== USER DATA ====================
  
  /// Save user data
  static Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      final box = Hive.box(_userBoxName);
      await box.put('user', userData);
    } catch (e) {
      debugPrint('Error saving user data: $e');
      rethrow;
    }
  }

  /// Get user data
  static Future<Map<String, dynamic>?> getUserData() async {
    try {
      final box = Hive.box(_userBoxName);
      final data = box.get('user');
      
      // ✅ FIX: Ensure proper type conversion
      if (data == null) return null;
      if (data is Map<String, dynamic>) return data;
      return Map<String, dynamic>.from(data as Map);
    } catch (e) {
      debugPrint('Error getting user data: $e');
      return null;
    }
  }

  /// Clear user data
  static Future<void> clearUserData() async {
    try {
      final box = Hive.box(_userBoxName);
      await box.delete('user');
    } catch (e) {
      debugPrint('Error clearing user data: $e');
      rethrow;
    }
  }

  // ==================== ONBOARDING ====================
  
  /// Mark onboarding as complete
  static Future<void> markOnboardingComplete() async {
    try {
      final box = Hive.box(_onboardingBoxName);
      await box.put('completed', true);
    } catch (e) {
      debugPrint('Error marking onboarding complete: $e');
      rethrow;
    }
  }

  /// Check if onboarding is complete
  static Future<bool> isOnboardingComplete() async {
    try {
      final box = Hive.box(_onboardingBoxName);
      return box.get('completed', defaultValue: false) as bool;
    } catch (e) {
      debugPrint('Error checking onboarding status: $e');
      return false;
    }
  }

  /// Reset onboarding status
  static Future<void> resetOnboarding() async {
    try {
      final box = Hive.box(_onboardingBoxName);
      await box.delete('completed');
    } catch (e) {
      debugPrint('Error resetting onboarding: $e');
      rethrow;
    }
  }

  // ==================== DAILY LOGS ====================
  
  /// Get today's key (format: YYYY-MM-DD)
  static String getTodayKey() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
  }

  /// Save daily log
  static Future<void> saveDailyLog(String dateKey, Map<String, dynamic> logData) async {
    try {
      final box = Hive.box(_dailyLogsBoxName);
      await box.put(dateKey, logData);
    } catch (e) {
      debugPrint('Error saving daily log: $e');
      rethrow;
    }
  }

  /// Get daily log for a specific date
  static Future<Map<String, dynamic>?> getDailyLog(String dateKey) async {
    try {
      final box = Hive.box(_dailyLogsBoxName);
      final data = box.get(dateKey);
      
      // ✅ FIX: Ensure proper type conversion
      if (data == null) return null;
      if (data is Map<String, dynamic>) return data;
      return Map<String, dynamic>.from(data as Map);
    } catch (e) {
      debugPrint('Error getting daily log: $e');
      return null;
    }
  }

  /// Get all daily logs
  static Future<Map<String, dynamic>> getAllDailyLogs() async {
    try {
      final box = Hive.box(_dailyLogsBoxName);
      final Map<String, dynamic> allLogs = {};
      
      for (var key in box.keys) {
        final data = box.get(key);
        if (data != null) {
          // ✅ FIX: Ensure proper type conversion
          if (data is Map<String, dynamic>) {
            allLogs[key.toString()] = data;
          } else if (data is Map) {
            allLogs[key.toString()] = Map<String, dynamic>.from(data);
          }
        }
      }
      
      return allLogs;
    } catch (e) {
      debugPrint('Error getting all daily logs: $e');
      return {};
    }
  }

  /// Delete daily log
  static Future<void> deleteDailyLog(String dateKey) async {
    try {
      final box = Hive.box(_dailyLogsBoxName);
      await box.delete(dateKey);
    } catch (e) {
      debugPrint('Error deleting daily log: $e');
      rethrow;
    }
  }

  // ==================== UTILITY METHODS ====================
  
  /// Clear all data
  static Future<void> clearAllData() async {
    try {
      await Hive.box(_userBoxName).clear();
      await Hive.box(_onboardingBoxName).clear();
      await Hive.box(_dailyLogsBoxName).clear();
    } catch (e) {
      debugPrint('Error clearing all data: $e');
      rethrow;
    }
  }

  /// Close all boxes
  static Future<void> closeAll() async {
    try {
      await Hive.close();
    } catch (e) {
      debugPrint('Error closing Hive: $e');
      rethrow;
    }
  }
}