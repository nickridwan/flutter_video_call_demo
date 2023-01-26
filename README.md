Setup:
1. Clone the Agora-Flutter-Quickstart. The Agora Flutter Quickstart is open-sourced and available on GitHub.

2. Create an account on Agora.

3. After completing the registration process, you will be redirected to the dashboard page.

4. Navigate to Projects > Project List within the dashboard tree on the left.

5. Copy the App ID to your clipboard.


Implementation:
## Step 1: Add the dependencies

Add dependencies to pubspec — yaml file.

dependencies:

agora_rtc_engine: ^3.1.3
permission_handler: ^5.0.1
## Step 2: Import
```
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';
```
## Step 3: Run flutter packages get in the root directory of your app.

## Step 4: Enable AndriodX

Add this to your gradle.properties file:
```
org.gradle.jvmargs=-Xmx1536M
android.enableR8=true
android.useAndroidX=true
android.enableJetifier=true
Device Permission:
For Andriod:
```

Open the AndroidManifest.xml file and add the required device permissions to the file.

```
<uses-permission android:name="android.permission.READ_PHONE_STATE"/>
<uses-permission android:name="android.permission.INTERNET" />
<uses-permission android:name="android.permission.RECORD_AUDIO" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.MODIFY_AUDIO_SETTINGS" />
<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />
```

<!-- The Agora SDK requires Bluetooth permissions in case users are using Bluetooth devices.-->
<uses-permission android:name="android.permission.BLUETOOTH" />

For Ios:

Open the info. plist and add:

Privacy — Microphone Usage Description, and add a note in the Value column.

Privacy — Camera Usage Description, and add a note in the Value column.

How to implement code in dart file :

You need to implement it in your code respectively:

const APP_ID = Your App_ID

const Token = Your Token

You will add your app id from the agora dashboard and copy the App ID to your clipboard. Yow will generate a temporary token from the agora console page, and in other options, you will use the 

primary certificate key to copy and paste on the token.

Create a new dart file called home_page.dart inside the lib folder.

```
Row(
  children: <Widget>[
    Expanded(
        child: TextField(
      controller: _channelController,
      decoration: InputDecoration(
        errorText:
            _validateError ? 'Channel name is mandatory' : null,
        border: UnderlineInputBorder(
          borderSide: BorderSide(width: 1),
        ),
        hintText: 'Channel name',
      ),
    ))
  ],
),

```
We will create a text field for the channel name; without add any name, they will show an error and not navigate to another page.

Now, we will make a button:

```
Padding(
  padding: const EdgeInsets.symmetric(vertical: 20),
  child: Row(
    children: <Widget>[
      Expanded(
        child: RaisedButton(
          onPressed: onJoin,
          child: Text('Join'),
          color: Colors.blueAccent,
          textColor: Colors.white,
        ),
      )
    ],
  ),
)

```

We will create a RaisedButton method. In this method, we will onJoin function. We will describe the function below:

```
Future<void> onJoin() async {
  setState(() {
    _channelController.text.isEmpty
        ? _validateError = true
        : _validateError = false;
  });
  if (_channelController.text.isNotEmpty) {
    await _handleCameraAndMic(Permission.camera);
    await _handleCameraAndMic(Permission.microphone);
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoCall(
          channelName: _channelController.text,
          role: _role,
        ),
      ),
    );
  }
}

```

In this Function, we will add a camera and mic permission for users. Anyone user can mic off/on, and camera switch front/back.

That’s it. You’ve successfully integrated the video calling in a flutter. When we run the application, we ought to get the screen’s output like the underneath video capture.