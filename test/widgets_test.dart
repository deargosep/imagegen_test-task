import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:myapp/widgets/prompt_input.dart';
import 'package:myapp/widgets/generate_button.dart';
import 'package:myapp/widgets/result_success.dart';
import 'package:myapp/result_bloc.dart';

void main() {
  testWidgets('PromptInput updates controller and calls onChanged', (tester) async {
    final controller = TextEditingController();
    String? changed;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: PromptInput(controller: controller, onChanged: (s) => changed = s),
      ),
    ));

    expect(find.byType(TextField), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'hello');
    await tester.pumpAndSettle();

    expect(controller.text, 'hello');
    expect(changed, 'hello');
  });

  testWidgets('GenerateButton enabled/disabled and triggers onPressed', (tester) async {
    bool called = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GenerateButton(isEnabled: false, onPressed: () => called = true),
      ),
    ));

    final elevated = find.byType(ElevatedButton);
    expect(elevated, findsOneWidget);
    final ElevatedButton btnWidget = tester.widget<ElevatedButton>(elevated);
    expect(btnWidget.onPressed, isNull);

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GenerateButton(isEnabled: true, onPressed: () => called = true),
      ),
    ));
    await tester.pumpAndSettle();

    final ElevatedButton btnWidget2 = tester.widget<ElevatedButton>(elevated);
    expect(btnWidget2.onPressed, isNotNull);

    await tester.tap(elevated);
    await tester.pumpAndSettle();
    expect(called, isTrue);
  });

  testWidgets('ResultSuccessWidget shows image and buttons and dispatches GenerateImage', (tester) async {
    final fakeBloc = _TestResultBloc();

    final transparentPng = base64Decode(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR4nGNgYAAAAAMAASsJTYQAAAAASUVORK5CYII=');

    await tester.pumpWidget(MaterialApp(
      home: BlocProvider<ResultBloc>.value(
        value: fakeBloc,
        child: Scaffold(
          body: ResultSuccessWidget(imageUrl: 'unused', prompt: 'cat', imageProvider: MemoryImage(transparentPng)),
        ),
      ),
    ));

    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Try Another'), findsOneWidget);
    expect(find.text('New Prompt'), findsOneWidget);

    await tester.tap(find.text('Try Another'));
    await tester.pumpAndSettle();

    expect(fakeBloc.lastAdded, isA<GenerateImage>());
    expect((fakeBloc.lastAdded as GenerateImage).prompt, 'cat');
  });
}

class _TestResultBloc extends ResultBloc {
  ResultEvent? lastAdded;

  _TestResultBloc() : super();

  @override
  void add(ResultEvent event) {
    lastAdded = event;
    // do not call super to avoid side effects in tests
  }
}

// No network mocks needed anymore; we use MemoryImage in the test.

