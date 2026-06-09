import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

    @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: const Color(0xFFF8FAFC),
              elevation: 0,
              centerTitle: true,
              iconTheme: const IconThemeData(color: Color(0xFF1E293B)),
              // Kunci: AppBar hilang default, muncul pas scroll ke bawah
              pinned: false,
              floating: true,
              snap: true,
              expandedHeight: 90, // Tinggi total AppBar + Kartu Profil
              title: const Text(
                "PAPAN PERFORMA",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: const Color(0xFFF8FAFC),
                  padding: EdgeInsets.only(
                    top: kToolbarHeight + topPadding + 6,
                    left: 16,
                    right: 16,
                    bottom: 9,
                  ),
                  alignment: Alignment.bottomCenter,
                  // ==================== KARTU PROFIL ATLET ====================
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFF334155), width: 1),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PAPAN PERFORMA KOMPREHENSIF',
                          style: TextStyle(
                            color: Colors.blueGrey[300],
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          '${widget.activeMurid.id} - ${widget.activeMurid.nama}',
                          style: const TextStyle(
                            color: Color(0xFF38BDF8),
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        // Body bebas pake Column biasa. Gak error
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ==================== GRAFIK BOXPLOT ====================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 4, height: 16, color: const Color(0xFF38BDF8)),
                        const SizedBox(width: 8),
                        const Text(
                          'DISTRIBUSI MOTORIK TIM VS INDIVIDU (BOXPLOT)',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF38BDF8)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 250,
                      child: MetaBoxplotChart(
                        boxData: widget.activeMurid.boxData,
                        teamAverages: widget.teamBoxAverages,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ==================== GRAFIK RADAR ====================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 4, height: 16, color: const Color(0xFF22C55E)),
                        const SizedBox(width: 8),
                        const Text(
                          'PROFIL BIOMOTORIK METRIKS RADAR (10 DIMENSI)',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w900, color: Color(0xFF22C55E)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 320,
                      child: MetaRadarChart(
                        dataIndividu: widget.activeMurid.radarData,
                        rataRataTim: widget.teamRadarAverages,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // ==================== TABEL MATRIKS ANALISIS GERAK ====================
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFF334155)),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(width: 4, height: 16, color: const Color(0xFF10B981)),
                        const SizedBox(width: 8),
                        const Text(
                          'MATRIKS ANALISIS GERAK & REKOMENDASI TAKTIS',
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF10B981)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: SizedBox(
                        width: 1050,
                        child: Table(
                          border: TableBorder.all(color: const Color(0xFF334155), width: 1),
                          columnWidths: const {
                            0: FlexColumnWidth(1.8),
                            1: FlexColumnWidth(2.3),
                            2: FlexColumnWidth(2.5),
                            3: FlexColumnWidth(2.3),
                            4: FlexColumnWidth(2.3),
                            5: FlexColumnWidth(3.4)
                          },
                          children: [
                            TableRow(
                              decoration: const BoxDecoration(color: Color(0xFF0F172A)),
                              children: [
                                _buildHeaderCell('KOMPONEN'),
                                _buildHeaderCell('POLA BOXPLOT'),
                                _buildHeaderCell('ARTI POLA'),
                                _buildHeaderCell('KELEBIHAN'),
                                _buildHeaderCell('KEKURANGAN'),
                                _buildHeaderCell('REKOMENDASI')
                              ],
                            ),
                            _buildEvaluasiRow('STRENGTH', 'BOXPLOT', 0),
                            _buildEvaluasiRow('ENDURANCE', 'BOXPLOT', 1),
                            _buildEvaluasiRow('SPEED', 'BOXPLOT', 2),
                            _buildEvaluasiRow('COORDINATION', 'BOXPLOT', 3),
                            _buildEvaluasiRow('FLEXIBILITY', 'BOXPLOT', 4),
                            _buildEvaluasiRow('BALANCE', 'BOXPLOT', 5),
                            _buildEvaluasiRow('REACTION TIME', 'BOXPLOT', 6),
                            _buildEvaluasiRow('MUSCULAR ENDURANCE', 'BOXPLOT', 1),
                            _buildEvaluasiRow('POWER', 'BOXPLOT', 0),
                            _buildEvaluasiRow('CORE STABILITY', 'BOXPLOT', 0),
                            _buildEvaluasiRow('DYNAMIC FLEXIBILITY', 'BOXPLOT', 4),
                            _buildEvaluasiRow('SPEED ENDURANCE', 'BOXPLOT', 2),
                            _buildEvaluasiRow('REACTIVE SPEED / QUICKNESS', 'BOXPLOT', 6),
                            _buildEvaluasiRow('ANTICIPATION & SPATIAL AWARENESS', 'BOXPLOT', 3),
                            _buildEvaluasiRow('AGILITY', 'RADAR', 8),
                            _buildEvaluasiRow('MOBILITY', 'RADAR', 9),
                            _buildEvaluasiRow('OPEN/REACTIVE AGILITY', 'RADAR', 2),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Map<String, String> _analisisKomplet40Pola(int idx, String namaKomponen) {
    if (idx >= widget.activeMurid.boxData.length || widget.activeMurid.boxData[idx].length < 6) {
      return {"pola": "-", "arti": "Data fungsional belum lengkap."};
    }

    final List<double> data = widget.activeMurid.boxData[idx];
    double min = data[0];
    double q1 = data[1];
    double q2 = data[2];
    double q3 = data[4];
    double max = data[5];

    double dLower = q2 - q1;
    double dUpper = q3 - q2;
    double iqr = q3 - q1;
    double wLower = q1 - min;
    double wUpper = max - q3;

    String skew = "";
    String kurtosis = "";

    if ((dUpper - dLower).abs() <= 2.0 && (wUpper - wLower).abs() <= 3.0) {
      skew = "Symmetrical";
    } else if (dUpper > dLower && wUpper > wLower) {
      skew = "Extremely Skewed Right";
    } else if (dUpper > dLower) {
      skew = "Mildly Skewed Right";
    } else if (dLower > dUpper && wLower > wUpper) {
      skew = "Extremely Skewed Left";
    } else {
      skew = "Mildly Skewed Left";
    }

    if (iqr < 10) {
      kurtosis = "Leptokurtic (Narrow)";
    } else if (iqr > 38) {
      kurtosis = "Platykurtic (Wide)";
    } else {
      kurtosis = "Mesokurtic (Optimal)";
    }

    String artiFisik = "";
    if (skew == "Symmetrical") {
      if (kurtosis == "Mesokurtic (Optimal)") {
        artiFisik = "Kondisi Peak Performance. Distribusi energi ideal & stabil.";
      } else if (kurtosis == "Leptokurtic (Narrow)") {
        artiFisik = "Stagnan/Plato. Konsisten, tapi butuh variasi beban baru.";
      } else {
        artiFisik = "Performa labil. Kadang sangat bagus, kadang drop. Fokus repetisi dasar.";
      }
    } else if (skew == "Mildly Skewed Right") {
      if (kurtosis == "Mesokurtic (Optimal)") {
        artiFisik = "Fase adaptasi positif. Otot merespons program latihan dengan baik.";
      } else if (kurtosis == "Leptokurtic (Narrow)") {
        artiFisik = "Perkembangan lambat tapi pasti. Pertahankan volume latihan sirkuit.";
      } else {
        artiFisik = "Adaptasi tak merata. Ada potensi, tapi teknik eksekusi masih gogah.";
      }
    } else if (skew == "Extremely Skewed Right") {
      if (kurtosis == "Mesokurtic (Optimal)") {
        artiFisik = "Potensi lonjakan daya. Jaga waktu recovery agar tidak overtraining.";
      } else if (kurtosis == "Leptokurtic (Narrow)") {
        artiFisik = "Bakat terpendam di area ini. Dorong limit perlahan saat tes fungsional.";
      } else {
        artiFisik = "Hasil anomali. Evaluasi apakah form/postur gerakan sudah sesuai standar.";
      }
    } else if (skew == "Mildly Skewed Left") {
      if (kurtosis == "Mesokurtic (Optimal)") {
        artiFisik = "Tanda awal kelelahan. Kapasitas ada, tapi eksekusi mulai terasa berat.";
      } else if (kurtosis == "Leptokurtic (Narrow)") {
        artiFisik = "Kapasitas terkunci di bawah rata-rata. Perlu drilling teknik perbaikan.";
      } else {
        artiFisik = "Inkonsistensi akibat fatigue ringan. Kurangi durasi, tingkatkan presisi.";
      }
    } else if (skew == "Extremely Skewed Left") {
      if (kurtosis == "Mesokurtic (Optimal)") {
        artiFisik = "Kelelahan saraf pusat (CNS Fatigue). Segera turunkan beban (Deloading)!";
      } else if (kurtosis == "Leptokurtic (Narrow)") {
        artiFisik = "Titik lemah fatal. Wajib remedial & intervensi program biomekanik spesifik.";
      } else {
        artiFisik = "Drop performa drastis. Periksa faktor luar (sakit, stres, kurang tidur).";
      }
    }

    return {"pola": "$skew\n($kurtosis)", "arti": artiFisik};
  }

  TableRow _buildEvaluasiRow(String namaKomponen, String tipeGrafik, int dataIdx) {
    bool diAtasRataTim = false;
    bool belumAdaData = true;
    String labelPola = "-";
    String labelArti = "-";

    String kelebihanText = "";
    String kekuranganText = "";
    String rekomendasiText = "";

    bool adaDataDiInput = widget.activeMurid.riwayatLatihanKuantitatif.any((e) =>
            e['klasifikasi'].toString().toUpperCase() == namaKomponen.toUpperCase() ||
            widget.dapatkanBoxIndexFunc(e['klasifikasi'].toString()) == dataIdx) ||
        widget.activeMurid.riwayatLatihanDurasi.any((e) =>
            e['klasifikasi'].toString().toUpperCase() == namaKomponen.toUpperCase() ||
            widget.dapatkanBoxIndexFunc(e['klasifikasi'].toString()) == dataIdx) ||
        (tipeGrafik == "BOXPLOT" && dataIdx < widget.activeMurid.boxData.length && widget.activeMurid.boxData[dataIdx][3] > 0) ||
        (tipeGrafik == "RADAR" && dataIdx < widget.activeMurid.radarData.length && widget.activeMurid.radarData[dataIdx] > 0);

    if (tipeGrafik == "BOXPLOT") {
      Map<String, String> hasilPola = _analisisKomplet40Pola(dataIdx, namaKomponen);
      labelPola = hasilPola["pola"]!;
      labelArti = hasilPola["arti"]!;

      if (adaDataDiInput && dataIdx < widget.activeMurid.boxData.length) {
        belumAdaData = false;
        diAtasRataTim = widget.activeMurid.boxData[dataIdx][3] >= (dataIdx < widget.teamBoxAverages.length? widget.teamBoxAverages[dataIdx] : 0.0);

        String polaString = labelPola.toUpperCase();

        if (diAtasRataTim) {
          kelebihanText = "Unggul di kelas. Power output melompat di atas standar tim.";
          if (polaString.contains("SYMMETRICAL")) {
            kelebihanText = "Dominasi mutlak. Kapasitas tinggi didukung akurasi gerak yang sangat kokoh.";
          } else if (polaString.contains("RIGHT")) {
            kelebihanText = "Sangat eksplosif. Grafik mendeteksi adanya bakat lonjakan biomekanik.";
          }
        } else {
          kelebihanText = "Pondasi gerak terbentuk. Konsistensi teknik dasar di zona aman.";
          if (polaString.contains("NARROW")) {
            kelebihanText = "Sangat konsisten. Deviasi error gerakan sangat kecil saat kelelahan.";
          }
        }

        if (!diAtasRataTim) {
          kekuranganText = "Defisit volume target. Kalah saing secara output dari rata-rata tim.";
          if (polaString.contains("LEFT")) {
            kekuranganText = "Drop akut akibat fatigue. Saraf motorik kewalahan menahan beban.";
          } else if (polaString.contains("WIDE")) {
            kekuranganText = "Performa sangat labil. Akurasi reps berantakan jika ritme dipercepat.";
          }
        } else {
          kekuranganText = "Tantangan stagnasi. Risiko terjebak zona nyaman grafik plato.";
          if (polaString.contains("RIGHT")) {
            kekuranganText = "Otot cepat pulih namun rentan over-confidence, form gerak agak ceroboh.";
          }
        }

        if (polaString.contains("LEFT") && polaString.contains("NARROW")) {
          rekomendasiText = "EMERGENCY REMEDIAL! Hentikan sirkuit, drill ulang teknik dasar dasar.";
        } else if (polaString.contains("LEFT")) {
          rekomendasiText = "DELOADING PHASE: Potong volume latihan 30% untuk pemulihan CNS.";
        } else if (polaString.contains("RIGHT") && diAtasRataTim) {
          rekomendasiText = "UPGRADE SPESIFIK: Berikan beban khusus untuk target akselerasi prestasi.";
        } else if (polaString.contains("NARROW")) {
          rekomendasiText = "BREAK THE PLATO: Ubah variasi tempo & manipulasi rest-period sirkuit.";
        } else if (polaString.contains("WIDE")) {
          rekomendasiText = "STABILIZATION: Perbanyak repetisi statis demi mengunci memori otot.";
        } else {
          rekomendasiText = "MAINTAIN: Pertahankan periodisasi latihan, siap naik kelas.";
        }
      }
    } else {
      if (adaDataDiInput && dataIdx < widget.activeMurid.radarData.length) {
        belumAdaData = false;
        diAtasRataTim = widget.activeMurid.radarData[dataIdx] >= (dataIdx < widget.teamRadarAverages.length? widget.teamRadarAverages[dataIdx] : 0.0);

        if (diAtasRataTim) {
          kelebihanText = "Kelincahan & Fight IQ taktis responsif, di atas rata-rata tim.";
          kekuranganText = "Memerlukan lawan tanding (sparring) sepadan agar tidak jenuh.";
          rekomendasiText = "OPEN DRILL: Libatkan dalam simulasi pertarungan situasi tak terduga.";
        } else {
          kelebihanText = "Sudah memahami pola koordinasi perubahan arah langkah.";
          kekuranganText = "Reaksi kaki lambat, jaring koordinasi masih menguncup sempit.";
          rekomendasiText = "AGILITY LADDER: Genjot drill kecepatan kaki & koordinasi motorik bawah.";
        }
      }
    }

    if (belumAdaData) {
      kelebihanText = "Data rekam kosong.";
      kekuranganText = "Menunggu uji fisik.";
      rekomendasiText = "Silakan masukkan data latihan siswa di tab REPS / WAKTU.";
    }

    return TableRow(
      children: [
        Padding(padding: const EdgeInsets.all(8.0), child: Text(namaKomponen, style: const TextStyle(color: Colors.white, fontSize: 8.5, fontWeight: FontWeight.bold))),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(labelPola, style: TextStyle(color: belumAdaData? const Color(0x33FFFFFF) : Colors.amber[400], fontSize: 8))),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(labelArti, style: TextStyle(color: belumAdaData? const Color(0x33FFFFFF) : const Color(0xFF34D399), fontSize: 8))),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(kelebihanText, style: const TextStyle(fontSize: 8.5, color: Colors.white70))),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(kekuranganText, style: const TextStyle(fontSize: 8.5, color: Colors.white70))),
        Padding(padding: const EdgeInsets.all(8.0), child: Text(rekomendasiText, style: const TextStyle(fontSize: 8.5, color: Color(0xFF38BDF8), fontWeight: FontWeight.w500))),
      ],
    );
  }
}
}
