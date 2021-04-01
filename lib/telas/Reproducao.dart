import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube/models/Video.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class Reproducao extends StatefulWidget {
  Video video;
  Reproducao(this.video);
  @override
  _ReproducaoState createState() => _ReproducaoState();
}

class _ReproducaoState extends State<Reproducao> {

  YoutubePlayerController _controller;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;


  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.id,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        topActions: <Widget>[
          const SizedBox(width: 8.0),
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
              size: 25.0,
            ),
            onPressed: () {
              log('Settings Tapped!');
            },
          ),
        ],
      ),
      builder: (context, player) => Scaffold(
        body: ListView(
          children: [
            player,
            Center(
              child: Container(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      widget.video.titulo,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top:16),
                      child: Text(
                        widget.video.descricao,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.black54
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
