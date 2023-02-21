//
//  CameraViewController.swift
//  VERO-DigitalSolutions-CaseStudy
//
//  Created by Hasan Dag on 21.02.2023.
//

import UIKit
import AVFoundation

protocol CameraHandleDelegate : AnyObject {
    func prepareQRScanningResult(_ text:String)
}

final class CameraViewController : UIViewController {
    
    weak var delegate : CameraHandleDelegate?
    
    let cameraQueue = DispatchQueue.global(qos: .default)
    
    private let photoOutput = AVCapturePhotoOutput()
    var captureSession : AVCaptureSession = {
        let session = AVCaptureSession()
        session.sessionPreset = .photo
        guard let backCamera = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInWideAngleCamera, for: .video, position: .back), let input = try? AVCaptureDeviceInput(device: backCamera) else { return session}
        session.addInput(input)
        return session
    }()
    
    // MARK: UI Elements
    var previewLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer(session: AVCaptureSession())
    
    private lazy var cameraView : UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        return view
    }()
    
    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAVFoundation()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if captureSession.isRunning {
            cameraQueue.async{
                self.captureSession.stopRunning()
            }
        }
    }
    
    private func configureAVFoundation() {
        let metadataOutput = AVCaptureMetadataOutput()
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = metadataOutput.availableMetadataObjectTypes
        }
        
        captureSession.addOutput(photoOutput)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.videoGravity = .resizeAspectFill
        previewLayer.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        self.cameraView.layer.addSublayer(previewLayer)
        cameraQueue.async {
            self.captureSession.startRunning()
        }
        configureUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.clipsToBounds = false
        cameraView.layer.masksToBounds = true
        previewLayer.frame = cameraView.frame
        previewLayer.contentsScale = 1
        previewLayer.contentsCenter = .init(origin: view.center, size: cameraView.frame.size)
    }
    
    private func configureUI(){
        view.backgroundColor = UIColor(named: "bgColor")
        view.addSubview(cameraView)
        
        cameraView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
    }
    
}

extension CameraViewController : AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject, let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            delegate?.prepareQRScanningResult(stringValue)
        }
        
        dismiss(animated: true)
    }
}
