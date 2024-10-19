import 'package:febwpss/theme/app.colors.dart';
import 'package:flutter/material.dart';

class TabBarWakaf extends StatefulWidget {
  const TabBarWakaf({super.key});

  @override
  State<TabBarWakaf> createState() => _TabBarWakafState();
}

class _TabBarWakafState extends State<TabBarWakaf> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Column(
        children: [
          TabBar(
            indicatorColor: appPrimaryColor,
            labelColor: appPrimaryColor,
            unselectedLabelColor: Colors.grey,
            labelStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold, // Gaya teks saat tab aktif
            ),
            unselectedLabelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal, // Gaya teks saat tab tidak aktif
            ),
            overlayColor: WidgetStatePropertyAll(
              Colors.green.withOpacity(0.1),
            ),
            onTap: (value) {
              print('Tab $value selected');
            },
            tabs: const [
              Tab(text: 'Keterangan'),
              Tab(text: 'Kabar Terbaru'),
              Tab(text: 'Donatur (2)'),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 500,
            child: TabBarView(
              children: [
                ListView(
                  scrollDirection: Axis.vertical,
                  children: const [
                    Text(
                        '''Mari bersama-sama kita dukung pengembangan Sekolah Toleransi di Jombang. SMA ini mendidik siswa/santri bahwa mereka dilahirkan oleh keluarga dan bertempat tinggal di lokasi berbeda. Mereka punya adat istiadat, suku, ras, bahasa, dan bangsa berbeda pula. Mereka akan belajar memalahmai perbedaan. Akhirnya, manusia paling baik adalah manusia yang paling memberikan manfaat bagi manusia lain.

Perbedaan adalah rahmat dari Tuhan Yang Maha Kuasa. Perbedaan jutru memperkaya keaneka-ragaman budaya, bahasa, takarama bangsa ini.  Mari dukung anak muda berkembang dan memperkaya bangsa melalui perbedaan!

Pengembangan sekolah ini membutuhkan dana Rp 7,831,200,000,- (tujuh miliar delapanratus tigapuluh satu juta dan duaratus rupiah).

Mari bersama-sama kita dukung pengembangan Sekolah Toleransi di Jombang. SMA ini mendidik siswa/santri bahwa mereka dilahirkan oleh keluarga dan bertempat tinggal di lokasi berbeda. Mereka punya adat istiadat, suku, ras, bahasa, dan bangsa berbeda pula. Mereka akan belajar memalahmai perbedaan. Akhirnya, manusia paling baik adalah manusia yang paling memberikan manfaat bagi manusia lain.

Perbedaan adalah rahmat dari Tuhan Yang Maha Kuasa. Perbedaan jutru memperkaya keaneka-ragaman budaya, bahasa, takarama bangsa ini.  Mari dukung anak muda berkembang dan memperkaya bangsa melalui perbedaan!

Pengembangan sekolah ini membutuhkan dana Rp 7,831,200,000,- (tujuh miliar delapanratus tigapuluh satu juta dan duaratus rupiah).

Mari bersama-sama kita dukung pengembangan Sekolah Toleransi di Jombang. SMA ini mendidik siswa/santri bahwa mereka dilahirkan oleh keluarga dan bertempat tinggal di lokasi berbeda. Mereka punya adat istiadat, suku, ras, bahasa, dan bangsa berbeda pula. Mereka akan belajar memalahmai perbedaan. Akhirnya, manusia paling baik adalah manusia yang paling memberikan manfaat bagi manusia lain.

Perbedaan adalah rahmat dari Tuhan Yang Maha Kuasa. Perbedaan jutru memperkaya keaneka-ragaman budaya, bahasa, takarama bangsa ini.  Mari dukung anak muda berkembang dan memperkaya bangsa melalui perbedaan!

Pengembangan sekolah ini membutuhkan dana Rp 7,831,200,000,- (tujuh miliar delapanratus tigapuluh satu juta dan duaratus rupiah).
'''),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(3, (index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(8)),
                      child: const ListTile(
                        leading: Icon(Icons.info),
                        title: Text('BWPSS is published'),
                        titleTextStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                        subtitle: Text('13 Oktober 2024'),
                        subtitleTextStyle:
                            TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    );
                  }),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: ListTile(
                          title: const Text(
                            'Hamba Allah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Rp 1.000.000.000.000 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          trailing: const Text('2 tahun lalu'),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                                color: Colors.grey.shade300, width: 1)),
                        child: ListTile(
                          title: const Text(
                            'Hamba Allah',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: RichText(
                            text: const TextSpan(
                              style: TextStyle(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Rp 1.000.000.000.000 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          trailing: const Text('2 tahun lalu'),
                        ))
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
