package ha_tien_app.employee

import android.content.pm.PackageManager
import android.os.Bundle
import androidx.annotation.NonNull
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler





class MainActivity: FlutterActivity() {

    private val CHANNEL = "bakco.hatien.otp"
    companion object {
        lateinit var methodChannel: MethodChannel
        lateinit var resultC: MethodChannel.Result
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        methodChannel = MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL)
    }
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

         MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call: MethodCall?, result: MethodChannel.Result? ->
                if(call!!.method == "receiveMessage"){
                    requestPermission()
                    if (result != null) {
                        resultC = result
                        OTPRecieve()
                    } else{
                        result?.error("UNAVAILABLE", "receiveMessage not available.", null);
                    }

                }
            }
    }
    fun requestPermission(){
        var permission = android.Manifest.permission.RECEIVE_SMS;
        var grant = ContextCompat.checkSelfPermission(this, permission)
        if(grant != PackageManager.PERMISSION_GRANTED){
            var permisstionList: Array<String> = arrayOf(permission)
            ActivityCompat.requestPermissions(
                this,
                permisstionList,
                1
            )
        }
    }
}
