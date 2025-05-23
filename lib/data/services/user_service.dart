import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../handle/firebase_exceptionhandler.dart';
import '../models/user_model.dart';
import 'auth_service.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Save user data to Firestore
  Future<void> saveUserRecord(UserModel user, String id) async {
    try {
      // Save the user record to the Firestore collection "Users" with the document ID as the user ID
      log("User Name: ${user.name}");
      await _db.collection("Users").doc(id).set(user.toJson());
    } catch (e) {
      // Handle any exceptions that occurl
      log("Error in saveUserRecord : $e");
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Fetch user data from Firestore without specifying user ID (uses authenticated user ID)
  Future<UserModel> getUserById() async {
    try {
      // Get the document snapshot for the authenticated user
      DocumentSnapshot snapshot =
          await _db.collection("Users").doc(AuthService().authUser!.uid).get();

      // Check if the document exists and return the user model
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        // Return an empty user model if the document does not exist
        return UserModel.empty();
      }
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Fetch user data from Firestore by user ID
  Future<UserModel> fetchUserdetails(String? id) async {
    try {
      // Get the document snapshot for the specified user ID
      DocumentSnapshot snapshot = await _db.collection("Users").doc(id).get();

      // Check if the document exists and return the user model
      if (snapshot.exists) {
        return UserModel.fromSnapshot(snapshot);
      } else {
        log('Empty User');
        // Return an empty user model if the document does not exist
        return UserModel.empty();
      }
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Update a specific field in a user's document
  Future<void> updateSpecificField({
    required String fieldName,
    required dynamic value,
  }) async {
    try {
      // Update the specified field in the authenticated user's document
      await _db.collection("Users").doc(AuthService().authUser!.uid).update({
        fieldName: value,
      });
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Update all fields in a user's document
  Future<void> updateUserField({required UserModel userMdel}) async {
    try {
      // Update the entire document for the authenticated user
      await _db
          .collection("Users")
          .doc(AuthService().authUser!.uid)
          .update(userMdel.toJson());
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }

  /// Remove user data from Firestore
  Future<void> removeUserRecord() async {
    try {
      // Delete the document for the authenticated user
      await _db.collection("Users").doc(AuthService().authUser!.uid).delete();
    } catch (e) {
      // Handle any exceptions that occur
      throw ExceptionHandler.handleException(e);
    }
  }
}
