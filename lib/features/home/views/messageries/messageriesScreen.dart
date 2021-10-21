import 'package:flutter/material.dart';
import 'package:flutter_incall/flutter_incall.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:get/get.dart';
import 'package:oikos/core/config/theme.dart';
import 'package:oikos/core/constants/api.dart';
import 'package:oikos/features/auth/controllers/authController.dart';
import 'package:oikos/features/auth/data/models/User.dart';
import 'package:oikos/features/auth/data/models/userProfile.dart';
import 'package:oikos/features/auth/utils/authenticationstatus.dart';
import 'package:oikos/features/home/views/messageries/signaling.dart';
import 'package:oikos/features/home/views/messageries/video_chat.dart';
import 'package:oikos/shared/widgets/bottomNavBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class MessageriesScreen extends StatefulWidget {
  @override
  _MessageriesScreenState createState() => _MessageriesScreenState();
}

class _MessageriesScreenState extends State<MessageriesScreen> {
  AuthController authController = Get.find();
  final String serverIP = "192.168.167.178";
  String displayName = "";
  Signaling _signaling;
  List<dynamic> _peers;
  var _currentPeer;
  var _selfId;
  SignalingState _callState;
  bool _connected = false;

  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();

  String clientId;
  SharedPreferences prefs;

  IncallManager incall = new IncallManager();
  AuthController _authController = Get.find();

