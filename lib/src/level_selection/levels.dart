// Copyright 2022, the Flutter project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

const gameLevels = [
  GameLevel(number: 1),
  GameLevel(number: 2),
  GameLevel(number: 3),
];

class GameLevel {
  final int number;

  const GameLevel({required this.number});
}
