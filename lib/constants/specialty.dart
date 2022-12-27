class Specialty {
  final String name;
  final String? key;

  const Specialty({required this.name, this.key});
}

List<Specialty> SPECIALTIES_OPTION = [
  const Specialty(key: null, name: "Tất cả"),
  const Specialty(key: "english-for-kids", name: "Tiếng Anh cho trẻ em"),
  const Specialty(key: "business-english", name: "Tiếng Anh cho công việc"),
  const Specialty(key: "conversational-english", name: "Giao tiếp"),
  const Specialty(name: "STARTERS", key: "starters"),
  const Specialty(name: "MOVERS", key: "movers"),
  const Specialty(name: "FLYERS", key: "flyers"),
  const Specialty(name: "KET", key: "ket"),
  const Specialty(name: "PET", key: "pet"),
  const Specialty(name: "IELTS", key: "ielts"),
  const Specialty(name: "TOEFL", key: "toefl"),
  const Specialty(name: "TOEIC", key: "toeic")
];

Map<String, String> SPECIALTIES = {
  "english-for-kids": "Tiếng Anh cho trẻ em",
  "business-english": "Tiếng Anh cho công việc",
  "conversational-english": "Giao tiếp",
  "starters": "STARTERS",
  "movers": "MOVERS",
  "flyers": "FLYERS",
  "ket": "KET",
  "pet": "PET",
  "ielts": "IELTS",
  "toefl": "TOEFL",
  "toeic": "TOEIC"
};

List<Specialty> SUBJECTS = [
  const Specialty(key: "english-for-kids", name: "Tiếng Anh cho trẻ em"),
  const Specialty(key: "business-english", name: "Tiếng Anh cho công việc"),
  const Specialty(key: "conversational-english", name: "Giao tiếp"),
];

List<Specialty> TEST_PREPARATIONS = [
  const Specialty(name: "STARTERS", key: "starters"),
  const Specialty(name: "MOVERS", key: "movers"),
  const Specialty(name: "FLYERS", key: "flyers"),
  const Specialty(name: "KET", key: "ket"),
  const Specialty(name: "PET", key: "pet"),
  const Specialty(name: "IELTS", key: "ielts"),
  const Specialty(name: "TOEFL", key: "toefl"),
  const Specialty(name: "TOEIC", key: "toeic")
];
