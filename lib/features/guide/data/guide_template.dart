class GuideQuestion {
  final int step;
  final String title;
  final String content;

  const GuideQuestion({
    required this.step,
    required this.title,
    required this.content,
  });
}

class GuideTemplate {
  final String templateId;
  final String theme;
  final String description;
  final List<GuideQuestion> questions;

  const GuideTemplate({
    required this.templateId,
    required this.theme,
    required this.description,
    required this.questions,
  });

  static const List<GuideTemplate> templates = [
    GuideTemplate(
      templateId: 'basic_01',
      theme: '기본 묵상',
      description: '매일 꾸준히 말씀을 깊이 있게 묵상하는 3단계 가이드',
      questions: [
        GuideQuestion(
          step: 1,
          title: '말씀 마주하기 (관찰)',
          content: '오늘 말씀에서 가장 눈에 띄거나 마음에 머무는 단어와 구절은 무엇인가요?',
        ),
        GuideQuestion(
          step: 2,
          title: '마음속에 멈춰 서기 (해석)',
          content: '이 말씀이 오늘 나의 상황이나 감정, 마음 상태와 어떻게 연결되나요?',
        ),
        GuideQuestion(
          step: 3,
          title: '삶으로 스며들기 (적용)',
          content: '오늘 하루 이 말씀을 기억하며 내가 행동으로 옮길 수 있는 구체적인 실천은 무엇인가요?',
        ),
      ],
    ),
    GuideTemplate(
      templateId: 'comfort_01',
      theme: '위로가 필요할 때',
      description: '마음이 지치고 힘들 때 하나님의 위로를 찾는 가이드',
      questions: [
        GuideQuestion(
          step: 1,
          title: '말씀 마주하기 (관찰)',
          content: '오늘 말씀 중에서 내 지친 마음을 가장 따뜻하게 안아주는 구절은 어디인가요?',
        ),
        GuideQuestion(
          step: 2,
          title: '마음속에 멈춰 서기 (해석)',
          content: '하나님이 이 구절을 통해 지금 내게 어떤 위로의 음성을 들려주시는 것 같나요?',
        ),
        GuideQuestion(
          step: 3,
          title: '삶으로 스며들기 (적용)',
          content: '나의 무거운 짐 중 오늘 하나님께 온전히 맡겨드릴 한 가지는 무엇인가요?',
        ),
      ],
    ),
    GuideTemplate(
      templateId: 'wisdom_01',
      theme: '지혜가 필요할 때',
      description: '중요한 선택과 결정 앞에서 방향을 구하는 가이드',
      questions: [
        GuideQuestion(
          step: 1,
          title: '말씀 마주하기 (관찰)',
          content: '본문 속에서 하나님이 원하시는 올바른 길이나 성품은 무엇으로 표현되어 있나요?',
        ),
        GuideQuestion(
          step: 2,
          title: '마음속에 멈춰 서기 (해석)',
          content: '하나님이 오늘 말씀을 통해 내가 걸어가야 할 방향에 대해 어떤 힌트를 주고 계신가요?',
        ),
        GuideQuestion(
          step: 3,
          title: '삶으로 스며들기 (적용)',
          content: '내가 앞둔 선택에서 내 고집을 내려놓고 순종해야 할 작은 결단은 무엇인가요?',
        ),
      ],
    ),
    GuideTemplate(
      templateId: 'question_01',
      theme: '질문이 가득할 때',
      description: '신앙적인 의문이나 이해되지 않는 상황을 묻고 구하는 가이드',
      questions: [
        GuideQuestion(
          step: 1,
          title: '말씀 마주하기 (관찰)',
          content: '이 구절을 읽으며 직관적으로 가장 이해되지 않거나 부딪히는 부분은 어디인가요?',
        ),
        GuideQuestion(
          step: 2,
          title: '마음속에 멈춰 서기 (해석)',
          content: '이 풀리지 않는 질문 이면에 내 안에 숨어있는 두려움이나 오해는 무엇일까요?',
        ),
        GuideQuestion(
          step: 3,
          title: '삶으로 스며들기 (적용)',
          content: '완벽한 답을 찾기 전에, 오늘 하루 이 질문을 안고 어떻게 하나님을 신뢰하며 나아갈 수 있을까요?',
        ),
      ],
    ),
  ];

  static GuideTemplate getById(String id) {
    return templates.firstWhere((t) => t.templateId == id, orElse: () => templates.first);
  }
}
