// import 'dart:developer';
// import 'package:bookie_buddy_web/config/dio_client/dio_config.dart';
// import 'package:bookie_buddy_web/core/api/api_paths.dart';
// import 'package:bookie_buddy_web/core/models/custom_response_model/custom_response_model.dart';

// class BookingSearchService {
//   Future<CustomResponseModel> searchAllBookings(
//     String query, {
//     required int page,
//     required String status,
//     String? startDate,
//     String? endDate,
//   }) async {
//     try {
//       final response = await DioClient.dio.get(
//         ApiPaths.bookings.bookingsV3,
//         queryParameters: {
//           'search': query,
//           'page': page,
//           'status': status,
//           if (startDate != null) 'start_date': startDate,
//           if (endDate != null) 'end_date': endDate,
//         },
//       );
//       log(response.realUri.toString());

//       // log('search bookings response: ${response.realUri.toString()}, data: ${response.data}');
//       return CustomResponseModel.fromJson(response.data);
//     } catch (e, stackTrace) {
//       log('Error searching bookings: $e', stackTrace: stackTrace);
//       rethrow;
//     }
//   }

  // Future<List<BookingsModel>> searchUpcomingBookings(String query) async {
  //   try {
  //     final response = await DioClient.dio.post(
  //       "/booking/search_for_upcoming_bookings",
  //       data: {"search": query},
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       log('search data: ${response.data}');
  //       return (data['bookings'] as List)
  //           .map((e) => BookingsModel.fromJson(e))
  //           .toList();
  //     } else if (response.statusCode == 404) {
  //       log('status code: ${response.statusCode}, search data: ${response.data}');
  //       return [];
  //     } else {
  //       log('status code: ${response.statusCode}, search data: ${response.data}');
  //       throw 'Failed to fetch search results';
  //     }
  //   } catch (e, stackTrace) {
  //     log(e.toString(), stackTrace: stackTrace);
  //     rethrow;
  //   }
  // }

  // Future<List<BookingsModel>> searchCompletedBookings(String query) async {
  //   try {
  //     final response = await DioClient.dio.post(
  //       "/booking/search_for_completed_bookings",
  //       data: {"search": query},
  //     );

  //     if (response.statusCode == 200) {
  //       final data = response.data;
  //       log('search data: ${response.data}');
  //       return (data['bookings'] as List)
  //           .map((e) => BookingsModel.fromJson(e))
  //           .toList();
  //     } else if (response.statusCode == 404) {
  //       log('status code: ${response.statusCode}, search data: ${response.data}');
  //       return [];
  //     } else {
  //       log('status code: ${response.statusCode}, search data: ${response.data}');
  //       throw 'Failed to fetch search results';
  //     }
  //   } catch (e, stackTrace) {
  //     log(e.toString(), stackTrace: stackTrace);
  //     rethrow;
  //   }
  // }
// }
