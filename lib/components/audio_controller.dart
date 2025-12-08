import 'dart:async';

// import 'package:flutter/services.dart';
import 'package:flutter_soloud/flutter_soloud.dart';

class AudioController {

  SoLoud? _soloud; 
  dynamic sounds;
  // SoundHandle? _musicHandle;

  Future<void> initialize() async {
    _soloud = SoLoud.instance;
    await _soloud!.init();
    sounds = await [
      SoLoud.instance.loadAsset('assets/sounds/tick1.MP3', mode: LoadMode.memory),
      SoLoud.instance.loadAsset('assets/sounds/tick2.MP3', mode: LoadMode.memory),
      SoLoud.instance.loadAsset('assets/sounds/tick3.MP3', mode: LoadMode.memory),
    ].wait;
  }

  void dispose() {
    _soloud?.deinit();
  }

  Future<void> playSound(int i) async {
    try {
      await _soloud!.play(sounds[i]);
    } on SoLoudException {
      // print("Cannot play sound '$assetKey'. Ignoring. $e");
    }
  }

  // Future<void> startMusic() async {
  //   if (_musicHandle != null) {
  //     if (_soloud!.getIsValidVoiceHandle(_musicHandle!)) {
  //       print('Music is already playing. Stopping first.');
  //       await _soloud!.stop(_musicHandle!);
  //     }
  //   }
  //   print('Loading music');
  //   final musicSource = await _soloud!.loadAsset(
  //     'assets/music/looped-song.ogg',
  //     mode: LoadMode.disk,
  //   );
  //   musicSource.allInstancesFinished.first.then((_) {
  //     _soloud!.disposeSource(musicSource);
  //     print('Music source disposed');
  //     _musicHandle = null;
  //   });

  //   print('Playing music');
  //   _musicHandle = await _soloud!.play(
  //     musicSource,
  //     volume: 3,
  //     looping: true,
  //     loopingStartAt: const Duration(seconds: 25, milliseconds: 43),
  //   );
  // }

  // void fadeOutMusic() {
  //   if (_musicHandle == null) {
  //     print('Nothing to fade out');
  //     return;
  //   }
  //   const length = Duration(seconds: 5);
  //   _soloud!.fadeVolume(_musicHandle!, 0, length);
  //   _soloud!.scheduleStop(_musicHandle!, length);
  // }

  // void applyFilter() {
  //   _soloud!.filters.freeverbFilter.activate();
  //   _soloud!.filters.freeverbFilter.wet.value = 0.2;
  //   _soloud!.filters.freeverbFilter.roomSize.value = 0.9;
  // }

  // void removeFilter() {
  //   _soloud!.filters.freeverbFilter.deactivate();
  // }
}