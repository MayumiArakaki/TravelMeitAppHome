@testable import Home

class HomeViewModelDelegateSpy: HomeViewModelDelegateProtocol {
    public var currentState: Int = -1
    func homeEvent(state: Int) {
        currentState = state
    }

}
