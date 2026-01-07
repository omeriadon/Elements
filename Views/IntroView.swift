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
	case settingsView

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
		}
	}

	var description: String {
		switch self {
			case .welcome:
				"Detailed interactive periodic table in your pocket."
			case .tableView:
				"Use the table view to move around the periodic table and click on an element to view its details. The slider at the top allows you to zoom between set levels to navigate faster."
			case .listView:
				"Use the list view to quickly browse all elements filtered by element category, phase, group period, or block and sorted alphabetically or by atomic number."
			case .settingsView:
				"Choose what to show in teh detail view or come back to this intro in settings.."
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
		}
	}

	static let first: Self = .welcome
}

struct IntroPageView: View {
	@Environment(\.colorScheme) var colorScheme
	let page: OnboardingPage
	let onContinue: () -> Void

	var buttonText: String {
		page == OnboardingPage.allCases.last ? "Done" : (page == .welcome ? "Go" : "Continue")
	}

	var buttonIcon: String {
		page == OnboardingPage.allCases.last ? "checkmark" : "arrow.right"
	}

	var displayImage: String {
		if page == .welcome {
			return colorScheme == .dark ? "icon-dark" : "icon-light"
		}
		return page.imageName
	}

	var body: some View {
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
				.multilineTextAlignment(.center)
				.fixedSize(horizontal: false, vertical: true)
				.padding(.horizontal)

			Spacer()

			Button {
				onContinue()
			} label: {
				Label(buttonText, systemImage: buttonIcon)
			}
			.font(.title)
			.padding()
			.labelStyle(.titleAndIcon)
			.glassEffect(.clear.tint(.accentColor).interactive())
			.foregroundStyle(.white)
		}
		.padding()
		.toolbar {
			ToolbarItem(placement: .title) {
				Label(page.name, systemImage: page.symbol)
					.monospaced()
					.labelStyle(.titleAndIcon)
					.font(.title)
			}
		}
	}
}

struct IntroView: View {
	private let pages = OnboardingPage.allCases
	@State private var currentPage: OnboardingPage = .welcome
	@Binding var appHasOpenedBefore: Bool

	var body: some View {
		GeometryReader { geometry in
			ScrollView(.horizontal) {
				ScrollViewReader { proxy in
					HStack(spacing: 0) {
						ForEach(pages) { page in
							NavigationStack {
								IntroPageView(page: page) {
									handleNavigation(from: page, proxy: proxy)
								}
							}
							.frame(width: geometry.size.width)
							.id(page.id)
						}
					}
					.scrollTargetLayout()
				}
			}
			.scrollTargetBehavior(.viewAligned)
			.scrollIndicators(.hidden)
			.scrollDisabled(true)
		}
		.presentationBackground(.background)
		.background {
			ColorfulView(color: .lavandula)
				.saturation(2.5)
				.opacity(0.2)
				.ignoresSafeArea()
		}
	}

	private func handleNavigation(from page: OnboardingPage, proxy: ScrollViewProxy) {
		if let index = pages.firstIndex(of: page), index < pages.count - 1 {
			let nextPage = pages[index + 1]
			withAnimation {
				proxy.scrollTo(nextPage.id, anchor: .center)
				currentPage = nextPage
			}
		} else {
			appHasOpenedBefore = true
		}
	}
}
