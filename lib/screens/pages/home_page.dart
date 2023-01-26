import 'dart:async';
import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:flutter_video_call_demo/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import './video_call.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => IndexState();
}

class IndexState extends State<HomePage> {
  final _channelController = TextEditingController();
  bool _validateError = false;

  ClientRole _role = ClientRole.Broadcaster;

  @override
  void dispose() {
    _channelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 50),
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 400,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 100,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(),
              child: Text(
                "Meeting Online \nApplication",
                style: Style.blackAccentTextStyle.copyWith(
                  fontSize: 30,
                  fontWeight: Weigth.bold,
                  color: AppColor.kWhiteColor,
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    controller: _channelController,
                    style: Style.whiteTextStyle,
                    decoration: InputDecoration(
                      errorText:
                          _validateError ? 'Channel name is mandatory' : null,
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(width: 2),
                      ),
                      hintStyle: Style.whiteTextStyle,
                      hintText: 'Channel name',
                    ),
                    onSubmitted: (value) {
                      setState(() {
                        onJoin();
                      });
                    },
                  ),
                )
              ],
            ),
            Column(
              children: [
                ListTile(
                  title: Text(
                    "Broadcast",
                    style: Style.whiteGreyTextStyle,
                  ),
                  leading: Radio(
                    value: ClientRole.Broadcaster,
                    activeColor: AppColor.kRedColor,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                ),
                ListTile(
                  title: Text(
                    "Audience",
                    style: Style.whiteGreyTextStyle,
                  ),
                  leading: Radio(
                    value: ClientRole.Audience,
                    activeColor: AppColor.kRedColor,
                    groupValue: _role,
                    onChanged: (ClientRole value) {
                      setState(() {
                        _role = value;
                      });
                    },
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      onPressed: onJoin,
                      child: Text(
                        'Join',
                        style: Style.blackTextStyle
                            .copyWith(fontSize: 18, fontWeight: Weigth.regular),
                      ),
                      color: AppColor.kLineDarkColor,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> onJoin() async {
    // update input validation
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

  Future<void> _handleCameraAndMic(Permission permission) async {
    final status = await permission.request();
    print(status);
  }
}
