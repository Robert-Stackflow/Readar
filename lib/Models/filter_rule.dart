enum FilterObjectType {
  Title,
  Content,
  Author,
  TitleOrContent,
  TitleAndContent,
  Url,
  FeedUrl,
}

enum FilterRuleType {
  Contains,
  NotContains,
  StartsWith,
  EndsWith,
  Equals,
  NotEquals,
  Matches,
  NotMatches
}

enum FilterOperationType {
  Star,
  Unstar,
  Hide,
  Unhide,
  Read,
  Unread,
  SendNotification,
  NotSendNotification
}

class FilterRule {
  FilterObjectType objectType;
  FilterRuleType ruleType;
  List<FilterOperationType> operations;
  String value;

  FilterRule({
    required this.objectType,
    required this.ruleType,
    required this.value,
    required this.operations,
  });

  FilterRule.hideWhenTitleContains(this.value)
      : objectType = FilterObjectType.Title,
        ruleType = FilterRuleType.Contains,
        operations = [FilterOperationType.Hide];

  FilterRule.hideWhenTitleMatches(this.value)
      : objectType = FilterObjectType.Title,
        ruleType = FilterRuleType.Matches,
        operations = [FilterOperationType.Hide];

  bool check(String title, String content, String author) {
    switch (objectType) {
      case FilterObjectType.Title:
        return checkRule(title);
      case FilterObjectType.Content:
        return checkRule(content);
      case FilterObjectType.Author:
        return checkRule(author);
      case FilterObjectType.TitleOrContent:
        return checkRule(title) || checkRule(content);
      case FilterObjectType.TitleAndContent:
        return checkRule(title) && checkRule(content);
      default:
        return false;
    }
  }

  bool checkRule(String value) {
    switch (ruleType) {
      case FilterRuleType.Contains:
        return value.contains(this.value);
      case FilterRuleType.NotContains:
        return !value.contains(this.value);
      case FilterRuleType.StartsWith:
        return value.startsWith(this.value);
      case FilterRuleType.EndsWith:
        return value.endsWith(this.value);
      case FilterRuleType.Equals:
        return value == this.value;
      case FilterRuleType.NotEquals:
        return value != this.value;
      case FilterRuleType.Matches:
        return RegExp(this.value).hasMatch(value);
      case FilterRuleType.NotMatches:
        return !RegExp(this.value).hasMatch(value);
      default:
        return false;
    }
  }

  factory FilterRule.fromJson(Map<String, dynamic> json) {
    return FilterRule(
        objectType: FilterObjectType.values[json['objectType']],
        ruleType: FilterRuleType.values[json['ruleType']],
        value: json['value'],
        operations: (json['operations'] as List)
            .map((e) => FilterOperationType.values[e])
            .toList());
  }

  Map<String, dynamic> toJson() {
    return {
      'objectType': objectType.index,
      'ruleType': ruleType.index,
      'value': value,
      'operations': operations.map((e) => e.index).toList()
    };
  }
}
