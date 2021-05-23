//
//  Plugin.swift
//  A plug-in for Stream Deck
//
//  Created by Jarno Le Conté on 19/10/2019.
//  Copyright © 2019 Jarno Le Conté. All rights reserved.
//

import Foundation

public class Plugin: NSObject, ESDEventsProtocol {
    var connectionManager: ESDConnectionManager?;
    var knownContexts: [Any] = [];
    
    public func setConnectionManager(_ connectionManager: ESDConnectionManager) {
        self.connectionManager = connectionManager;
    }
    
    public func keyDown(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        
        // Provided for demonstration only
        let data = [ "command": "updateSampleParam", "message" : "keyDown" ]
        connectionManager?.send(toPropertyInspector: data, forContext: context)
    }
    
    public func keyUp(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        
        // Provided for demonstration only
        let data = [ "command": "updateSampleParam", "message" : "keyUp" ]
        connectionManager?.send(toPropertyInspector: data, forContext: context)
    }
    
    public func willAppear(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Add the context to the list of known contexts
        knownContexts.append(context)
    }
    
    public func willDisappear(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Remove the context from the list of known contexts
        knownContexts.removeAll { isEqualContext($0, context) }
    }
    
    public func propertyInspectorDidAppear(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Add the context to the list of known contexts
        knownContexts.append(context);
        
        // Provided for demonstration only
        connectionManager?.setTitle("Appear", withContext: context, withTarget: ESDSDKTarget.HardwareAndSoftware.rawValue)
    }

    public func propertyInspectorDidDisappear(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Add the context to the list of known contexts
        knownContexts.append(context);
        
        // Provided for demonstration only
        connectionManager?.setTitle("Disappear", withContext: context, withTarget: ESDSDKTarget.HardwareAndSoftware.rawValue)
    }

    public func sendToPlugin(forAction action: String, withContext context: Any, withPayload payload: [AnyHashable : Any], forDevice deviceID: String) {
        // Nothing to do
        
        // Provided for demonstration only
        // We have received a command "clear-sample-param" from PI, and now we send a command "clearSampleParam" back to it
        let command = payload["command"] as? String;
        if (command == "clear-sample-param") {
            let data = [ "command": "clearSampleParam" ]
            connectionManager?.send(toPropertyInspector: data, forContext: context)
        }
    }

    public func deviceDidConnect(_ deviceID: String, withDeviceInfo deviceInfo: [AnyHashable : Any]) {
        // Nothing to do
    }
    
    public func deviceDidDisconnect(_ deviceID: String) {
        // Nothing to do
    }
    
    public func applicationDidLaunch(_ applicationInfo: [AnyHashable : Any]) {
        // Nothing to do
    }
    
    public func applicationDidTerminate(_ applicationInfo: [AnyHashable : Any]) {
        // Nothing to do
    }
}

