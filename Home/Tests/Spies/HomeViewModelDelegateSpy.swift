import CoreBootcamp
@testable import Home

class HomeViewModelDelegateSpy: HomeViewModelDelegateProtocol {
    var currentState: ViewControllerState?

    func homeEvent(state: ViewControllerState) {
        currentState = state
    }
}

