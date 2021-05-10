import 'package:comedy/utils/enum_util.dart';

class Services {
  static final baseUrl = 'http://167.99.55.39/';

  static String getServices(EndPoint endPoint) {
    switch (endPoint) {

      case EndPoint.CreateEvent:
        return baseUrl + 'api/create-event';
      case EndPoint.GetEvents:
        return baseUrl + 'api/get-all-event';
      case EndPoint.CreatePrompt:
        return baseUrl + 'api/create-prompts';
      case EndPoint.CreateWriteWithoutPrompt:
        return baseUrl + 'api/create-without-prompts';
      case EndPoint.DeleteWriteWithoutPrompt:
        return baseUrl + 'api/delete-without-prompts/';
      case EndPoint.UpdateWriteWithoutPrompt:
        return baseUrl + 'api/update-without-prompts/';

      case EndPoint.CreateAnswerWritingPrompt:
        return baseUrl + 'api/create-answer-writing-prompt';
      case EndPoint.UpdateAnswerWritingPrompt:
        return baseUrl + 'api/update-answer/';
      case EndPoint.DeleteAnswerWritingPrompt:
        return baseUrl + 'api/delete-answer/';


      case EndPoint.SavedPrompt:
        return baseUrl + 'api/save-prompts';
      case EndPoint.GetSavedPrompt:
        return baseUrl + 'api/get-saved-prompts';
      case EndPoint.GetSampleQuestions:
        return baseUrl + 'api/get-answer-writing-prompt';
      default:
        return '';
    }
  }
}
