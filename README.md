=>ToDo List App
->Overview
The ToDo List app is designed to help users efficiently manage their tasks and stay organized. It offers a simple and intuitive interface for adding, viewing, and managing tasks. The primary focus was on creating a user-friendly experience while leveraging Flutter's capabilities for a responsive and attractive design.

Thought Process
1. User Experience (UX)
Simplicity: Ensure the app is easy to use with minimal clicks required to add, view, and manage tasks.
Intuitive Design: Follow familiar patterns for task management apps, so users can quickly understand how to use the app without a steep learning curve.
Accessibility: Use accessible colors, fonts, and interaction patterns to make the app usable for as many people as possible.
2. Core Features
Add Task: Allow users to quickly add a new task with essential details like title and optional description.
View Tasks: Provide a clear and organized view of tasks, distinguishing between completed and pending tasks.
Edit/Delete Tasks: Enable users to edit or delete tasks to keep their list up-to-date.
Mark as Complete: Allow users to mark tasks as complete to track progress.
3. Visual Design
Consistency: Use a consistent color scheme and typography throughout the app to create a cohesive look.
Hierarchy: Establish a visual hierarchy with larger, bolder text for task titles and smaller, lighter text for descriptions.
Interactivity: Ensure interactive elements like buttons and icons are easily recognizable and provide visual feedback on interaction.
4. Technical Considerations
State Management: Use a robust state management solution (like Provider or Riverpod) to manage the state of tasks efficiently.
Data Persistence: Implement local storage (using SQLite or Hive) to save tasks persistently, ensuring data is not lost between app sessions.
Responsiveness: Ensure the app works smoothly on various screen sizes and orientations, providing a good experience on both phones and tablets.

Design Decisions
1. UI Components
ListView for Task List: Utilize a ListView to display tasks in a scrollable list, allowing users to see multiple tasks at once.
ListTile for Tasks: Use ListTile widgets within the ListView for each task, providing a structured and familiar layout for task details.
Container for Styling: Wrap ListTile widgets in Container widgets to add styling elements like shadows and border radii, enhancing the visual appeal.
TextField for Input: Use TextField widgets with custom background colors and rounded corners to provide an attractive and user-friendly input interface.
2. Styling
Custom Decorations: Apply BoxDecoration to Container widgets to add shadows and border radii, giving the app a modern and polished look.
Color Scheme: Choose a calming and professional color scheme to create a pleasant user experience. Light background colors for TextField widgets improve readability.
Consistent Padding: Apply consistent padding around elements to ensure the layout is clean and elements are not cramped.
3. Interactivity
GestureDetector for Actions: Wrap ListTile widgets with GestureDetector or InkWell to handle taps for editing and deleting tasks.
Visual Feedback: Provide visual feedback for interactions, such as changing the color or adding a shadow when a task is pressed, to enhance the interactive experience.
