import 'dart:developer';
import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
import 'package:bookie_buddy_web/core/models/services_model/services_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ServiceApi {
  static Future<List<ServicesModel>> fetchServices() async {
    int retryCount = 0;
    const maxRetries = 3;
    
    while (retryCount < maxRetries) {
      try {
        log('Attempting to fetch services using Dio client (attempt ${retryCount + 1}/$maxRetries)');
        
        final response = await DioClient.dio.get('/api/v3/service/selected');
        
        log('Successfully received response from Dio client: ${response.statusCode}');
        
        // Extract data from API response structure
        final Map<String, dynamic> responseMap = response.data as Map<String, dynamic>;
        final List<dynamic> responseData = responseMap['data'] as List<dynamic>;
        log('Successfully received ${responseData.length} services from Dio client');
        
        final services = responseData.map((json) => ServicesModel.fromJson(json as Map<String, dynamic>)).toList();
        log('Successfully parsed ${services.length} services');
        return services;
        
      } catch (e, stackTrace) {
        retryCount++;
        
        log('Failed to load services with Dio client (attempt $retryCount)', error: e, stackTrace: stackTrace);
        
        if (e is DioException) {
          log('DioException type: ${e.type}');
          log('DioException response: ${e.response?.data}');
          
          // For web development, provide helpful information
          if (kIsWeb) {
            log('');
            log('🌐 WEB DEVELOPMENT NOTICE:');
            log('Using Dio client for HTTP requests.');
            log('If this error persists, it might be a backend CORS configuration issue.');
            log('');
          }
        }
        
        // If this is the last retry, throw the error
        if (retryCount >= maxRetries) {
          if (e is DioException && e.response?.statusCode != null) {
            throw 'Failed to load services: HTTP ${e.response!.statusCode} - ${e.message}';
          }
          throw 'Failed to load services after $maxRetries attempts: ${e.toString()}';
        }
        
        // Wait before retrying (exponential backoff)
        await Future.delayed(Duration(seconds: retryCount * 2));
      }
    }
    
    throw 'Failed to load services after $maxRetries attempts';
  }
}
