import 'package:flutter/material.dart';
import 'package:jitsi_meet_wrapper/jitsi_meet_wrapper.dart';
import 'package:lettutor/model/user.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({Key? key}) : super(key: key);

  @override
  _MeetingState createState() => _MeetingState();
}

class _MeetingState extends State<MeetingScreen> {
  bool isAudioMuted = true;
  bool isAudioOnly = false;
  bool isVideoMuted = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Jitsi Meet Wrapper Test')),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: buildMeetConfig(),
        ),
      ),
    );
  }

  Widget buildMeetConfig() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Audio Muted"),
            value: isAudioMuted,
            onChanged: _onAudioMutedChanged,
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Audio Only"),
            value: isAudioOnly,
            onChanged: _onAudioOnlyChanged,
          ),
          const SizedBox(height: 16.0),
          CheckboxListTile(
            title: const Text("Video Muted"),
            value: isVideoMuted,
            onChanged: _onVideoMutedChanged,
          ),
          const Divider(height: 48.0, thickness: 2.0),
          SizedBox(
            height: 64.0,
            width: double.maxFinite,
            child: ElevatedButton(
              onPressed: () => _joinMeeting(),
              child: const Text(
                "Join Meeting",
                style: TextStyle(color: Colors.white),
              ),
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => Colors.blue),
              ),
            ),
          ),
          const SizedBox(height: 48.0),
        ],
      ),
    );
  }

  _onAudioOnlyChanged(bool? value) {
    setState(() {
      isAudioOnly = value!;
    });
  }

  _onAudioMutedChanged(bool? value) {
    setState(() {
      isAudioMuted = value!;
    });
  }

  _onVideoMutedChanged(bool? value) {
    setState(() {
      isVideoMuted = value!;
    });
  }

  _joinMeeting() async {
    Map<FeatureFlag, Object> featureFlags = {};

    // Define meetings options here
    var options = JitsiMeetingOptions(
      roomNameOrUrl:
          'f569c202-7bbf-4620-af77-ecc1419a6b28-4d54d3d7-d2a9-42e5-97a2-5ed38af5789a-f569c202-7bbf-4620-af77-ecc1419a6b28',
      serverUrl: 'https://meet.lettutor.com',
      isAudioMuted: isAudioMuted,
      isAudioOnly: isAudioOnly,
      isVideoMuted: isVideoMuted,
      userDisplayName: 'widget.user.name',
      userEmail: 'widget.user.email',
      featureFlags: featureFlags,
    );

    debugPrint("JitsiMeetingOptions: $options");
    await JitsiMeetWrapper.joinMeeting(
      options: options,
      listener: JitsiMeetingListener(
        onOpened: () => debugPrint("onOpened"),
        onConferenceWillJoin: (url) {
          debugPrint("onConferenceWillJoin: url: $url");
        },
        onConferenceJoined: (url) {
          debugPrint("onConferenceJoined: url: $url");
        },
        onConferenceTerminated: (url, error) {
          debugPrint("onConferenceTerminated: url: $url, error: $error");
        },
        onAudioMutedChanged: (isMuted) {
          debugPrint("onAudioMutedChanged: isMuted: $isMuted");
        },
        onVideoMutedChanged: (isMuted) {
          debugPrint("onVideoMutedChanged: isMuted: $isMuted");
        },
        onScreenShareToggled: (participantId, isSharing) {
          debugPrint(
            "onScreenShareToggled: participantId: $participantId, "
            "isSharing: $isSharing",
          );
        },
        onParticipantJoined: (email, name, role, participantId) {
          debugPrint(
            "onParticipantJoined: email: $email, name: $name, role: $role, "
            "participantId: $participantId",
          );
        },
        onParticipantLeft: (participantId) {
          debugPrint("onParticipantLeft: participantId: $participantId");
        },
        onParticipantsInfoRetrieved: (participantsInfo, requestId) {
          debugPrint(
            "onParticipantsInfoRetrieved: participantsInfo: $participantsInfo, "
            "requestId: $requestId",
          );
        },
        onChatMessageReceived: (senderId, message, isPrivate) {
          debugPrint(
            "onChatMessageReceived: senderId: $senderId, message: $message, "
            "isPrivate: $isPrivate",
          );
        },
        onChatToggled: (isOpen) => debugPrint("onChatToggled: isOpen: $isOpen"),
        onClosed: () => debugPrint("onClosed"),
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    String? hintText,
  }) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: labelText,
          hintText: hintText),
    );
  }
}
