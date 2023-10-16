// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Quote extends Equatable {
  const Quote({
    this.series,
    this.lineId,
    this.srtId,
    this.epid,
    this.pid,
    this.quoteUrl,
    this.subLine,
  });

  final String? series;
  final int? lineId;
  final int? srtId;
  final int? epid;
  final int? pid;
  final String? quoteUrl;
  final String? subLine;

  Quote copyWith({
    String? series,
    int? lineId,
    int? srtId,
    int? epid,
    int? pid,
    String? quoteUrl,
    String? subLine,
  }) {
    return Quote(
      series: series ?? this.series,
      lineId: lineId ?? this.lineId,
      srtId: srtId ?? this.srtId,
      epid: epid ?? this.epid,
      pid: pid ?? this.pid,
      quoteUrl: quoteUrl ?? this.quoteUrl,
      subLine: subLine ?? this.subLine,
    );
  }

  Map<String, dynamic> toJson() => {
        "SERIES": series,
        "LINE_ID": lineId,
        "SRT_ID": srtId,
        "EPID": epid,
        "PID": pid,
        "QUOTE_URL": quoteUrl,
        "SUB_LINE": subLine,
      };

  @override
  List<Object?> get props => [
        series,
        lineId,
        srtId,
        epid,
        pid,
        quoteUrl,
        subLine,
      ];
}
