//
//  AnnotationManager.swift
//  JecNavi
//
//  Created by yuki on 2024/06/12.
//

import Foundation
import MapKit


struct LocationDataModel:Identifiable{
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let address: String
    let classes: [String]
    let facilities: [String]
    let images:[String]
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude
        )
    }
    
    init(id: Int,name: String, latitude: Double, longitude: Double,address: String,classes:[String],facilities:[String],images:[String]) {
        self.id = id
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.address = address
        self.classes = classes
        self.facilities = facilities
        self.images = images
    }
}

let AnnotationLocation:[LocationDataModel] = [
 LocationDataModel(
    id: 1,
    name: "本館",
    latitude: 35.6982122,
    longitude: 139.6981188,
    address: "東京都新宿区百人町１丁目２５−４",
    classes: [
          "ＡＩシステム科",
          "情報処理科",
          "高度情報処理科",
          "ネットワークセキュリティ科"
       ],
    facilities: [
       "トイレ",
       "多目的トイレ",
       "AED",
       "学習スペース",
       "自動販売機"
    ],
    images: [
    "1",
    "保健室",
    "キャリアセンター"
]),
    LocationDataModel(
        id: 2,
        name: "2号館",
        latitude: 35.6987895,
        longitude: 139.6978981,
        address: "東京都新宿区百人町１丁目２４-２３",
        classes: [
              "ＡＩシステム科",
              "情報処理科",
              "高度情報処理科",
              "情報システム開発科"
           ],
        facilities: [
            "トイレ",
            "自動販売機"
        ],
        images: [
        "2",
        "2",
        "2"
    ]),
 LocationDataModel(
    id: 3,
    name: "3号館",
    latitude: 35.69849,
    longitude: 139.6983568,
    address: "東京都新宿区百人町１丁目２５−１８",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "喫煙スペース",
        "自動販売機"
    ],
    images: [
        "3",
        "3",
        "3"
]),
 LocationDataModel(
    id: 4,
    name: "4号館",
    latitude: 35.6987494,
    longitude: 139.6981523,
    address: "東京都新宿区百人町１丁目２５−４",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "多目的トイレ",
    ],
    images: [
    "4",
    "4",
    "4"
]),
 LocationDataModel(
    id: 5,
    name: "5号館",
    latitude: 35.6989197,
    longitude: 139.6974195,
    address: "東京都新宿区百人町１丁目２３−２７",
    classes: [
          "コンピュータグラフィックス科",
          "コンピュータグラフィックス研究科",
          "ＣＧ映像制作科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "自動販売機"
    ],
    images: [
    "5",
    "VFXラボ",
    "5"
]),
 LocationDataModel(
    id: 6,
    name: "6号館",
    latitude: 35.698216,
    longitude: 139.6978981,
    address: "東京都新宿区百人町１丁目２４−１",
    classes: [
          "モバイルアプリケーション開発科",
          "ゲーム企画科",
          "ゲーム制作科",
          "アニメーション科",
          "アニメーション研究科",
          "グラフィックデザイン科",
          "コンピュータグラフィックス科",
          "コンピュータグラフィックス研究科",
          "電子応用工学科",
          "Ｗｅｂデザイン科",
       ],
    facilities: [
        "トイレ",
        "多目的トイレ",
        "自動販売機"
    ],
    images: [
    "6",
    "6",
    "6"
]),
 LocationDataModel(
    id: 7,
    name: "7号館",
    latitude: 35.6988785,
    longitude: 139.6967994,
    address: "東京都新宿区北新宿１丁目４−２",
    classes: [
          "グラフィックデザイン科",
       ],
    facilities: [
        "トイレ",
        "多目的トイレ",
        "AED",
        "学習スペース",
        "喫煙スペース",
        "自動販売機"
    ],
    images: [
    "7",
    "モーションキャプチャールーム",
    "デジタルぺンタブレットワークステーション"
]),
 LocationDataModel(
    id: 8,
    name: "8号館",
    latitude: 35.6974275,
    longitude: 139.6978981,
    address: "東京都新宿区西新宿７丁目６−３",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "多目的トイレ",
        "AED",
        "自動販売機"
    ],
    images: [
    "8",
    "8",
    "8"
]),
 LocationDataModel(
    id: 9,
    name: "9号館",
    latitude: 35.6991182,
    longitude: 139.6979579,
    address: "東京都新宿区百人町１丁目２４−２０",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "AED",
        "喫煙スペース",
        "自動販売機"
    ],
    images: [
    "9",
    "9",
    "9"
]),
 LocationDataModel(
    id: 10,
    name: "10号館",
    latitude: 35.6993073,
    longitude: 139.697938,
    address: "東京都新宿区百人町１丁目２４−１８",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "喫煙スペース",
        "自動販売機"
    ],
    images: [
    "10",
    "10",
    "10"
]),
 LocationDataModel(
    id: 11,
    name: "11号館",
    latitude: 35.7006372,
    longitude: 139.697975,
    address: "東京都新宿区百人町１丁目１７",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "多目的トイレ",
        "AED",
        "喫煙スペース",
        "自動販売機"
    ],
    images: [
    "11",
    "11",
    "11"
]),
 LocationDataModel(
    id: 12,
    name: "12号館",
    latitude: 35.6953027,
    longitude: 139.6989646,
    address: "東京都新宿区西新宿７丁目２−１３",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "多目的トイレ",
        "AED",
        "喫煙スペース",
        "自動販売機"
    ],
    images: [
    "12",
    "12",
    "12"
]),
 LocationDataModel(
    id: 13,
    name: "13号館",
    latitude: 35.6999969,
    longitude: 139.6981496,
    address: "東京都新宿区百人町１丁目１６",
    classes: [
          "モバイルアプリケーション開発",
          "ゲーム企画科",
          "ゲーム研究科",
          "コンピューターグラフィックス科"
       ],
    facilities: [
        "トイレ",
        "自動販売機"
    ],
    images: [
    "13",
    "13",
    "13"
])
]

