package info.dsoft.app

import android.media.MediaScannerConnection
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val chanel = "com.dsoft/save_image"
    private val scanFileMethod = "scanFile"
    private val path = "path"

    override fun configureFlutterEngine(flutterEngine: io.flutter.embedding.engine.FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, chanel).setMethodCallHandler { call, result ->
            if (call.method == scanFileMethod) {
                val path = call.argument<String>(path)
                if (path != null) {
                    MediaScannerConnection.scanFile(this, arrayOf(path), null, null)
                    result.success(null)
                } else {
                    result.error("NO_PATH", "Path is null", null)
                }
            }
        }
    }
}
