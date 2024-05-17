
import SwiftUI

extension AppRouter {
    
    func settingsScreen() -> SettingsScreen {
        SettingsScreen()
    }
    
    @ViewBuilder
    func start() -> some View {
        if AppArgs.isRunningUnitTests {
            TestsScreen()
        } else {
            let viewModel = MainViewModelFactory.create(appRouter: self)
            MainScreen(viewModel: viewModel)
        }
    }
}
