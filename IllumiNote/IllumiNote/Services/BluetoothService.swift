//
//  BluetoothService.swift
//  IllumiNote2
//
//  Created by Iva Chho on 7/12/24.
//
import Foundation
import CoreBluetooth

class BluetoothService: NSObject, ObservableObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var centralManager: CBCentralManager!
    var raspberryPiPeripheral: CBPeripheral?
    var writeCharacteristic: CBCharacteristic?

    override init() {
        super.init()
        centralManager = CBCentralManager(delegate: self, queue: nil)
    }

    
    /// Called whenever the Bluetooth state changes
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        if central.state == .poweredOn {
            // scan for peripherals with any service UUIDs
            centralManager.scanForPeripherals(withServices: nil, options: nil)
        }
    }

    /// Called when a peripheral is discovered
    /// if peripheral is the raspberry pi, it attempts to connect
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        if peripheral.name == "raspberrypiName" {
            raspberryPiPeripheral = peripheral
            raspberryPiPeripheral?.delegate = self
            centralManager.stopScan()
            centralManager.connect(peripheral, options: nil)
        }
    }

    /// Called when the peripheral is successfully connected
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        peripheral.discoverServices(nil)
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        for service in services {
            peripheral.discoverCharacteristics(nil, for: service)
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        for characteristic in characteristics {
            if characteristic.properties.contains(.write) {
                writeCharacteristic = characteristic
                // Write data here or store the characteristic for later use
                // You can send the JSON data after finding the characteristic
                sendJSONData(to: peripheral)
            }
        }
    }

    func sendJSONData(to peripheral: CBPeripheral) {
        guard let writeCharacteristic = writeCharacteristic else { return }
        let json: [String: Any] = ["key": "value"] // Your JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            peripheral.writeValue(jsonData, for: writeCharacteristic, type: .withResponse)
        } catch {
            print("Failed to serialize JSON: \(error)")
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        if let error = error {
            print("Error writing value: \(error.localizedDescription)")
        } else {
            print("Successfully wrote value for characteristic \(characteristic.uuid)")
        }
    }
}
