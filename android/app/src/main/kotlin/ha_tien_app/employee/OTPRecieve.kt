package ha_tien_app.employee

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.os.Build
import android.provider.Telephony
import android.telephony.SmsMessage
import android.util.Log
import androidx.annotation.RequiresApi
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

//
open class OTPRecieve : BroadcastReceiver() {
    private var messagex: String = ""

    fun getMessage(): String {
        Log.d("OTPRecieve", "getMessage: ${messagex}")
        return messagex;
    }
    
    @RequiresApi(Build.VERSION_CODES.KITKAT)
    override fun onReceive(p0: Context?, p1: Intent?) {
        var  messages = Telephony.Sms.Intents.getMessagesFromIntent(p1)
        for(sms in messages){
           var message = sms.messageBody;
            Log.d("OTPRecieve", "onReceive: ${message}")
            try{
                MainActivity.resultC.success(message)
            } catch(e : Exception){

            }

        }
    }
}