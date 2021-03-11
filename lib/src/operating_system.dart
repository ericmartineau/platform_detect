// Copyright 2017 Workiva Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
import 'package:platform_detect2/src/navigator.dart';

import 'browser.dart';

/// Matches an operating system name with how it is represented in window.navigator
class OperatingSystem {
  static late NavigatorProvider navigator;

  static OperatingSystem getCurrentOperatingSystem() {
    return _knownSystems.firstWhere((system) {
      return system._matchesNavigator != null &&
          system._matchesNavigator!(navigator);
    }, orElse: () => UnknownOS);
  }

  static OperatingSystem UnknownOS = OperatingSystem('Unknown', null);

  final String name;
  final MatchesNavigator? _matchesNavigator;

  OperatingSystem(this.name, this._matchesNavigator);

  static List<OperatingSystem> _knownSystems = [mac, windows, linux, unix];

  get isLinux => this == linux;

  get isMac => this == mac;

  get isUnix => this == unix;

  get isWindows => this == windows;
}

OperatingSystem linux = OperatingSystem('Linux', (NavigatorProvider navigator) {
  return navigator.appVersion?.contains('Linux') == true;
});

OperatingSystem mac = OperatingSystem('Mac', (NavigatorProvider navigator) {
  return navigator.appVersion?.contains('Mac') == true;
});

OperatingSystem unix = OperatingSystem('Unix', (NavigatorProvider navigator) {
  return navigator.appVersion?.contains('X11') == true;
});

OperatingSystem windows =
    OperatingSystem('Windows', (NavigatorProvider navigator) {
  return navigator.appVersion?.contains('Win') == true;
});
