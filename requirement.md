Question
constraints:
Build one Flutter screen that mimics a Daraz-style product listing, with the following
Layout
A collapsible header (banner/search bar)
●
●
A tab bar that becomes sticky when the header collapses
2–3 tabs, each showing a list of products (mock data is fine)
Scrolling (Most Important)
●
There must be exactly ONE vertical scrollable in the entire screen
Pull-to-refresh must work from any tab
●
Switching tabs must not reset or jump the vertical scroll position
●
No scroll jitter, conflict, or duplicate scrolling
●
The tab bar must remain visible once pinned
Horizontal Navigation
• Tabs must be switchable by:
Tapping
Horizontal swipe
• Horizontal swipe must not introduce or control vertical scrolling
• Gesture handling must be intentional and predictable
Architecture Expectations
• Sliver-based layout is expected
• Clear separation of:
UI
Scroll / gesture ownership
State
Use
Fakestore api : https://fakestoreapi.com/
login and show also user profile
• Avoid fragile solutions (magic numbers, global hacks, etc.)
Mandatory Explanation
Include a short README or code comments explaining:
1. How horizontal swipe was implemented
2. Who owns the vertical scroll and why
3. Trade-offs or limitations of your approach
If you run out of time, explain your approach instead of forcing an incomplete solution.
Submission
GitHub repository or zip
●
Simple run instructions (flutter run)
Evaluation Focus
●
●
●
●
Correct single-scroll architecture
Absence of scroll/gesture conflicts
Clean, understandable structure
Ability to reason and explain decisions
Note:
This is not a UI task.
This is a scroll-architecture and gesture-coordination problem.
Submission Deadline: 28/ 02/2026 11:59PM
Submission Link: https://forms.gle/QhVyeevyLxrZkMFq6