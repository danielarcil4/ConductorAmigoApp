import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in
  Future<UserCredential> signInWithEmailPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Sign up
  Future<UserCredential> signUpWithEmailPassword(String email, String password, String role, String name, String identification) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid': userCredential.user!.uid,
        'email': email,
        'role': role,
        'name': name,
        'identification': identification,
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  // Get user role
  Future<String?> getUserRole() async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          return userDoc.get('role') as String?;
        }
      } catch (e) {
        throw Exception('Error getting user role: $e');
      }
    }
    return null;
  }

  // Get user data
  Future<Map<String, dynamic>?> getUserData() async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        DocumentSnapshot userDoc = await _firestore.collection('Users').doc(user.uid).get();
        if (userDoc.exists && userDoc.data() != null) {
          return userDoc.data() as Map<String, dynamic>?;
        }
      } catch (e) {
        throw Exception('Error getting user data: $e');
      }
    }
    return null;
  }

  // Add a new trip
  Future<void> addTrip(String destino, String cupos, String horaDeSalida, String recogida) async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        await _firestore.collection('Trips').add({
          'userId': user.uid,
          'destino': destino,
          'cupos': cupos,
          'horaDeSalida': horaDeSalida,
          'recogida': recogida,
          'createdAt': FieldValue.serverTimestamp(),
        });
      } catch (e) {
        throw Exception('Error adding trip: $e');
      }
    } else {
      throw Exception('No user logged in');
    }
  }

  // Get all trips for the current user
  Future<List<Map<String, dynamic>>> getTrips() async {
    User? user = getCurrentUser();
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await _firestore
            .collection('Trips')
            .where('userId', isEqualTo: user.uid)
            .get();
        return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      } catch (e) {
        throw Exception('Error getting trips: $e');
      }
    } else {
      throw Exception('No user logged in');
    }
  }

  // Delete a trip
  Future<void> deleteTrip(String tripId) async {
    try {
      await _firestore.collection('Trips').doc(tripId).delete();
    } catch (e) {
      throw Exception('Error deleting trip: $e');
    }
  }
}
