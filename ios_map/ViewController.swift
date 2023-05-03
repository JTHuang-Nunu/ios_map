//
//  ViewController.swift
//  ios_map
//
//  Created by Mac15 on 2023/5/3.
//

import UIKit
import CoreLocation
import MapKit
import SafariServices

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    @objc func buttonPress(_ sender: UIButton) {
        if sender.tag == 100 {
            let url = URL(string:"https://www.ntust.edu.tw")
            let safari = SFSafariViewController(url: url!)
            show(safari, sender: self)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let SLocation = MKPointAnnotation()
        SLocation.coordinate = CLLocationCoordinate2D(latitude: 25.013476, longitude: 121.541772)
        SLocation.title = "NTUST"
        mapView.addAnnotation(SLocation)
        // Do any additional setup after loading the view.
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation{
            return nil
        }
        var annView = mapView.dequeueReusableAnnotationView(withIdentifier: "pin")
        if annView == nil {
            annView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        }
        if(annotation.title! == "NTUST"){
            let annView1 = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "pin")
            let imageView = UIImageView(image: resizeImage(image: UIImage(named: "mark.png")!, width: 64))
            annView1.leftCalloutAccessoryView = imageView
            
            let label = UILabel()
            label.numberOfLines = 2
            label.text = "緯度:\(annotation.coordinate.latitude)\n經度:\(annotation.coordinate.longitude)"
            annView1.detailCalloutAccessoryView = label
            
            let button = UIButton(type: .detailDisclosure)
            button.tag = 100
            button.addTarget(self, action: #selector(buttonPress), for: .touchUpInside)
            
            annView1.rightCalloutAccessoryView = button
            annView1.isEnabled = true
            annView1.canShowCallout = true
            return annView1
        }
        let image = UIImage(named: "mark.png")
        annView?.image = resizeImage(image:image!, width:32)
        annView?.isDraggable = true
        return annView
    }
    
    func resizeImage(image: UIImage, width: CGFloat) ->  UIImage {
        let size = CGSize(width: width, height: image.size.height * width / image.size.width)
        let renderer = UIGraphicsImageRenderer(size: size)
        let newImage = renderer.image{(context) in image.draw(in: renderer.format.bounds)}
        return newImage
    }
    
//    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
//        mapView.removeAnnotation(view.annotation!)
//    }
    

}

