import 'package:campli_app/konfigurasi/color.dart';

///
/// Widget untuk clipPath.
/// Gabungan dua widget: tombol dan tulisan keterangan dibawahnya.
///

import 'package:flutter/material.dart';
import 'package:campli_app/konfigurasi/style_clip_path.dart';

/// ClipPath bagian beranda
class ClipPathHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        child: Container(
          height: TINGGI_CLIPPATH,
          decoration: BoxDecoration(
            gradient: GRADIEN_CLIPPATH,
          ),
        ),
      ),
    );
  }
}

class ClipPathHeaderBeranda extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        child: Container(
          height: 130,
          decoration: BoxDecoration(
            gradient: GRADIEN_CLIPPATH,
          ),
        ),
      ),
    );
  }
}

/// ClipPath bagian list tiang dan riwayat
class ClipPathHeader2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ClipPath(
        child: Container(
          height: TINGGI_CLIPPATH2,
          decoration: BoxDecoration(
            gradient: GRADIEN_CLIPPATH,
          ),
        ),
      ),
    );
  }
}
