  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7F00FF), // Default ke ungu jika ada kendala load
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
          // 1. Background Gambar dengan Pengaman Error
          Positioned.fill(
            child: Image.asset(
              'assets/images/bgdt.png', 
              fit: BoxFit.cover,       
              errorBuilder: (context, error, stackTrace) {
                // Jika gambar ga ketemu/gagal load, render warna ungu ini agar tidak BLANK putih
                return Container(
                  color: const Color(0xFF7F00FF),
                  child: const Center(
                    child: Text(
                      'Gagal memuat gambar background, periksa aset kamu.',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ),

          // 2. Animasi Alat & Jari
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