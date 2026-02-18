//
//  IntroView.swift
//  Elements
//
//  Created by Adon Omeri on 12/11/2025.
//

import SwiftUI

enum OnboardingPage: String, Identifiable, CaseIterable {
	case welcome
	case tableView
	case listView
	case quizView
	case settingsView
	case elementDetailView

	var id: String {
		rawValue
	}

	var name: String {
		switch self {
			case .welcome:
				""
			case .tableView:
				"Table"
			case .settingsView:
				"Settings"
			case .listView:
				"List"
			case .quizView:
				"Quiz"
			case .elementDetailView:
				"Element Details"
		}
	}

	var symbol: String {
		switch self {
			case .welcome:
				""
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
				"- Use the table view to move around the periodic table, and click on an element to view its details.\n- The bookmark toggle allows you to highlight bookmarked elements to get to them faster."
			case .listView:
				"- Use the list view to quickly browse or search all elements.\n- If you narrow down your search to one item it automatically opens for you.\n- You can sort using the menu in the top right and filter using the pickers in the bottom right."
			case .settingsView:
				"Choose what properties to show in the detail view, come back to this intro, and toggle haptics."
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
		VStack(spacing: 20) {
			Label(page.name, systemImage: page.symbol)
				.monospaced()
				.labelStyle(.titleAndIcon)
				.font(.title)
				.padding(.top, 20)

			if page == .welcome {
				Image(displayImage)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.padding(.horizontal, 40)
					.padding(.bottom)

				Text("Elements")
					.font(.system(size: 50))
					.monospaced()
					.fontWeight(.black)
					.padding(.bottom, 7)
					.foregroundStyle(.tint)
					.saturation(1.5)
			} else {
				Image(displayImage)
					.resizable()
					.aspectRatio(contentMode: .fit)
					.clipShape(RoundedRectangle(cornerRadius: 27))
			}

			Text(page.description)
				.multilineTextAlignment(page == .welcome ? .center : .leading)
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
						page == .welcome ? "Swipe to continue" : "Done",
						systemImage: page == .welcome ? "arrow.right" : "checkmark"
					)
				}
				.font(.title)
				.padding(.vertical)
				.padding(.horizontal, 20)
				.labelStyle(.titleAndIcon)
				.buttonStyle(.plain)
				.glassEffect(.clear.tint(.accentColor).interactive())
				.foregroundStyle(.white)
			}
		}
		.padding(.horizontal)
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
						let scale = 1 - min(distance * 0.2, 0.2)

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
		.scrollIndicators(.visible)
		.scrollPosition(id: $scrollPosition)
		.onAppear {
			scrollPosition = OnboardingPage.first.id
		}
		.background {
			ColorfulView(color: .lavandula)
				.saturation(2)
				.opacity(0.5)
				.ignoresSafeArea()
		}
		.dynamicTypeSize(...DynamicTypeSize.accessibility1)
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
