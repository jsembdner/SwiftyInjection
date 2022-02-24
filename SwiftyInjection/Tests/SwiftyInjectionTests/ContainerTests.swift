import XCTest
@testable import SwiftyInjection

class ContainerTests: XCTestCase {
    
    var container: Container?
    let testString = "TestMe"

    override func setUpWithError() throws {
        container = Container()
    }

    override func tearDownWithError() throws {
    }

    func test_register_then_resolve() throws {
        container!.register(type: String.self, component: testString)
        let resolvedComponent: String? = container!.resolve(type: String.self)
        XCTAssertNotNil(resolvedComponent)
        XCTAssertTrue(testString == resolvedComponent)
    }
    
    func test_no_register_then_resolve() throws {
        let resolvedComponent: String? = container!.resolve(type: String.self)
        XCTAssertNil(resolvedComponent)
    }
    
    func test_register_with_objectID_then_resolve_with_default() throws {
        container!.register(type: String.self, component: testString, objectId: "1")
        let resolvedComponent: String? = container!.resolve(type: String.self)
        XCTAssertNil(resolvedComponent)
    }
    
    func test_register_with_objectID_then_resolve_with_objectID() throws {
        container!.register(type: String.self, component: testString, objectId: "1")
        let resolvedComponent: String? = container!.resolve(type: String.self, objectId: "1")
        XCTAssertNotNil(resolvedComponent)
        XCTAssertTrue(testString == resolvedComponent)
    }
    
    func test_register_with_objectID_then_resolve_with_wrong_objectID() throws {
        container!.register(type: String.self, component: testString, objectId: "1")
        let resolvedComponent: String? = container!.resolve(type: String.self, objectId: "2")
        XCTAssertNil(resolvedComponent)
    }
    
}