  UserProfile userProfile;
  @override
  Widget build(BuildContext context) {
    userProfile = (Get.find<AuthController>().state as Authenticated).user;
    displayName = authController.name;
    var floatingActionButtons = <Widget>[
      FloatingActionButton(
        child: const Icon(Icons.switch_camera),
        onPressed: _switchCamera,
      ),
      FloatingActionButton(
        onPressed: _hangUp,
        tooltip: 'Hangup',
        child: new Icon(Icons.call_end),
        backgroundColor: Colors.pink,
      )
    ];

    if (_callState == SignalingState.CallStateIncoming)
      floatingActionButtons.add(FloatingActionButton(
        onPressed: _pickUp,
        tooltip: 'Pickup',
        child: new Icon(Icons.call),
        backgroundColor: Colors.green,
      ));

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _callState == SignalingState.CallStateIncoming ||
              _callState == SignalingState.CallStateOutgoing ||
              _callState == SignalingState.CallStateConnected
          ? new SizedBox(
              width: 200.0,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: floatingActionButtons))
          : null,
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.white,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                AppTheme.kAppBarGradient1,
                AppTheme.kAppBarGradient2
              ],
            ),
          ),
        ),
        title: Center(
          child: Text(
            'Messageries'.toUpperCase(),
            style: AppTheme.appBarTitleTextStyle,
            textScaleFactor: 1,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.to(VideoChat(displayName: authController.name));
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        index: 2,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              AppTheme.kAppBarGradient1,
              AppTheme.kAppBarGradient2
            ],
          ),
        ),
        child: Column(
          children: [
            if (!(_callState == SignalingState.CallStateIncoming ||
                _callState == SignalingState.CallStateOutgoing ||
                _callState == SignalingState.CallStateConnected))
              Container(
                height: 160,
                width: Get.width,
                child: buildProfile(),
              ),
            //   child: ListView.builder(
            //       scrollDirection: Axis.horizontal,
            //       itemCount: 5,
            //       itemBuilder: (context, index) {
            //         if (index == 0) {
            //           return Padding(
            //             padding: const EdgeInsets.only(
            //               left: 25.0,
            //             ),
            //             child: Icon(
            //               Icons.add_circle_rounded,
            //               size: 50,
            //               color: Colors.white,
            //             ),
            //           );
            //         }
            //         return Column(
            //           children: [
            //             Container(
            //               height: 90,
            //               width: 90,
            //               child: Stack(
            //                 children: [
            //                   Container(
            //                     margin: EdgeInsets.only(
            //                         top: 30, bottom: 10, left: 40),
            //                     height: 60,
            //                     width: 60,
            //                     child: CircleAvatar(
            //                       backgroundColor: Colors.white,
            //                     ),
            //                   ),
            //                   Positioned(
            //                     bottom: 5.5,
            //                     right: 5.5,
            //                     child: Container(
            //                       height: 15,
            //                       width: 15,
            //                       decoration: BoxDecoration(
            //                           color: Colors.green,
            //                           borderRadius: BorderRadius.circular(100)),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //             Container(
            //               margin: EdgeInsets.only(left: 40),
            //               height: 35,
            //               width: 60,
            //               child: Text('Robenson Mathiew'),
            //             )
            //           ],
            //         );
            //       }),
            // ),
            Expanded(
              child: Container(
                decoration: (_callState == SignalingState.CallStateIncoming ||
                        _callState == SignalingState.CallStateOutgoing ||
                        _callState == SignalingState.CallStateConnected)
                    ? null
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(70),
                          topRight: Radius.circular(70),
                        ),
                      ),
                child: _callState == SignalingState.CallStateIncoming ||
                        _callState == SignalingState.CallStateOutgoing ||
                        _callState == SignalingState.CallStateConnected
                    ? OrientationBuilder(builder: (context, orientation) {
                        return new Container(
                          child: new Stack(children: <Widget>[
                            new Positioned(
                                left: 0.0,
                                right: 0.0,
                                top: 0.0,
                                bottom: 0.0,
                                child: new Container(
                                  margin: new EdgeInsets.fromLTRB(
                                      0.0, 0.0, 0.0, 0.0),
                                  width: MediaQuery.of(context).size.width,
                                  height: MediaQuery.of(context).size.height,
                                  child: Column(
                                    children: <Widget>[
                                      new Text(_currentPeer['name'],
                                          style: TextStyle(
                                              fontSize: 20.0,
                                              color: Colors.white)),
                                      Expanded(
                                          child: new RTCVideoView(
                                              _remoteRenderer)),
                                    ],
                                  ),
                                  decoration:
                                      new BoxDecoration(color: Colors.black54),
                                )),
                            new Positioned(
                              left: 20.0,
                              top: 20.0,
                              child: new Container(
                                width: orientation == Orientation.portrait
                                    ? 90.0
                                    : 120.0,
                                height: orientation == Orientation.portrait
                                    ? 120.0
                                    : 90.0,
                                child: new RTCVideoView(_localRenderer),
                                decoration:
                                    new BoxDecoration(color: Colors.black54),
                              ),
                            ),
                          ]),
                        );
                      })
                    : _peers == null || _peers.length == 0
                        ? Center(
                            child: Text(
                              _connected
                                  ? 'Aucune persone n\'est connecté'
                                  : 'Service non disponible !',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Multi',
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(0.0),
                            itemCount: (_peers.length),
                            itemBuilder: (ctx, i) {
                              return Container(
                                height: 50,
                                width: Get.width - 50,
                                margin: EdgeInsets.symmetric(
                                  horizontal: 25,
                                  vertical: 35,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color.fromRGBO(0, 96, 162, .5),
                                  border: Border.all(
                                      color: Color(0xffE9E9E9), width: 1),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          _peers[i]['name'],
                                          style: AppTheme
                                              .formTitleBlackBoldTextStyle,
                                        ),
                                        _peers[i]['session_id'] != null
                                            ? Text('busy',
                                                style: TextStyle(
                                                    color: Colors.red))
                                            : Text('free',
                                                style: TextStyle(
                                                    color: Colors.green)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 100.0,
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.videocam,
                                          color: Color(0xff7E7E7E),
                                        ),
                                        onPressed: () => _peers[i]
                                                    ['session_id'] ==
                                                null
                                            ? _invitePeer(
                                                context, _peers[i]['id'], false)
                                            : null,
                                        tooltip: 'Video calling',
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
              ),
            )
          ],
        ),
      ),
    );
  }

  buildProfile() {
    return Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(250, 50),
            bottomRight: Radius.elliptical(250, 50),
          ),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              AppTheme.kAppBarGradient1,
              AppTheme.kAppBarGradient2
            ],
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 110,
              width: 110,
              margin: EdgeInsets.only(right: 5, top: 5),
              child: Stack(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: NetworkImage(
                        API.SERVER_BASE_URL + '/user/me/picture',
                        headers: {
                          'Authorization': 'Bearer ' + _authController.token
                        },
                      ),
                    ),
                  ),
                  Positioned(
                      left: 5,
                      top: 5,
                      child: Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Container(
                            height: 18,
                            width: 18,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.green,
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  userProfile.firstName + ' ' + userProfile.lastName,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontFamily: 'Multi',
                    fontWeight: FontWeight.bold,
                    height: 1.35,
                    letterSpacing: 1.05,
                  ),
                ),
                Text(
                  userProfile.departmentName,
                  textScaleFactor: 1.0,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontFamily: 'Multi',
                    fontWeight: FontWeight.normal,
                    height: 2,
                    letterSpacing: .75,
                  ),
                ),
              ],
            )
          ],
        ));
  }

  @override
  initState() {
    super.initState();

    incall.checkRecordPermission();
    incall.requestRecordPermission();
    incall.checkCameraPermission();
    incall.requestCameraPermission();

    _init();
    _connect();
  }

  _init() async {
    await _localRenderer.initialize();
    await _remoteRenderer.initialize();
  }

  @override
  deactivate() {
    super.deactivate();

    if (_signaling != null) {
      _hangUp();
      _signaling.close();
    }

    _localRenderer.dispose();
    _remoteRenderer.dispose();
  }

  void _connect() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    clientId = prefs.getString('clientId');

    if (clientId == null) {
      clientId = new Uuid().v1();
      prefs.setString('clientId', clientId);
    }

    if (_signaling == null) {
      _signaling = new Signaling(serverIP, clientId, displayName)..connect();

      _signaling.onStateChange = (SignalingState state, String peerId) {
        switch (state) {
          case SignalingState.CallStateOutgoing:
            incall.start(
              media: MediaType.VIDEO,
              auto: true,
              ringback: '_DTMF_',
            );
            this.setState(() {
              _callState = state;
            });
            break;
          case SignalingState.CallStateIdle:
            _currentPeer = null;
            this.setState(() {
              _localRenderer.srcObject = null;
              _remoteRenderer.srcObject = null;
              _callState = state;
            });

            incall.stopRingtone();
            incall.stop(busytone: '_DTMF_');
            break;
          case SignalingState.CallStateConnected:
            incall.stopRingback();
            incall.stopRingtone();
            incall.start(media: MediaType.VIDEO, auto: true, ringback: '');
            this.setState(() {
              _callState = state;
            });
            break;
          case SignalingState.CallStateIncoming:
            _currentPeer = _peers.singleWhere((i) => i['id'] == peerId);
            incall.startRingtone(RingtoneUriType.DEFAULT, 'default', 30);
            this.setState(() {
              _callState = state;
            });
            break;
          case SignalingState.ConnectionClosed:
            this.setState(() {
              _connected = false;
            });
            break;
          case SignalingState.ConnectionError:
            this.setState(() {
              _connected = false;
            });
            break;
          case SignalingState.ConnectionOpen:
            this.setState(() {
              _connected = true;
            });
            break;
        }
      };

      _signaling.onPeersUpdate = ((event) {
        this.setState(() {
          _selfId = event['self'];
          _peers = event['peers'];
        });
      });

      _signaling.onLocalStream = ((stream) {
        _localRenderer.srcObject = stream;
      });

      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    }
  }

  _invitePeer(context, peerId, use_screen) async {
    if (_signaling != null && peerId != _selfId) {
      _currentPeer = _peers.singleWhere((i) => i['id'] == peerId);
      _signaling.invite(peerId, 'video', use_screen);
    }
  }

  _hangUp() {
    incall.stopRingtone();
    incall.stop(busytone: '_DTMF_');

    if (_signaling != null) {
      _signaling.bye();
    }
  }

  _pickUp() {
    if (_signaling != null) {
      _signaling.answer();
      _signaling.raiseStateChange(SignalingState.CallStateConnected);
    }
  }

  _switchCamera() {
    _signaling.switchCamera();
  }
}
