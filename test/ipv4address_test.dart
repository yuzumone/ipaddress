import 'package:ipaddr/ipaddr.dart';
import 'package:ipaddr/src/exception.dart';
import 'package:test/test.dart';

void main() {
  group('IPv4Address tests', () {
    IPv4Address addr;

    test('OK: from ip string', () {
      var ipStr = '192.168.10.10';
      var ipInt = 3232238090;
      addr = IPv4Address(ipStr);
      expect(addr.toString(), ipStr);
      expect(addr.toInt(), ipInt);
    });

    test('OK: from ip int', () {
      var ipStr = '192.168.10.10';
      var ipInt = 3232238090;
      addr = IPv4Address.fromInt(ipInt);
      expect(addr.toString(), ipStr);
      expect(addr.toInt(), ipInt);
    });

    test('OK: equal test', () {
      var ipStr = '192.168.10.10';
      expect(IPv4Address(ipStr) == IPv4Address(ipStr), true);
    });

    test('OK: plus test', () {
      expect((IPv4Address('192.168.10.9') + 1) == IPv4Address('192.168.10.10'),
          true);
    });

    test('OK: minus test', () {
      expect((IPv4Address('192.168.10.11') - 1) == IPv4Address('192.168.10.10'),
          true);
    });

    test('NG: include subnet', () {
      var fault = '192.168.10.10/24';
      expect(
          () => IPv4Address(fault), throwsA(TypeMatcher<AddressValueError>()));
    });

    test('NG: address is null', () {
      expect(
          () => IPv4Address(null), throwsA(TypeMatcher<AddressValueError>()));
      expect(() => IPv4Address.fromInt(null),
          throwsA(TypeMatcher<AddressValueError>()));
    });

    test('NG: address is not 4 octects', () {
      var fault = '100.100.100';
      expect(
          () => IPv4Address(fault), throwsA(TypeMatcher<AddressValueError>()));
    });

    test('NG: address over 3 str length', () {
      var fault = '1000.10.10.10';
      expect(() => IPv4Address(fault), throwsA(TypeMatcher<ValueError>()));
    });

    test('NG: address over 255', () {
      var fault = '100.10.10.256';
      expect(() => IPv4Address(fault), throwsA(TypeMatcher<ValueError>()));
    });

    test('OK: plus over 4294967295', () {
      var addr = IPv4Address('255.255.255.255');
      expect(() => addr + 100, throwsA(TypeMatcher<AddressValueError>()));
    });

    test('OK: minus under 0', () {
      var addr = IPv4Address('0.0.0.0');
      expect(() => addr - 100, throwsA(TypeMatcher<AddressValueError>()));
    });
  });
}
