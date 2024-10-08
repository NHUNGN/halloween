import 'package:flutter/material.dart';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BackgroundImageScreen(),
    );
  }
}

class BackgroundImageScreen extends StatefulWidget {
  @override
  _BackgroundImageScreenState createState() => _BackgroundImageScreenState();
}

mixin AudioPlayerMixin {
  late AudioPlayer _audioPlayer;

  void initAudio() {
    _audioPlayer = AudioPlayer();
  }

  Future<void> playSound(String assetPath) async {
    await _audioPlayer.setSource(AssetSource(assetPath));
    await _audioPlayer.resume();
  }

  void disposeAudio() {
    _audioPlayer.dispose();
  }
}

class _BackgroundImageScreenState extends State<BackgroundImageScreen>
    with TickerProviderStateMixin, AudioPlayerMixin {
  late AnimationController _controllerBat;
  late Animation<double> _animationBat;
  late AnimationController _controllerSpider;
  late Animation<double> _animationSpider;

  bool _showGhost = false;
  bool _foundSpecialPumpkin = false;

  @override
  void initState() {
    super.initState();
    initAudio();

    _controllerBat = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    )..repeat();

    _animationBat = Tween<double>(begin: 0, end: 1).animate(_controllerBat);

    _controllerSpider = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat(reverse: true);

    _animationSpider = Tween<double>(begin: 0, end: 1).animate(_controllerSpider);


    _playBackgroundMusic();
  }

  @override
  void dispose() {
    _controllerBat.dispose();
    _controllerSpider.dispose();
    disposeAudio();
    super.dispose();
  }

  void _playBackgroundMusic() async {
    await _audioPlayer.setSource(AssetSource('assets/background_music.mp3'));
    await _audioPlayer.resume(); // Start playing once
  }

  void _onPumpkinTap(bool isSpecial) {
    if (isSpecial) {
      setState(() {
        _foundSpecialPumpkin = true;
      });
    } else {
      setState(() {
        _showGhost = true;
      });
      playSound('jump_scare.mp3');

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _showGhost = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/halloween.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Spooky Halloween Game!',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Animated Bat
          AnimatedBuilder(
            animation: _controllerBat,
            builder: (context, child) {
              double xPosition = MediaQuery.of(context).size.width * _animationBat.value;
              double yPosition = MediaQuery.of(context).size.height / 2 + sin(_animationBat.value * 2 * pi) * 100;

              return Positioned(
                left: xPosition,
                top: yPosition,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/bat.png',
              height: 80,
              width: 80,
            ),
          ),
          // Animated Spider
          AnimatedBuilder(
            animation: _controllerSpider,
            builder: (context, child) {
              double yOffset = _animationSpider.value * 100;

              return Positioned(
                right: 16,
                top: 50 + yOffset,
                child: child!,
              );
            },
            child: Image.asset(
              'assets/spider.png',
              height: 80,
              width: 80,
            ),
          ),
          
          Positioned(
            bottom: 200, 
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),
          
          Positioned(
            bottom: 100, 
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(true), 
                  child: Image.asset(
                    'assets/special_pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
                GestureDetector(
                  onTap: () => _onPumpkinTap(false),
                  child: Image.asset(
                    'assets/pumpkin.png',
                    height: 80,
                    width: 80,
                  ),
                ),
              ],
            ),
          ),
          // Ghost Jump Scare
          if (_showGhost)
            Center(
              child: Image.asset(
                'assets/ghost.jpg', 
                height: 300, 
                width: 300,  
              ),
            ),
          
          if (_foundSpecialPumpkin)
            Center(
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.all(20),
                child: Text(
                  'You Found It!',
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.yellow,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
