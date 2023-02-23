import 'package:eimunisasi_nakes/features/rekam_medis/data/models/pemeriksaan_model.dart';
import 'package:flutter/material.dart';

import 'line_chart_template.dart';

class GrafikPertumbuhan extends StatefulWidget {
  final LineChartType type;
  final List<PemeriksaanModel> listData;
  final bool? isBoy;
  const GrafikPertumbuhan({
    Key? key,
    required this.type,
    required this.listData,
    required this.isBoy,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => GrafikPertumbuhanState();
}

class GrafikPertumbuhanState extends State<GrafikPertumbuhan> {
  late bool isShowingMainData;
  late double minX;
  late double maxX;
  bool isZoomIn = false;

  @override
  void initState() {
    super.initState();
    isShowingMainData = true;
    minX = 1;
    maxX = 5;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(18)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: GestureDetector(
          onDoubleTap: () {
            if (isZoomIn) {
              setState(() {
                isZoomIn = false;
                minX = 1;
                maxX = 5;
              });
            } else {
              setState(() {
                isZoomIn = true;
                minX = 1;
                maxX = 24;
              });
            }
          },
          onHorizontalDragUpdate: (dragUpdDet) {
            setState(() {
              double primDelta = dragUpdDet.primaryDelta ?? 0.0;
              if (primDelta != 0) {
                if (minX == 0 && primDelta < 0) {
                  return;
                }
                if (maxX >= 24 && primDelta > 0) {
                  return;
                }
                if (primDelta.isNegative) {
                  minX += maxX * 0.005;
                  maxX += maxX * 0.005;
                } else {
                  minX -= maxX * 0.005;
                  maxX -= maxX * 0.005;
                }
              }
            });
          },
          child: LineChartTemplate(
            type: widget.type,
            isShowingMainData: isShowingMainData,
            maxX: maxX,
            minX: minX,
            maxY: null,
            minY: null,
            isBoy: widget.isBoy,
            listData: widget.listData,
          ),
        ),
      ),
    );
  }
}
