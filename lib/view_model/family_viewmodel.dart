import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gofriendsgo/model/family_model/family_list_response.dart';
import 'package:gofriendsgo/services/family_service.dart';
import 'package:intl/intl.dart';

class FamilyViewModel extends ChangeNotifier {
  final FamilyService _service = FamilyService();

  FamilyListResponse? _familyList;

  FamilyListResponse? get familyList => _familyList;

  String _relationController = '';

  String get relationController => _relationController;

  set relationController(String value) {
    _relationController = value;
    notifyListeners();
  }

  Function(String)? onSuccessCallback;
  Function(String)? onErrorCallback;

  Future<void> fetchFamilyMembers() async {
    final familyMembersResponse = await _service.fetchFamilyMembers();
    if (familyMembersResponse != null) {
      _familyList = familyMembersResponse;
      notifyListeners();
    } else {
      log("Error: Received null FamilyListResponse");
    }
  }

  addFamilyMember({
    required String name,
    required String dob,
    required String mobile,
    required String email,
  }) async {
    final response = await _service.addFamilyMember(
        name: name,
        dob: dob,
        mobile: mobile,
        email: email,
        relation: relationController);

    if (response != null) {
      _familyList?.familyMembers = response.familyMembers;
      onSuccessCallback!('Member added successfully!');
      notifyListeners();
    } else {
      onErrorCallback!('Failed to add member!');
      log("Failed to add member !");
    }
  }

  updateFamilyMember({
    required String id,
    required String name,
    required String dob,
    required String mobile,
    required String email,
  }) async {
    final response = await _service.updateFamilyMember(
        id: id,
        name: name,
        dob: dob,
        mobile: mobile,
        email: email,
        relation: relationController);
    log("REL: $relationController");
    if (response != null) {
      _familyList?.familyMembers = response.familyMembers;
      onSuccessCallback!('Member details updated successfully!');
      notifyListeners();
    } else {
      onErrorCallback!('Failed to update member details!');
      log("Failed to update member !");
    }
  }

  deleteFamilyMember({required String id}) async {
    final response = await _service.deleteFamilyMember(id: id);
    if (response != null) {
      _familyList?.familyMembers = response.familyMembers;
      onSuccessCallback!('Member deleted successfully!');
      notifyListeners();
    } else {
      onErrorCallback!('Failed to delete member!');
      log("Failed to delete family member !");
    }
  }
}
