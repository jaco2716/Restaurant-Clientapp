import 'dart:async';

import 'dart:io';

class NetworkAddress {
  NetworkAddress(this.ip, this.exists);
  bool exists;
  String ip;
}

class NetworkAnalyzer {
  static Stream<NetworkAddress> discover2(
    String subnet,
    int port, {
    Duration timeout = const Duration(seconds: 1),
  }) {
    if (port < 1 || port > 65535) {
      throw 'Incorrect port';
    }
    // TODo : validate subnet

    final out = StreamController<NetworkAddress>();
    final futures = <Future<Socket>>[];
    for (int i = 1; i < 256; ++i) {
      final host = '$subnet.$i';
      final Future<Socket> f = _ping(host, port, timeout);
      futures.add(f);
      f.then((socket) {
        socket.destroy();
        out.sink.add(NetworkAddress(host, true));
      }).catchError((dynamic e) {
        if (!(e is SocketException)) {
          throw e;
        }

        // Check if connection timed out or we got one of predefined errors
        if (e.osError == null || _errorCodes.contains(e.osError?.errorCode)) {
          out.sink.add(NetworkAddress(host, false));
        } else {
          // Error 23,24: Too many open files in system
          throw e;
        }
      });
    }

    Future.wait<Socket>(futures)
        .then<void>((sockets) => out.close())
        .catchError((dynamic e) => out.close());

    return out.stream;
  }

  static Future<Socket> _ping(String host, int port, Duration timeout) {
    return Socket.connect(host, port, timeout: timeout).then((socket) {
      print(socket.toString());
      return socket;
    });
  }

  static final _errorCodes = [13, 49, 61, 64, 65, 101, 111, 113];

  static Stream<NetworkAddress> discover(
    String subnet,
    int port, {
    Duration timeout = const Duration(milliseconds: 400),
  }) async* {
    if (port < 1 || port > 65535) {
      throw 'Incorrect port';
    }
    // TODo : validate subnet

    for (int i = 1; i < 256; ++i) {
      final host = '$subnet.$i';

      try {
        final Socket s = await Socket.connect(host, port, timeout: timeout);
        s.destroy();
        yield NetworkAddress(host, true);
      } catch (e) {
        if (!(e is SocketException)) {
          rethrow;
        }

        // Check if connection timed out or we got one of predefined errors
        if (e.osError == null || _errorCodes.contains(e.osError?.errorCode)) {
          yield NetworkAddress(host, false);
        } else {
          // Error 23,24: Too many open files in system
          rethrow;
        }
      }
    }
  }
}
