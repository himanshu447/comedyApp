enum EndPoint {
  CreateEvent,
  GetEvents,

  CreatePrompt,

  CreateWriteWithoutPrompt,
  DeleteWriteWithoutPrompt,
  UpdateWriteWithoutPrompt,

  SavedPrompt,
  GetSavedPrompt,

  GetSampleQuestions,

  CreateAnswerWritingPrompt,
  UpdateAnswerWritingPrompt,
  DeleteAnswerWritingPrompt,

}

enum LandingTab {
  home,
  mySaved,
  submitPrompt,
  about,
}

enum Filters{
  aToz,
  zToA,
  newToOldDate,
  oldToNewDate,
  levelHighestToLowest,
  levelLowestToHighest,
  degreeHighestToLowest,
  degreeLowestToHighest,
}
