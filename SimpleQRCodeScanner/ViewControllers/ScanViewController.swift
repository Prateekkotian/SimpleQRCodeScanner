//
//  ScanViewController.swift
//  SimpleQRCodeScanner
//
//  Created by Prateek kumar on 10/31/17.
//  Copyright © 2017 Prateek kumar. All rights reserved.
//

import UIKit
import AVFoundation

class ScanViewController: UIViewController {
    @IBOutlet weak var outputLabel: UILabel!
    
    var session:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeView: UIView?

    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice = AVCaptureDevice.default(for: .video)
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session = AVCaptureSession()
            session?.addInput(input)
            let captureMetadataOutput = AVCaptureMetadataOutput()
            session?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: session!)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            session?.startRunning()
            
            qrCodeView = UIView()
            if let qrCodeFrameView = qrCodeView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
        } catch {
            print(error)
            return
        }
    }
}

extension ScanViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.isEmpty {
            qrCodeView?.frame = CGRect.zero
            outputLabel.textColor = UIColor.red
            outputLabel.text = "No QR code is detected"
            view.bringSubview(toFront: outputLabel)
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == .qr {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                outputLabel.textColor = UIColor.green
                outputLabel.text = metadataObj.stringValue
                view.bringSubview(toFront: outputLabel)
            }
        }
    }
}
