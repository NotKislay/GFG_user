import 'package:gofriendsgo/services/shared_preferences.dart';

class APIConstants {
  static const String baseUrl =
      'https://gofriendsgo.in/api/user';
      //'https://gofriendsgo.deweagle.in/api/user';
  static const String baseImageUrl =
      'https://gofriendsgo.in/storage/';
      //'https://gofriendsgo.deweagle.in/storage/';
  static const String loginUrl =
      'https://gofriendsgo.in/api/';
      //'https://gofriendsgo.deweagle.in/api/';

  final loginToken = SharedPreferencesServices().getToken().toString();
}
//String tokenss =
  //  'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiZDk4ZjIzYTFlNjY3Zjc1ZGJiNzQ4OGE1YzY5MzY5N2ExODQyYzkyOWVhYWJlYzdkZWIwMjhmYzdmNTM1N2Q2NjVmZjNiMjIzMzg0YjQxYWIiLCJpYXQiOjE3MjMxMDAwODUuMzI4NzQ3LCJuYmYiOjE3MjMxMDAwODUuMzI4NzQ4LCJleHAiOjE3NTQ2MzYwODUuMzI3ODY0LCJzdWIiOiI0Iiwic2NvcGVzIjpbXX0.UFctc4L8mn1uJqMBOGwEHMKkx5o82JcggTcl6XNb8dH_ztEqg5ne_DGBQI3mWiFKA1tanS95ufkD1wGi8-KahFn6YpWgg-iuf6HDC2Sn8O_bc21nvvkK_211v9GWoNy-dG1c0lVDr3ZPYuS5kiKITH8kd4THcw2O6sACINU-8mcvLJBZ1M6goK1vPyBxfQS6JGEdMwyktBAh6eJD8OYXcyyxMVlcTpYWFP1e_LXCk09SNeIRASeEyJP-Z6JMyHC6EXOmKhzIn3EkJp0P1o5MU1XvjeZi-T9gSv9ECHJuTToTcNAnHuavVBqM06WxN3emekIE6xKySwF5Gy3RZEB7XmpXl6Bl3WA5R66RNZWxqjFI74iMiE305721FRQdT3vd4g2oowynnntJCbjM6pE18mxupl2Pnu2SyKa2K6LJ25NJndE-0mq9fjol6r_ZhjyT1H8dpcEJzonCPuHUY9xMDZqoEdttHxyzp7VVpkpetGQrd28_U24ZBcUKzoOZ_AIvTSmHXKlFiSiOljXeEY92-G1d9AK0NXOYnUH3VTDbMMLizWbcerNc2uNUaw9MZ9KwtO2gkXm5d5sxeTyeq_47Zi93-N6qSNuDKd3LEs8-YhubeRd6IPkPnG6Vqh4P1GArXx2OMP_U2XhehhPS4e-pn9dNTJDYckJH1dHv-SaRsRQ';

