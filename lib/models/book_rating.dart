// Cup&Book - Rating Models

enum ViolenceLevel {
  none(0, 'None'),
  fantasyBattles(1, 'Fantasy Battles'),
  action(2, 'Action'),
  intense(3, 'Intense'),
  graphic(4, 'Graphic'),
  graphicWithGore(5, 'Graphic with gore');

  final int value;
  final String label;
  const ViolenceLevel(this.value, this.label);
}

enum ProfanityLevel {
  none(0, 'None'),
  goshDarn(1, 'Gosh/Darn'),
  mild(2, 'Mild'),
  moderate(3, 'Moderate'),
  strongConstant(4, 'Strong/Constant');

  final int value;
  final String label;
  const ProfanityLevel(this.value, this.label);
}

enum SexualContentLevel {
  none(0, 'None'),
  crushHoldingHands(1, 'Crush/Holding Hands'),
  simpleKissPecks(2, 'Simple Kiss Pecks'),
  kissingClosedDoor(3, 'Kissing/Closed-door'),
  partialNudity(4, 'Partial Nudity'),
  explicit(5, 'Explicit');

  final int value;
  final String label;
  const SexualContentLevel(this.value, this.label);
}

enum ScaryLevel {
  sunny(0, 'Sunny'),
  tension(1, 'Tension'),
  spooky(2, 'Spooky'),
  scary(3, 'Scary'),
  nightmare(4, 'Nightmare'),
  horror(5, 'Horror');

  final int value;
  final String label;
  const ScaryLevel(this.value, this.label);
}

enum MatureTopicsLevel {
  none(0, 'None'),
  mentions(1, 'Mentions'),
  discussTheme(2, 'Discuss Theme'),
  majorElement(3, 'Major Element'),
  dark(4, 'Dark'),
  veryDark(5, 'Very Dark');

  final int value;
  final String label;
  const MatureTopicsLevel(this.value, this.label);
}

class BookRating {
  final ViolenceLevel violence;
  final ProfanityLevel profanity;
  final SexualContentLevel sexualContent;
  final ScaryLevel scaryThemes;
  final MatureTopicsLevel matureTopics;

  const BookRating({
    required this.violence,
    required this.profanity,
    required this.sexualContent,
    required this.scaryThemes,
    required this.matureTopics,
  });

  double get averageRating {
    return (violence.value + profanity.value + sexualContent.value +
            scaryThemes.value + matureTopics.value) /
        5.0;
  }

  String get colorStatus => 'green'; // TODO: Implement filter comparison
}