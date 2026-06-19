// 1. Package Imports
import 'dart:async';
import 'package:flutter/material.dart';

// 2. The Main Function Entry Point
void main() {
  runApp(const MyApp());
}

// 3. The Root Widget Definition
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan pita debug di pojok kanan atas
      
      // ==========================================
      // DI BAGIAN INI: Sudah diubah ke SplashScreen
      // ==========================================
      home: SplashScreen(), 
    );
  }
}

// 4. Widget Halaman Splash Screen Beranimasi
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Alignment> _alignmentAnimation;
  bool _isAtCenter = false; 

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _alignmentAnimation = Tween<Alignment>(
      begin: const Alignment(0, 1.8), 
      end: const Alignment(0, 0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn, 
    ));

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _isAtCenter = true;
        });

        Timer(const Duration(milliseconds: 1500), () {
          if (mounted) {
            // Setelah splash selesai, aplikasi akan mengarah ke HomeShell kamu
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomeShellPlaceholder()), 
            );
          }
        });
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7F00FF),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          'BABE PERKAKAS',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: 220,
                width: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/bgdt.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),

          AnimatedBuilder(
            animation: _alignmentAnimation,
            builder: (context, child) {
              return Align(
                alignment: _alignmentAnimation.value,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300), 
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return ScaleTransition(scale: animation, child: child);
                  },
                  child: _isAtCenter
                      ? const Text(
                          '👆',
                          key: ValueKey('finger_icon'),
                          style: TextStyle(fontSize: 75), 
                        )
                      : const Text(
                          '🛠️',
                          key: ValueKey('tools_icon'),
                          style: TextStyle(fontSize: 65), 
                        ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// 5. Tempat Sementara untuk Halaman Utama setelah Splash Screen
// (Ganti atau arahkan ke class HomeShell utama milikmu yang asli jika sudah siap)
class HomeShellPlaceholder extends StatelessWidget {
  const HomeShellPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog Utama')),
      body: const Center(child: Text('Selamat Datang di Aplikasi Babe Perkakas!')),
    );
  }
}
