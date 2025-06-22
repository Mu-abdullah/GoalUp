enum Gender { male, female }

class GenderStatus {
  static String getGender(Gender gender) => gender.name;

  static bool isMale(Gender gender) {
    return gender == Gender.male;
  }
}
