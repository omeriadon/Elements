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
	case settingsView
	case listView

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
			""
		case .tableView:
			"atom"
		case .settingsView:
			"gearshape"
		case .listView:
			"list.bullet"
		}
	}

	static let first: Self = .welcome
}

struct IntroWelcomeView: View {
	@Environment(\.colorScheme) var colorScheme

	var appIcon: String {
		switch colorScheme {
		case .dark:
			"icon-dark"
		default:
			"icon-light"
		}
	}

	var body: some View {
		Image(appIcon)
			.resizable()
			.frame(width: 200, height: 200)
	}
}

struct IntroTableView: View {
	var body: some View {
		Image("icon")
			.resizable()
			.frame(width: 200, height: 200)
	}
}

struct IntroSettingsView: View {
	var body: some View {
		Image("icon")
			.resizable()
			.frame(width: 200, height: 200)
	}
}

struct IntroListView: View {
	var body: some View {
		Image("icon")
			.resizable()
			.frame(width: 200, height: 200)
	}
}

struct IntroView: View {
	private let pages = OnboardingPage.allCases
	@State private var currentPage: OnboardingPage = .welcome

	@State private var position: ScrollPosition = .init(idType: OnboardingPage.ID.self)

	@State private var showButton = false

	private func scrollToPage(_ page: OnboardingPage, proxy: ScrollViewProxy?) {
		withAnimation {
			proxy?.scrollTo(page.id, anchor: .center)
			currentPage = page
			showButton = false
			DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
				withAnimation { showButton = true }
			}
		}
	}

	var body: some View {
		NavigationStack {
			ScrollView([.horizontal]) {
				ScrollViewReader { proxy in
					ForEach(pages) { page in
						GeometryReader { geometry in
							Group {
								switch page {
								case .welcome:
									IntroWelcomeView()

								case .tableView:
									IntroTableView()

								case .settingsView:
									IntroSettingsView()

								case .listView:
									IntroListView()
								}
							}
							.id(page.id)
							.frame(width: geometry.size.width)
						}
						.toolbar {
							ToolbarItem(placement: .title) {
								Label(page.name, systemImage: page.symbol)
									.monospaced()
									.labelStyle(.titleAndIcon)
							}

							ToolbarItem(placement: .topBarTrailing) {
								Group {
									if showButton {
										switch currentPage {
										case .welcome:
											Button { scrollToPage(.tableView, proxy: proxy) } label: {
												Image(systemName: "arrow.right")
											}

										case .tableView:
											Button { scrollToPage(.listView, proxy: proxy) } label: {
												Image(systemName: "arrow.right")
											}

										case .listView:
											Button { scrollToPage(.settingsView, proxy: proxy) } label: {
												Image(systemName: "arrow.right")
											}

										case .settingsView:
											Button { scrollToPage(.welcome, proxy: proxy) } label: {
												Image(systemName: "arrow.right")
											}
										}
									}
								}
								.foregroundStyle(.primary)
							}
						}
					}
					.containerRelativeFrame([.horizontal])
					.scrollTargetLayout()
				}
			}
			.scrollPosition($position)
			.scrollTargetBehavior(.viewAligned)
			.scrollIndicators(.hidden)
			.scrollDisabled(true)
			.onAppear {
				scrollToPage(.welcome, proxy: nil)
			}
		}
	}
}
