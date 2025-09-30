import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_hti_sun/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static Future<UserCredential> register(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

  static Future<UserCredential> login(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return userCredential;
  }

static void logOut()async{

    await FirebaseAuth.instance.signOut();
}
 static CollectionReference<UserModel> getUsersCollection(){
    FirebaseFirestore db = FirebaseFirestore.instance;
    CollectionReference<UserModel> usersCollection = db
        .collection("Users")
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (user, _) => user.toJson(),
    );
    return usersCollection;
  }

  static Future<void> addUserToFirestore(UserModel user) {
    CollectionReference<UserModel> usersCollection= getUsersCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(user.id);
    return userDocument.set(user);
  }

  static Future<UserModel> getUserFromFirestore(String uid) async {
   CollectionReference<UserModel> usersCollection = getUsersCollection();
    DocumentReference<UserModel> userDocument = usersCollection.doc(uid);
    DocumentSnapshot<UserModel> documentSnapshot = await userDocument.get();
    return documentSnapshot.data()!;
  }
}
