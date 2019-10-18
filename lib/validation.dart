class ValidationUtils {
  static bool healthRiskIsSet(num healthRiskId) {
    return healthRiskId > 0;
  }

  static bool numberOfPeopleSelected(num maleUnder5, num maleOver5, num femaleUnder5, num femaleOver5) {
    return (maleUnder5 > 0) | (maleOver5 > 0) | (femaleOver5 > 0) | (femaleUnder5 > 0);
  }
}