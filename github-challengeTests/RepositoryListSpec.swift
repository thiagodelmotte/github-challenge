
import Quick
import Nimble
import Nimble_Snapshots
import UIKit

class RepositoryListSpec: QuickSpec {
    
    override func spec() {
        
        describe("RepositoryListViewController") {
            var sut: RepositoryListViewController!
            
            beforeEach {
                sut = RepositoryListViewController()
                WindowHelper.showInTestWindow(viewController: sut)
            }
            
            context("when screen loads") {
                it("should match snapshot") {
                    expect(sut) == snapshot("RepositoryListViewController")
                }
            }
        }
        
    }
    
}
