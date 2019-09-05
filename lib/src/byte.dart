import 'dart:convert';

import 'bit_buffer.dart';
import 'mode.dart' as qr_mode;

class QrByte {
  final int mode = qr_mode.mode8bitByte;
  final List<int> _data;

  factory QrByte(String input) {
    var charUnits = _hexTo8(input);

    return QrByte._internal(charUnits);
  }

  QrByte._internal(this._data);

  int get length => _data.length;

  static List<int> _hexTo8(String data) {
    var len = data.length / 2;
    List<int> list;
    for (var i = 0; i < len; i++) {
      var hexStr = data.substring(i * 2, i * 2 + 2);
      var hexI = int.parse(hexStr, radix: 16);
      list.add(hexI);
    }
    return list;
  }

  void write(QrBitBuffer buffer) {
    for (final v in _data) {
      buffer.put(v, 8);
    }
  }
}
