
import Foundation

protocol ContainerProtocol {
    typealias ObjectID = String
    
    func register<Component>(type: Component.Type, component: Any)
    func register<Component>(type: Component.Type, component: Any, objectId: ObjectID)
    func resolve<Component>(type: Component.Type) -> Component?
    func resolve<Component>(type: Component.Type, objectId: ObjectID) -> Component?
}

public final class Container: ContainerProtocol {
    static let shared = Container()
    private let defaultConcrete: ObjectID = UUID().uuidString
    
    private typealias TypeId = String
    private typealias ConcreteDictionary = [ObjectID: Any]
    private typealias TypeDictionary = [TypeId: Any]
    private var typeDict: TypeDictionary = [:]
    
    func register<Component>(type: Component.Type, component: Any) {
        let concreteDict: ConcreteDictionary = [defaultConcrete:component]
        typeDict["\(type)"] = concreteDict
    }
    
    func register<Component>(type: Component.Type, component: Any, objectId: ObjectID) {
        let concreteDict: ConcreteDictionary = [objectId:component]
        typeDict["\(type)"] = concreteDict
    }
    
    func resolve<Component>(type: Component.Type) -> Component? {
        let castedTypeDict = typeDict["\(type)"] as? TypeDictionary
        let castedConcrete = castedTypeDict?[defaultConcrete] as? Component
        return castedConcrete
    }
    
    func resolve<Component>(type: Component.Type, objectId: ObjectID) -> Component? {
        let castedTypeDict = typeDict["\(type)"] as? TypeDictionary
        let castedConcrete = castedTypeDict?[objectId] as? Component
        return castedConcrete
    }
}

