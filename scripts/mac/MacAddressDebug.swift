#!/usr/bin/env swift

import Foundation
import IOKit
import IOKit.network

func debugGetMacAddress() -> Data? {
    print("Creating IOServiceMatching for IOEthernetInterface")
    guard let filter = IOServiceMatching("IOEthernetInterface") as? NSMutableDictionary else {
        print("❌ Failed to create IOServiceMatching dictionary")
        return nil
    }
    
    // Commented out the primary interface filter to catch all interfaces
    // filter["IOPropertyMatch"] = ["IOPrimaryInterface": true] as CFDictionary
    
    var iterator: io_iterator_t = 0
    let result = IOServiceGetMatchingServices(kIOMasterPortDefault, filter, &iterator)
    if result != KERN_SUCCESS {
        print("❌ IOServiceGetMatchingServices failed: \(result)")
        return nil
    }
    defer { IOObjectRelease(iterator) }
    
    var ethService = IOIteratorNext(iterator)
    if ethService == 0 {
        print("❌ No Ethernet interfaces found")
        return nil
    }
    
    while ethService != 0 {
        print("Found IOEthernetInterface: \(ethService)")
        
        // Try to get "IOPrimaryInterface" property to identify primary interface
        if let primary = IORegistryEntryCreateCFProperty(ethService, "IOPrimaryInterface" as CFString, kCFAllocatorDefault, 0)?.takeUnretainedValue() {
            print("IOPrimaryInterface property: \(primary)")
        } else {
            print("No IOPrimaryInterface property on this interface")
        }
        
        // Get parent service (Ethernet controller)
        var parentService: io_registry_entry_t = 0
        let parentResult = IORegistryEntryGetParentEntry(ethService, kIOServicePlane, &parentService)
        if parentResult != KERN_SUCCESS {
            print("❌ Failed to get parent entry: \(parentResult)")
            IOObjectRelease(ethService)
            return nil
        }
        
        print("Parent service: \(parentService)")
        
        // Try to read the MAC address data from parent service
        if let macData = getData(parentService, "IOMACAddress") {
            print("✅ MAC Address found: \(macData as NSData)")
            IOObjectRelease(parentService)
            IOObjectRelease(ethService)
            return macData
        } else {
            print("No MAC address on parent service")
        }
        
        IOObjectRelease(parentService)
        IOObjectRelease(ethService)
        
        ethService = IOIteratorNext(iterator)
    }
    
    print("❌ No MAC address found on any Ethernet interfaces")
    return nil
}

// Dummy placeholder for your getData function, replace with your actual implementation:
func getData(_ service: io_registry_entry_t, _ key: String) -> Data? {
    if let cfData = IORegistryEntryCreateCFProperty(service, key as CFString, kCFAllocatorDefault, 0)?.takeUnretainedValue() as? Data {
        return cfData
    }
    return nil
}

// Run the function and print the MAC address as hex string
if let macData = debugGetMacAddress() {
    let macAddress = macData.map { String(format:"%02x", $0) }.joined(separator: ":")
    print("Final MAC Address: \(macAddress)")
} else {
    print("Failed to get MAC Address")
}
