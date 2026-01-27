//
//  IntroView.swift
//  Elements
//
//  Created by Adon Omeri on 12/11/2025.
//

import ColorfulX
import SwiftUI

enum OnboardingPage: String, Identifiable, CaseIterable {
    case welcome
    case tableView
    case listView
    case quizView
    case settingsView
    case elementDetailView

    var id: String { rawValue }

    var name: String {
        switch self {
        case .welcome:
            "Welcome"
        case .tableView:
            "Table"
        case .settingsView:
            "Settings"
        case .listView:
            "List"
        case .quizView:
            "Quiz"
        case .elementDetailView:
            "Element Detail"
        }
    }

    var symbol: String {
        switch self {
        case .welcome:
            "figure.wave"
        case .tableView:
            "atom"
        case .settingsView:
            "gearshape"
        case .listView:
            "list.bullet"
        case .quizView:
            "questionmark.circle"
        case .elementDetailView:
            "info.circle"
        }
    }

    var description: String {
        switch self {
        case .welcome:
            "Detailed interactive periodic table in your pocket."
        case .tableView:
            "Use the table view to move around the periodic table and click on an element to view its details.\nThe slider at the top allows you to zoom between set levels to navigate faster."
        case .listView:
            "Use the list view to quickly browse or search all elements filtered by element category, phase, group period, or block. You can also sort elements."
        case .settingsView:
            "Choose what properties to show in the detail view or come back to this intro in settings..."
        case .quizView:
            "Generate a quiz at your own level using Apple Intelligence, and then have it marked."
        case .elementDetailView:
            "Click on an element to see information about it, read its summary at the bottom, or copy its name."
        }
    }

    var imageName: String {
        switch self {
        case .welcome:
            "icon-light"
        case .tableView:
            "tableView"
        case .listView:
            "listView"
        case .settingsView:
            "settingsView"
        case .quizView:
            "quizView"
        case .elementDetailView:
            "elementDetailView"
        }
    }

    static let first: Self = .welcome
}

struct IntroPageView: View {
    @Environment(\.colorScheme) var colorScheme
    let page: OnboardingPage
    let onContinue: (() -> Void)?

    var displayImage: String {
        if page == .welcome {
            return colorScheme == .dark ? "icon-dark" : "icon-light"
        }
        return page.imageName
    }

    var isFirstOrLast: Bool {
        page == .welcome || page == OnboardingPage.allCases.last
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if page == .welcome {
                    Image(displayImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 40)

                    Text("Elements")
                        .font(.system(size: 50))
                        .monospaced()
                        .fontWeight(.black)
                        .padding(.bottom, 7)
                        .foregroundStyle(.tint)
                } else {
                    Image(displayImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .clipShape(RoundedRectangle(cornerRadius: 27))
                }

                Text(page.description)
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding()
                    .fontDesign(.monospaced)
                    .font(page == .welcome ? .title3 : .body)
                    .ignoresSafeArea()

                Spacer()

                if isFirstOrLast, let onContinue {
                    Button {
                        onContinue()
                    } label: {
                        Label(
                            page == .welcome ? "Go" : "Done",
                            systemImage: page == .welcome ? "arrow.right" : "checkmark"
                        )
                    }
                    .font(.title)
                    .padding(.vertical)
                    .padding(.horizontal, 20)
                    .labelStyle(.titleAndIcon)
                    .glassEffect(.clear.tint(.accentColor).interactive())
                    .foregroundStyle(.white)
                }
            }
            .padding(.horizontal)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Label(page.name, systemImage: page.symbol)
                        .monospaced()
                        .labelStyle(.titleAndIcon)
                        .font(.title)
                }
            }
        }
    }
}

struct IntroView: View {
    private let pages = OnboardingPage.allCases
    @Binding var appHasOpenedBefore: Bool
    @State private var scrollPosition: OnboardingPage.ID?

    var body: some View {
        ScrollView(.horizontal) {
            LazyHStack(spacing: 0) {
                ForEach(pages) { page in
                    IntroPageView(
                        page: page,
                        onContinue: page == .welcome ? { scrollToNext() } : (page == pages.last ? { dismiss() } : nil)
                    )
                    .containerRelativeFrame(.horizontal)
                    .visualEffect { content, proxy in
                        let minX = proxy.frame(in: .scrollView).minX
                        let containerWidth = proxy.size.width
                        let distance = abs(minX) / containerWidth
                        let blur = min(distance * 5, 5)
                        let scale = 1 - min(distance * 0.1, 0.1)

                        return content
                            .blur(radius: blur)
                            .scaleEffect(scale)
                    }
                    .id(page.id)
                }
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.paging)
        .ignoresSafeArea()
        .scrollIndicators(.visible)
        .scrollPosition(id: $scrollPosition)
        .background {
            ColorfulView(color: .lavandula)
                .saturation(2.5)
                .opacity(0.2)
                .ignoresSafeArea()
        }
    }

    private func scrollToNext() {
        guard let current = scrollPosition,
              let currentPage = pages.first(where: { $0.id == current }),
              let index = pages.firstIndex(of: currentPage),
              index < pages.count - 1 else { return }

        withAnimation {
            scrollPosition = pages[index + 1].id
        }
    }

    private func dismiss() {
        appHasOpenedBefore = true
    }
}
