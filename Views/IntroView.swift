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

	static let first: Self = .welcome
}

struct IntroWelcomeView: View {
	var onContinue: () -> Void

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
		VStack(spacing: 15) {
			Image(appIcon)
				.resizable()
				.frame(width: 200, height: 200)
			Text("Elements")
				.font(.largeTitle.bold().monospaced())
				.padding(.bottom, 7)
				.foregroundStyle(.tint)
			Text("Detailed interactive periodic table in your pocket.")
			Spacer()

			Button {
				onContinue()
			} label: {
				Label("Go", systemImage: "arrow.right")
			}
			.font(.title)
			.padding()
			.labelStyle(.titleAndIcon)
			.glassEffect(.clear.tint(.accentColor).interactive())
			.foregroundStyle(.white)
		}
	}
}

struct IntroTableView: View {
	var onContinue: () -> Void

	var body: some View {
		VStack {
			Text("view of table")
			Spacer()
			Button {
				onContinue()
			} label: {
				Label("Continue", systemImage: "arrow.right")
			}
			.font(.title)
			.padding()
			.labelStyle(.titleAndIcon)
			.glassEffect(.clear.tint(.accentColor).interactive())
			.foregroundStyle(.white)
		}
	}
}

struct IntroListView: View {
	var onContinue: () -> Void

	var body: some View {
		VStack {
			Text("list view here")

			Spacer()
			Button {
				onContinue()
			} label: {
				Label("Continue", systemImage: "arrow.right")
			}
			.font(.title)
			.padding()
			.labelStyle(.titleAndIcon)
			.glassEffect(.clear.tint(.accentColor).interactive())
			.foregroundStyle(.white)
		}
	}
}

struct IntroSettingsView: View {
	var onContinue: () -> Void

	var body: some View {
		VStack {
			Text("settings view here")
			Spacer()
			Button {
				onContinue()
			} label: {
				Label("Done", systemImage: "checkmark")
			}
			.font(.title)
			.padding()
			.labelStyle(.titleAndIcon)
			.glassEffect(.clear.tint(.accentColor).interactive())
			.foregroundStyle(.white)
		}
	}
}

struct IntroView: View {
	private let pages = OnboardingPage.allCases
	@State private var currentPage: OnboardingPage = .welcome

	private func scrollToPage(_ page: OnboardingPage, proxy: ScrollViewProxy?) {
		withAnimation {
			proxy?.scrollTo(page.id, anchor: .center)
			currentPage = page
		}
	}

	@Binding var appHasOpenedBefore: Bool

	var body: some View {
		GeometryReader { geometry in
			ScrollView(.horizontal) {
				ScrollViewReader { proxy in
					HStack(spacing: 0) {
						ForEach(pages) { page in
							VStack {
								switch page {
								case .welcome:
									NavigationStack {
										IntroWelcomeView {
											withAnimation { proxy.scrollTo(OnboardingPage.tableView.id, anchor: .center) }
										}
										.toolbar {
											ToolbarItem(placement: .title) {
												Label(
													page.name,
													systemImage: page.symbol
												)
												.monospaced()
												.labelStyle(.titleAndIcon)
												.font(.title)
											}
										}
									}

								case .tableView:
									NavigationStack {
										IntroTableView {
											withAnimation { proxy.scrollTo(OnboardingPage.listView.id, anchor: .center) }
										}
										.toolbar {
											ToolbarItem(placement: .title) {
												Label(
													page.name,
													systemImage: page.symbol
												)
												.monospaced()
												.labelStyle(.titleAndIcon)
												.font(.title)
											}
										}
									}

								case .listView:
									NavigationStack {
										IntroListView {
											withAnimation { proxy.scrollTo(OnboardingPage.settingsView.id, anchor: .center) }
										}
										.toolbar {
											ToolbarItem(placement: .title) {
												Label(
													page.name,
													systemImage: page.symbol
												)
												.monospaced()
												.labelStyle(.titleAndIcon)
												.font(.title)
											}
										}
									}

								case .settingsView:
									NavigationStack {
										IntroSettingsView {
											appHasOpenedBefore = true
										}
										.toolbar {
											ToolbarItem(placement: .title) {
												Label(
													page.name,
													systemImage: page.symbol
												)
												.monospaced()
												.labelStyle(.titleAndIcon)
												.font(.title)
											}
										}
									}
								}
							}
							.frame(width: geometry.size.width)
						}
					}
					.scrollTargetLayout()
				}
			}
			.scrollTargetBehavior(.viewAligned)
			.scrollIndicators(.hidden)
			.scrollDisabled(true)
			.onAppear {
				scrollToPage(.welcome, proxy: nil)
			}
		}
	}
}
