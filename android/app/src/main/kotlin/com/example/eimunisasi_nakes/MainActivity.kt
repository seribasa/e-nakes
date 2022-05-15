package com.peltops.eimunisasi_nakes

// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import android.os.Bundle
import com.google.firebase.FirebaseApp
import com.google.firebase.appcheck.FirebaseAppCheck
import com.google.firebase.appcheck.debug.DebugAppCheckProviderFactory
import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {
//   override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
//     GeneratedPluginRegistrant.registerWith(flutterEngine) // add this line
//   }
  
// }

class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {

        FirebaseApp.initializeApp(/*context=*/ this);
        val firebaseAppCheck = FirebaseAppCheck.getInstance()
        firebaseAppCheck.installAppCheckProviderFactory(
                DebugAppCheckProviderFactory.getInstance())
        super.onCreate(savedInstanceState)
    }
}

