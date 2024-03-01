import 'package:todo/models/task.dart';

var listTask = [
  Task(
    id: '1',
    title: 'Get started with Flutter',
    content:
        'With codelabs, YouTube videos, detailed docs, and more, find everything you need to get started with Flutter or continue your learning journey.',
    isCompleted: false,
    date: DateTime(2024, 2, 10, 10, 30),
  ),
  Task(
    id: '2',
    title: 'Get started with React Native',
    content:
        'Learn the Basics. React Native is like React, but it uses native components instead of web components as building blocks.',
    isCompleted: false,
    date: DateTime(2024, 2, 10, 21, 00),
  ),
  Task(
      id: '3',
      title: 'Learn CI/CD for Flutter',
      content:
          'Learn how to deploy your Flutter app following CI/CD principles with GitHub Actions as a tool.',
      isCompleted: false,
      date: DateTime(2023, 3, 10, 12, 00)),
  Task(
    id: '4',
    title: 'Learn Riverpod for Flutter',
    content:
        'Understand what is Flutter Riverpod APIs in this step-by-step tutorial. Also, learn its usage and the benefits of using Riverpod over the Provider package.',
    isCompleted: false,
    date: DateTime(2024, 2, 20, 23, 00),
  ),
  Task(
    id: '5',
    title: 'Learn Animation for Flutter',
    content:
        'Learn how to build explicit animations in Flutter. After introducing some of the essential concepts, classes, and methods in the animation library, it walks you through 5 animation examples.',
    isCompleted: false,
    date: DateTime(2024, 2, 25, 15, 30),
  ),
  Task(
    id: '6',
    title: 'Learn UX/UI for Flutter',
    content:
        'Explore Flutter potential for UX/UI designers, from Material Design principles to responsive design, animations, and accessibility.',
    isCompleted: true,
    date: DateTime(2024, 1, 9, 17, 00),
  ),
  Task(
    id: '7',
    title: 'Learn HTTP Requests Management for Flutter',
    content:
        'Create an example Flutter app that uses the http package to perform HTTP requests to display placeholder information.',
    isCompleted: true,
    date: DateTime(2024, 2, 3, 8, 00),
  ),
];
