# Swift Student Challenge 2026 — Submission Strategy Guide
## Elements App by Adon Omeri

**Deadline: February 28, 2026, 11:59 PM PST**

> This document goes through **every single field** in the submission form and tells you exactly how to approach it for maximum impact. It does NOT write the answers for you — it coaches you on what the judges are looking for and how to frame your genuine story.

---

## Table of Contents
1. [Your Information (Basic Fields)](#1-your-information)
2. [Student Status & Documentation](#2-student-status)
3. [App Playground — Technical Submission](#3-app-playground)
4. [Name of Your App Playground](#4-app-name)
5. [Screenshots (3 Required)](#5-screenshots)
6. [Which Software to Run It](#6-software)
7. [ESSAY: What Problem & Inspiration](#7-problem-and-inspiration)
8. [ESSAY: Who Would Benefit & How](#8-who-benefits)
9. [ESSAY: How Accessibility Factored In](#9-accessibility)
10. [ESSAY: Open Source Software Used](#10-open-source)
11. [ESSAY: AI Tools Used](#11-ai-tools)
12. [ESSAY: Other Technologies Used & Why](#12-other-technologies)
13. [ESSAY: Beyond the Swift Student Challenge](#13-beyond-ssc)
14. [Apps on App Store (Optional)](#14-app-store)
15. [Comments (Optional)](#15-comments)
16. [General Tips — What Winners Say](#16-general-tips)
17. [Pre-Submission Checklist](#17-checklist)

---

## 1. Your Information (Basic Fields) <a name="1-your-information"></a>

These are straightforward. Double-check:
- **Name**: Adon Omeri — make sure it matches your enrollment documentation exactly.
- **Email**: omeriadon@icloud.com — make sure you can receive emails here. Check spam folder regularly after submitting.
- **Phone**: Correct Australian number with +61 country code.
- **Age**: You're selecting the 13-17 bracket (or 18+, whichever is accurate). Be honest.
- **Guardian info**: Since you may be under 18, this needs to be filled out completely and accurately. Make sure your guardian's email is one they actually check.

**Action item**: Confirm with your guardian (Suzan Robeh) that she's aware and will respond if Apple contacts her.

---

## 2. Student Status & Documentation <a name="2-student-status"></a>

- **Status**: Enrolled in Secondary/High School
- **School**: Perth Modern School
- **Documentation**: You need a PDF/PNG/JPEG that clearly shows:
  1. Your full name (Adon Omeri)
  2. Perth Modern School
  3. Dates showing it's current (valid as of Feb 2026)

**What to use**: Your 2026 class schedule/timetable is ideal. If you don't have one yet for Term 1 2026, an enrollment confirmation letter from the school works too. Ask your school admin for a letter on school letterhead if needed.

**Educational Supervisor**: This is your principal or deputy principal at Perth Modern School. Get their:
- Full name
- School email address
- School phone number

**Do this NOW if you haven't already** — getting this documentation can take days.

---

## 3. App Playground — Technical Submission <a name="3-app-playground"></a>

### ZIP File Requirements
- Must be under **25 MB**
- Must contain your `.swiftpm` file
- Must work **offline** (no network dependency)

**Your situation**: Your app loads all 118 elements from a local `elements.json` file — good, that's fully offline. However, your `QuizView` uses `FoundationModels` (Apple Intelligence) which runs **on-device** — this is allowed per the rules: *"On-device Apple Intelligence frameworks and other Apple technologies may be used."*

**Critical things to verify**:
1. **ZIP your `.swiftpm` folder** and check the file size. Your `PeriodicTableData.swift` is ~9,748 lines (it's a massive inline JSON string) plus you have `elements.json` in Resources. You may be duplicating data. Consider whether you need both — the app uses `loadElements()` which reads from `elements.json`, so the `elementsString` in `PeriodicTableData.swift` may be dead code. **Removing it could save significant size.**
2. **Test the app from a clean state** — delete the app, install from the .swiftpm, open it. Does the intro show? Does everything work?
3. **Test on a physical device if possible**, especially the quiz feature (Apple Intelligence availability).
4. Your dependency on `ColorfulX` (the animated gradient library) gets bundled — make sure the total ZIP stays under 25 MB.

### Which Software
- Select **Xcode 26** (since your `Package.swift` targets iOS 26.0 and uses iOS 26 APIs like `.glassEffect`, `.safeAreaBar`, `.tabBarMinimizeBehavior`, and `FoundationModels`).

---

## 4. Name of Your App Playground <a name="4-app-name"></a>

**"Elements"**

This is clean, clear, and memorable. Don't overthink it. It tells the judge exactly what they're about to see.

---

## 5. Screenshots (3 Required) <a name="5-screenshots"></a>

This is more important than most people think. The judges see your screenshots before they even run your app. These are your first impression.

### Recommended 3 screenshots:

1. **The Periodic Table View** — Show the full grid with colour-coded element categories visible. This immediately communicates "this is a serious chemistry app." Try to capture it with a few bookmarked elements visible so the bookmark icons show up.

2. **The Element Detail View** — Pick a visually interesting element (Hydrogen, Carbon, or Gold work well). Show the animated electron shell diagram at the top, the header with the glass-effect symbol badge, and some of the property sections below. This showcases your most technically complex UI.

3. **The Quiz View** — Show an active quiz with some questions visible, ideally with a mix of answered and unanswered questions. This demonstrates the Apple Intelligence integration which is your biggest differentiator.

### Screenshot tips:
- Use a **real device** or **Simulator** — not a raw Xcode preview
- Make sure **Dynamic Type is at default size** so text is crisp and readable
- **Light mode** generally photographs better, but if your app has particularly nice glass effects in dark mode, consider it
- No status bar clutter — use Simulator where you control the time/battery display
- **PNG format, high resolution**

---

## 6. Which Software to Run <a name="6-software"></a>

Select **Xcode** (your Package.swift targets iOS 26.0, uses Xcode 26 APIs).

Note: The rules say "Xcode app playgrounds are run in Simulator." Make sure your app runs correctly in iPad Simulator and iPhone Simulator.

---

## 7. ESSAY: "What problem is your app playground trying to solve and what inspired you to solve it?" <a name="7-problem-and-inspiration"></a>

**200 words. This is probably the most important essay.**

### What the judges want to see:
- A **real problem** you identified (not a made-up one)
- A **personal connection** to that problem
- How your specific app solves it — not vague handwaving

### Strategy:

**Open with the personal hook.** Every single winner from the articles you shared emphasized this: *the story behind your app matters as much as the app itself.* The judge reading this is looking for genuine motivation, not marketing speak.

**Framework for your answer:**

1. **The problem (2-3 sentences)**: Traditional periodic table resources (textbooks, posters, websites) are static and overwhelming. Students see a wall of 118 boxes with cryptic symbols and numbers with no way to explore or test their understanding. For students who struggle with chemistry, there's no adaptive way to learn at their own pace.

2. **Your personal connection (2-3 sentences)**: Why does chemistry education matter to YOU? Did you struggle with it yourself? Did you see classmates struggle? Are you passionate about science? Do you think existing tools are boring? Be honest and specific here — the judges can smell generic motivation from a mile away. Think about *one specific moment* that made you want to build this.

3. **How Elements solves it (2-3 sentences)**: Your app transforms the periodic table from a static grid into an interactive exploration tool with comprehensive data for every element, and uses Apple Intelligence to generate personalized quizzes that adapt to the student's level — creating a feedback loop between learning and testing.

### Pitfalls to avoid:
- Don't list technologies here — that's for the technology question
- Don't be generic ("I wanted to help students learn") — be specific about WHAT and WHY
- Don't undersell your personal story — this is where authenticity wins

> I was a chemistry student, but I found it hard to engage with traditional periodic tables. They were static and either too simple to get useful information out of or too complex to understand at a glance. Remembering valencies and bonds was like an impossible task, and I struggled to make real use out of the data they presented, and because they were static and didn't adapt to my level of understanding, I found it harder to build a good understanding of the subject. I was quite frustrated with how inaccessible and boring these tools were.
> 
> So, I wanted to create an app that could help me as a student, that would help make the periodic table more accessible and engaging. I wanted to turn the periodic table into a tool that adapts to the user's level of understanding, making it easier to explore and learn and test their knowledge.

---

## 8. ESSAY: "Who would benefit from your app playground and how?" <a name="8-who-benefits"></a>

**200 words.**

### What the judges want to see:
- Specific user groups (not "everyone")
- Concrete benefits (not "they would learn better")
- Awareness of diverse users

### Strategy:

**Identify 2-3 specific user groups and explain the specific benefit for each:**

1. **High school chemistry students** — Students studying for exams can use the detailed element data (11 categories of properties from atomic structure to nuclear data) as a comprehensive reference, and test their knowledge with AI-generated quizzes at easy, medium, or hard difficulty. The quiz adapts: easy mode covers the first 20 elements, medium covers 50, hard covers all 118.

2. **Students with different learning needs** — Your app has Dynamic Type support (capped at `.accessibility1` to prevent layout breaking), VoiceOver labels on interactive elements, Reduce Motion support that disables the spinning electron animation, customizable visibility settings (students can hide overwhelming sections and focus on what they need), and haptic feedback that provides tactile confirmation.

3. **Self-directed learners / curious minds** — The bookmark system lets users curate their own study list, the searchable list view with multi-filter (category, phase, group, period, block) lets them explore patterns in the periodic table, and the detailed element summaries provide Wikipedia-sourced context.

### What makes this strong:
- You're demonstrating you thought about REAL users, not imaginary ones
- Each benefit maps directly to a feature you actually built
- You're showing accessibility awareness naturally (which sets up the next essay)

> This app is for students who don't like using paper periodic tables that either don’t have enough information or have too much, and aren't helpful for learning. My app aims to fix that by being very customisable - you can choose what element properties you see and filter to only show the elements you need to see, so that it's never too simple or too overwhelming. I also added a quiz feature that uses Apple Intelligence that lets you test yourself at your own knowledge level. I also made this app offline because most periodic table apps need an internet connection, which isn't always accessible for everyone. The general aim of my app is to be customisable, accessible, and reliable for everyone, no matter their learning style or situation.

---

## 9. ESSAY: "How did accessibility factor into your design process?" <a name="9-accessibility"></a>

**200 words. This is where your app genuinely shines — and the judges care deeply about this.**

### What the judges want to see:
- Accessibility as a **design consideration from the start**, not an afterthought
- Specific, concrete examples from your code
- Awareness of multiple accessibility dimensions

### Your app's ACTUAL accessibility features (from reading your code):

You have a legitimately strong accessibility story. Here's what you built:

1. **Dynamic Type with careful bounds**: You use `.dynamicTypeSize(...DynamicTypeSize.accessibility1)` throughout — this means you support larger text sizes but cap it before layouts break. This shows you TESTED it at different sizes and found the right balance. In the `ElementCell` in TableView, you cap even tighter at `.xxLarge` because the grid cells are fixed-width. This level of thoughtfulness is exactly what judges look for.

2. **Reduce Motion support**: Your `@Environment(\.accessibilityReduceMotion)` is used throughout the app. The spinning electron shell diagram stops spinning. Animations throughout the app are conditionally disabled. This shows you understand that motion can cause discomfort or nausea for some users.

3. **VoiceOver support**: Your electron shell diagram has proper `accessibilityLabel`, `accessibilityHint`, and is marked as `accessibilityHidden(true)` because it's purely decorative when using VoiceOver. Bookmark buttons have descriptive hints ("Adds this element to your bookmarks"). The copy button states have different accessibility hints for copied vs. not-copied states.

4. **Haptic feedback with user control**: You built a `HapticManager` with an opt-out toggle in Settings. Haptics provide tactile confirmation of interactions but can be disabled for users who find them distracting.

5. **Customizable information density**: The Settings view lets users toggle the visibility of 11 entire sections and 60+ individual data rows. This is a cognitive accessibility feature — students aren't overwhelmed by data they don't need.

6. **TipKit for progressive disclosure**: Tips appear one at a time (using `TipGroup(.firstAvailable)`) to avoid overwhelming new users with information.

### How to frame this:

Structure your answer around the PRACTICE, not just the features:
- "Accessibility was a core design constraint, not a final checklist item"
- Mention that you tested at different Dynamic Type sizes and adjusted accordingly
- Mention the reduce motion support and WHY it matters
- Mention the customizable visibility as cognitive accessibility
- Emphasize that you gave users CONTROL (haptics toggle, section toggles, tip dismissal)

---

## 10. ESSAY: "Did you use open source software?" <a name="10-open-source"></a>

**You selected Yes. 200 words.**

### What the judges want to see:
- What you used and what it does
- WHY you chose it (not just "because it looks cool")
- That you understand what it does under the hood
- That you comply with its license

### Your open source dependency:

From your `Package.swift`:
```
.package(url: "https://github.com/Lakr233/ColorfulX.git", "6.0.1" ..< "7.0.0")
```

**ColorfulX** — A high-performance animated gradient library for SwiftUI.

You also use code from **VariableBlurView** (credited in your `VariableBlur.swift` to `github.com/jtrivedi/VariableBlurView`) — this is essentially embedded open-source code, not a package dependency.

### How to frame this:

1. **ColorfulX**: Explain you used it for the animated gradient background in your onboarding/intro view (`ColorfulView(color: .lavandula)`). Explain WHY: creating smooth, GPU-accelerated multi-color gradient animations from scratch would have been complex and distracted from the educational core of your app. The library uses Metal for high performance. Mention its MIT license.

2. **VariableBlurView**: Mention you used an adapted version of Jatin Trivedi's VariableBlurView for the variable blur effect at the top of the list view when the keyboard is visible. This creates a smooth visual transition instead of a hard edge. Credit the original author.

### Key point to convey:
You chose open source strategically for visual polish elements that don't affect the educational core logic, which is entirely your own work.

---

## 11. ESSAY: "Did you use AI tools?" <a name="11-ai-tools"></a>

**You selected Yes. 200 words. This is a critical essay — be honest and strategic.**

### What the judges want to see:
From the rules: *"participants are expected to demonstrate significant individual contributions and technical understanding"*

From the Reddit winner: *"AI probably helped me with more than 50% of the technical implementation. And that's totally fine. Apple doesn't expect you to be a senior iOS developer. They want to see that you can solve problems and think creatively."*

### Strategy:

**Be honest but frame it around YOUR understanding and decision-making.**

Structure your answer in three parts:

1. **Which tools**: Name the specific AI tools you used (e.g., GitHub Copilot, ChatGPT, Claude — whatever you actually used).

2. **What you used them for**: Be specific. Examples:
   - Helped structure the `Element` data model with its 80+ properties and associated enums
   - Assisted with complex SwiftUI layout patterns (the scrollable periodic table grid)
   - Helped debug issues with `@Query` predicates in SwiftData
   - Suggested approaches for quiz generation prompts with `FoundationModels`

3. **What YOU learned / YOUR contribution**: This is the most important part. Emphasize:
   - You designed the app architecture (the tab-based navigation, the section-based detail view, the quiz flow)
   - You made all the UX decisions (TipKit progressive disclosure, the filter system, accessibility considerations)
   - You understood every framework integration and could explain why each technology was chosen
   - AI helped you code faster, but the *design thinking and problem-solving* was yours

### The tone to strike:
"I used AI as an accelerator, not a replacement for understanding. Every design decision, user experience choice, and framework integration reflects my own learning and problem-solving."

---

## 12. ESSAY: "What other technologies did you use and why?" <a name="12-other-technologies"></a>

**200 words. This is your chance to flex your technical knowledge.**

### What the judges want to see:
- Breadth of Apple framework knowledge
- Intentionality — WHY each technology, not just WHAT
- Understanding of what each framework actually does

### Your technology stack (from reading your entire codebase):

| Technology | Where You Use It | Why |
|---|---|---|
| **SwiftUI** | Entire UI | Declarative, reactive UI with modern patterns |
| **FoundationModels** | Quiz generation & grading | On-device AI for personalized learning — this is Apple Intelligence |
| **SwiftData** | Bookmark persistence | Lightweight persistence with `@Model`, `@Query`, and predicates |
| **TipKit** | 6 contextual tips | Progressive disclosure — guide users without overwhelming them |
| **UIKit** (via UIImpactFeedbackGenerator) | Haptic feedback | Tactile response for interactions |
| **Core Image** | VariableBlur gradient mask | Creating smooth blur gradients with `CIFilter.linearGradient()` |

### Plus notable SwiftUI patterns:
- `matchedTransitionSource` + `.navigationTransition(.zoom)` — zoom transitions when opening element detail
- `.glassEffect` — iOS 26 glass morphism
- `.safeAreaBar` — bottom bar for quiz actions
- `.tabBarMinimizeBehavior(.onScrollDown)` — modern tab bar behavior
- `@AppStorage` for 60+ user preferences
- `LazyVGrid` with custom positioning for the periodic table layout
- `.visualEffect` with scroll-based blur and scale for onboarding pages

### How to structure your answer:

Pick 4-5 of your strongest framework integrations and explain the WHY for each:

1. **FoundationModels (Apple Intelligence)**: "I used Apple Intelligence's FoundationModels framework to generate chemistry quizzes and grade answers on-device. This creates personalized, adaptive learning — each quiz is unique, and the AI grades free-text answers beyond simple string matching. I chose on-device AI specifically because the app must work offline."

2. **SwiftData**: "For the bookmark system, SwiftData provides lightweight persistence with predicate-based queries, letting me filter bookmarks per-element efficiently without a full database."

3. **TipKit with TipGroups**: "TipKit's TipGroup shows tips one at a time via `.firstAvailable`, preventing information overload for new users."

4. **SwiftUI iOS 26 features**: "Glass effects, navigation transitions with matched geometry, and safe area bars create a polished, modern interface."

**Don't just list technologies — show you understand WHY each one was the right choice for your specific use case.**

---

## 13. ESSAY: "Beyond the Swift Student Challenge" <a name="13-beyond-ssc"></a>

**200 words. "Have you shared your app development knowledge with others or used your technology skills to support your community?"**

### What the judges want to see:
- This is about YOU, not your app
- Community involvement, teaching, mentoring, sharing
- Impact beyond yourself

### Strategy:

This is often the weakest essay for most applicants because they haven't done much community work. But think broadly:

**Things that count:**
- Have you helped classmates learn coding or use technology?
- Have you presented about coding/technology at school?
- Have you contributed to online communities (forums, Stack Overflow, Discord servers)?
- Have you tutored anyone in STEM subjects?
- Have you shared projects on GitHub?
- Have you participated in coding clubs, hackathons, or tech events?
- Have you helped a teacher or family member with technology?
- Have you created content (YouTube videos, blog posts, tutorials) about coding?
- Have you volunteered your tech skills for any organization?

**Think about what you've ACTUALLY done and write about that.** Don't make things up — the judges value authenticity.

### Framework for your answer:

1. What you've done (specific examples with details)
2. What impact it had (even small impact counts — "helped 3 classmates understand..." is fine)
3. What you learned from the experience of teaching/sharing
4. How you want to continue contributing

### If you genuinely haven't done much yet:
Focus on what you HAVE done, even if small. Helping one person counts. And mention what you plan to do — showing initiative matters.

---

## 14. Apps on the App Store (Optional) <a name="14-app-store"></a>

**200 words. "This won't influence the judging process."**

They say it won't influence judging, and that's probably mostly true. But if you have apps published, mention them briefly. If you don't, **skip this entirely**. Don't apologize for not having apps — many winners didn't have any.

---

## 15. Comments (Optional) <a name="15-comments"></a>

**200 words. "Is there anything else you'd like us to know?"**

### Strategy:

This is your chance to add context that didn't fit elsewhere. Use it strategically:

**Good things to mention here:**
- Any technical challenge you're particularly proud of solving (e.g., "Fitting comprehensive data for all 118 elements with detailed properties while keeping the ZIP under 25 MB required careful data architecture")
- Your age if you're on the younger side — being a high schooler building with Apple Intelligence is impressive
- Context about your development journey — how long you've been coding, what drew you to Swift
- Anything unique about your circumstances that adds to your story

**Don't use this to:**
- Repeat what you've already said
- Make excuses
- Be overly humble or overly boastful

---

## 16. General Tips — What Winners Say <a name="16-general-tips"></a>

Synthesized from every article and winner interview you shared:

### The Winning Pattern:

1. **Personal story is king.** Every single winner emphasized that the personal motivation behind their app mattered as much as the technical skill. The judges are reading hundreds of submissions — your story makes you memorable.

2. **Solve a real problem.** The Reddit commenter who lost said: *"my app didn't solve a problem, much less a personal problem."* Your app solves the problem of static, inaccessible chemistry education tools. Make sure that comes through clearly.

3. **Align with Apple's current focus.** Apple is pushing Apple Intelligence HARD in 2025-2026. Your use of `FoundationModels` is perfectly aligned. You're literally among the first students to build an educational app with on-device AI generation — lean into this.

4. **Be honest about AI usage.** The winning Reddit poster said 50%+ AI implementation and was honest about it and won. The key is demonstrating understanding, not proving you typed every character.

5. **Quality over quantity.** Your app doesn't need to do everything — it needs to do its thing well. Your app has a clear identity: interactive periodic table + AI quizzes + accessibility. That's a tight, compelling package.

6. **Accessibility wins hearts.** Multiple WWDC scholars and Apple employees emphasize how much Apple values accessibility. Your app has genuine, thoughtful accessibility — this is a major strength.

7. **It must WORK.** From the rules: submissions may be disqualified if "your app playground does not function during the judging process." Test everything. Test it again. Test it on a clean device/simulator.

8. **The 3-minute rule.** Judges need to experience your app within 3 minutes. Your intro onboarding walks them through every view — make sure it's not too long. Currently you have 6 onboarding pages. The judge should be in the actual app exploring within 60 seconds maximum.

### Technical Points Unique to Your App:

**Potential concern — Apple Intelligence availability during judging:**
Your quiz feature requires Apple Intelligence (`FoundationModels`). The judging happens on Simulator per the rules. You've handled all the `.unavailable` states with `ContentUnavailableView` which is great — the app won't crash. But the actual quiz generation won't work if the judge's machine doesn't support it.

**Mitigation**: Your Table View and List View are fully functional without AI. The app stands on its own as a comprehensive periodic table reference. The quiz is a bonus, not the only feature. Your `ContentUnavailableView` messages are clear and professional ("Device Not Eligible", "Apple Intelligence Not Enabled", etc.).

---

## 17. Pre-Submission Checklist <a name="17-checklist"></a>

Before you hit Submit:

### Technical
- [ ] App builds and runs without errors in Xcode 26 / Swift Playgrounds 4.6
- [ ] ZIP file is under 25 MB
- [ ] App works fully offline (no network calls)
- [ ] All resources (elements.json, images) are included in the ZIP
- [ ] Intro onboarding works on first launch
- [ ] Periodic table is scrollable and all 118 elements are tappable
- [ ] Element detail view shows all sections correctly
- [ ] List view search, sort, and filter all work
- [ ] Bookmark add/remove works
- [ ] Settings toggles work (visibility, haptics, reopen onboarding, reset tips)
- [ ] Quiz generates correctly on supported devices
- [ ] Quiz shows appropriate unavailable message on unsupported devices
- [ ] App handles rotation correctly (you support all orientations)
- [ ] No crashes, no purple warnings in console, no memory leaks

### Content
- [ ] All essays are under 200 words (HARD limit — the form will not accept more)
- [ ] All essays are spell-checked
- [ ] All essays answer the specific question asked (not a different question)
- [ ] Screenshots are high quality PNG/JPG, under 5 MB each
- [ ] Student documentation clearly shows your name, school name, and current dates
- [ ] Educational supervisor contact info is filled in
- [ ] Guardian info is correct and your guardian is aware

### The Dead Code Issue
Your `PeriodicTableData.swift` contains a 9,748-line `elementsString` variable that appears to be an alternative way to load element data — but your app actually uses `loadElements()` which reads from `Resources/elements.json`. If `elementsString` is unused dead code, **remove it before submission**. This will significantly reduce your ZIP file size and shows clean code practices.

### Final Read-Through
Read every essay out loud. If something sounds generic or could apply to anyone's app ("I wanted to make learning fun"), rewrite it to be specific to YOUR app and YOUR experience.

---

## Summary: Your Strengths

| Strength | Why It Matters |
|---|---|
| **Apple Intelligence integration** | Perfectly aligned with Apple's 2026 focus; rare in student submissions |
| **Comprehensive accessibility** | Demonstrates maturity and Apple's core value of inclusion |
| **Deep data model** | 80+ properties per element across 11 categories — shows serious engineering |
| **Polished UI** | iOS 26 glass effects, zoom transitions, animated electron shells |
| **Multiple Apple frameworks** | SwiftUI, SwiftData, FoundationModels, TipKit, UIKit, Core Image — 6+ frameworks |
| **User control** | 60+ toggleable settings, bookmark system, difficulty levels — respects the user |
| **Offline-first** | All data bundled locally, AI runs on-device |

## Summary: Your Risks

| Risk | Mitigation |
|---|---|
| Quiz won't work if judge lacks Apple Intelligence | Handled with `ContentUnavailableView`; app has 3 other fully functional tabs |
| ZIP might be too large | Remove dead code (`PeriodicTableData.swift` elementsString), compress images |
| Onboarding too slow for 3-min limit | Consider shortening or making skippable more prominently |
| ColorfulX dependency adds size | Test without it if size is tight; the onboarding background is nice but not essential |

---

**You've got a genuinely strong submission. The app is technically sophisticated, educationally meaningful, and accessibility-focused. Now it's about telling YOUR story in 200-word chunks. Be authentic, be specific, and be proud of what you built. Good luck, Adon.**
