List<String> soundNamesForType(SoundType type) {
  switch (type) {
    case SoundType.jump:
      return const [
        'jump1.mp3',
        'jump2.mp3',
        'jump3.mp3',
      ];
    case SoundType.buttonTap:
      return const [
        'button1.mp3',
        'button2.mp3',
        'button3.mp3',
      ];
    case SoundType.win:
      return const [
        'win1.mp3',
        'win2.mp3',
        'win3.mp3',
      ];
    case SoundType.loose:
      return const [
        'lose1.mp3',
        'lose2.mp3',
        'lose3.mp3',
      ];
  }
}

enum SoundType {
  jump,
  buttonTap,
  win,
  loose,
}
