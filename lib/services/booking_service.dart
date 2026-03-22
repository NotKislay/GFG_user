import 'dart:convert';
import 'dart:developer';
import 'package:gofriendsgo/model/bookings_model/bookings_model.dart';
import 'package:gofriendsgo/services/api/app_apis.dart';
import 'package:http/http.dart' as http;

class BookingService {
  // String tempToken =
  //     "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZWRlYTBhZjQ1MmEyODRlYzBmOTI0NzUzZjhlMGMzZGM3NTcwNWMzNTBmOGQ0NzU5NDQ1ZDZlMjJjYTI4ZTc5MzI4YWIwZGQ2ZGEyYTY4OWQiLCJpYXQiOjE3MjMyMDMxNTkuNzg4Nzk5LCJuYmYiOjE3MjMyMDMxNTkuNzg4ODAxLCJleHAiOjE3NTQ3MzkxNTkuNjUwNzQyLCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.Ipy_RS99P70uXXyzzM-9WOWGQQMC97tMILhdooxtXSEeGjmFxifuI9Iuf9bZ0l7DOeYlrlX94-s48DzUfgWOglcHtW6a2RxKGQeHQMZKFXK9epDjI4jZIPL-C2Fk2sIM6bbasRHSmmW4XWREDbcvOTFfGIn13APKgswNe9lQMmomaaXDCkGoiE7jTih2FGhtcxJSwNuHWsKJBc3YW20Pr3AreRVjW7nRWNQc4Vh4VC5h5IWE0BDJhKDPc3dvokfzkP85uuzfTebNxYZfbGvTf-88dbQNz2kzX-aTjMAgaGXqa7_Y-CsukSgppDGbnfYQiNVQiRRS4FlOvEsV8SYFNCvuKAU-XgdIRIxwK2Yia6oH-1v-p8_bQv75Bvh9ZHfeyvQ0eTzW7ubDDpEPFiPCH3c5n10XBJBphr2QUzwxZIk3aQBidsBMz0PrJePS8OyD_zhSpPo5Oscd66TVJ9GrJ3QwQTBa8TJxrte05pavF2oDEyyZcwlikPOydJcabEcVNRxEEZETn10Qb6jnFJdT0pZQ1_28CD4x-poylMVR8t-lgW6VfafwgERy3SdNyN0l5Hy0IHoyAVZ0uhLlPsU4Ov8OKpQXnqB8aMtZBDy3-x0R8Bexe3ezGHB4kvmrxR1fCrBYx49odX2Z_Fu5tXlLUE1B2Zw_C-tQUC5Kwb40HSs";

  Future<BookingResponse> fetchBookings(String token) async {
    log('Fetching bookings from service file');
    try {
      final response = await http.get(
        Uri.parse('${APIConstants.baseUrl}/bookings'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        return BookingResponse.fromJson(parsed);
      } else {
        log('Error: Failed to load bookings with status code ${response.statusCode}');
        throw Exception(
            'Failed to load bookings. Error from booking service area.');
      }
    } catch (e) {
      log('Exception caught: $e');
      throw Exception('Failed to load bookings: $e');
    }
  }
}