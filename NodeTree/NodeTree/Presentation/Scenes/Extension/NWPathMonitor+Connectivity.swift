//
//  NWPathMonitor+Connectivity.swift
//  NodeTree
//
//  Created by Alaa Eid on 02/01/2024.
//


import Network
import Combine
import UIKit



enum Connection {
    case cellular, loopback, wifi, wiredEthernet, other
}

class NetworkReachability {
    static let shared = NetworkReachability()
    private let networkNavProtocol: NetworkViewNavigationProtocol
    private let monitor: NWPathMonitor =  NWPathMonitor()
    public let isConnected = CurrentValueSubject<Bool, Never>(true)
    let queue = DispatchQueue.global(qos: .background)

    private init() {
        self.networkNavProtocol = NetworkViewNavigation()
       
        monitor.start(queue: queue)
    }
}

extension NetworkReachability {
    func startMonitoring() {
        monitor
            .pathUpdateHandler = { [weak self] path in


            switch  path.status {
                
            case .satisfied:
                DispatchQueue.main.async {
                    self?.isConnected.send(true)
                    self?.networkNavProtocol.hideOfflineView()
                }
               
            case .unsatisfied:
                DispatchQueue.main.async {
                    self?.isConnected.send(false)
                    self?.networkNavProtocol.showOfflineView(state: "\(path.status)")
                }
            case .requiresConnection:
                DispatchQueue.main.async {
                    self?.isConnected.send(false)
                    self?.networkNavProtocol.showOfflineView(state: "\(path.status)")
                }
            @unknown default:
                DispatchQueue.main.async {
                    self?.isConnected.send(false)
                    self?.networkNavProtocol.showOfflineView(state: "Something Goes Wrong")
                }
            }
//            if path.availableInterfaces.count == 0 {
//                return callBack(.other, .no)
//            } else if path.usesInterfaceType(.wifi) {
//                return callBack(.wifi, reachable)
//            } else if path.usesInterfaceType(.cellular) {
//                return callBack(.cellular, reachable)
//            } else if path.usesInterfaceType(.loopback) {
//                return callBack(.loopback, reachable)
//            } else if path.usesInterfaceType(.wiredEthernet) {
//                return callBack(.wiredEthernet, reachable)
//            } else if path.usesInterfaceType(.other) {
//                return callBack(.other, reachable)
//            }
        }
    }
}

extension NetworkReachability {
    func cancel() {
        monitor.cancel()
    }
}


protocol NetworkViewNavigationProtocol {
    func showOfflineView(state: String)
    func hideOfflineView()
}

class NetworkViewNavigation: NetworkViewNavigationProtocol {
    
    func showOfflineView(state: String) {
        if UIApplication.shared.topViewController() as? NetworkDisconnectedVC == nil {
            let view = NetworkDisconnectedVC(state: state)
            
            UIApplication.shared.topViewController()?.navigationController?.pushViewController(view, animated: false)
        }
    }

    func hideOfflineView() {
        if UIApplication.shared.topViewController() is NetworkDisconnectedVC {
            UIApplication.shared.topViewController()?.navigationController?.popViewController(animated: false)
        }
    }

}

extension UIApplication {
    func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
       if let navigationController = controller as? UINavigationController {
           return topViewController(controller: navigationController.visibleViewController)
       }
       if let tabController = controller as? UITabBarController {
           if let selected = tabController.selectedViewController {
               return topViewController(controller: selected)
           }
       }
       if let presented = controller?.presentedViewController {
           return topViewController(controller: presented)
       }
       return controller
   }
    
    var topNav:UINavigationController?{
        return self.topViewController()?.parent?.navigationController ?? self.lastNav
    }
    var lastNav:UINavigationController?{
        return self.topViewController()?.navigationController
    }
}

