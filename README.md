# flutter_barcode_sdk
![pub.dev](https://img.shields.io/pub/v/flutter_barcode_sdk.svg)

A flutter plugin project for [Dynamsoft Barcode Reader SDK](https://www.dynamsoft.com/barcode-reader/overview/).

## What You Should Know
- [![](https://img.shields.io/badge/Download-Offline%20SDK-orange)](https://www.dynamsoft.com/barcode-reader/downloads)
- [![](https://img.shields.io/badge/Get-30--day%20FREE%20Trial%20License-blue)](https://www.dynamsoft.com/customer/license/trialLicense/?product=dbr)

## Configuration

### Android
Change the minimum Android sdk version to 21 (or higher) in your `android/app/build.gradle` file.

```
minSdkVersion 21
```

### Desktop
Install `CMake` and `platform-specific C++ compiler`.

### Web
Include `<script src="https://cdn.jsdelivr.net/npm/dynamsoft-javascript-barcode/dist/dbr.js" data-productKeys="PRODUCT-KEYS"></script>` to `index.html`.

## Try Example

### Mobile(Android)
The example allows users to scan barcodes via the camera video stream in real-time or read barcodes by taking a picture.

```
cd example
flutter run -d <device>
```

Video Scan

![flutter barcode scanner](https://www.dynamsoft.com/codepool/img/2021/flutter-barcode-scanner-camera.gif)

Picture Scan

![flutter barcode reader](https://www.dynamsoft.com/codepool/img/2021/flutter-picture-barcode-scan.jpg)

### Windows & Linux Desktop
Input a valid image path for barcode decoding.

#### Windows

```
cd example
flutter run -d windows
```

![flutter windows barcode reader](https://www.dynamsoft.com/codepool/img/2021/flutter-desktop-barcode-reader.png)

#### Linux 

```
cd example
flutter run -d linux
```

![flutter Linux barcode reader](https://www.dynamsoft.com/codepool/img/2021/flutter-linux-desktop-barcode.png)


### Web Browser

```
cd example
flutter run -d chrome
```

Barcode Reader

![flutter web barcode reader](https://www.dynamsoft.com/codepool/img/2021/flutter-web-barcode-sdk.png)

Barcode Scanner

![flutter web barcode scanner](https://www.dynamsoft.com/codepool/img/2021/flutter-web-barcode-scanner.png)

## Currently Supported Platforms
- **Android**
- **Windows**
- **Linux**
- **Web**

## API Table
| Methods      | Android |    iOS | Windows | Linux | Web|
| ----------- | ----------- | ----------- | ----------- |----------- |----------- |
| `Future<void> setLicense(String license) async`     | :x:       | :x:   | :heavy_check_mark:      | :heavy_check_mark:      | :x:     |
| `Future<List<BarcodeResult>> decodeFile(String filename) async`     | :heavy_check_mark:      | :x:   | :heavy_check_mark:      |:heavy_check_mark:      | :heavy_check_mark:     |
| `Future<List<BarcodeResult>> decodeFileBytes(Uint8List bytes) async`     | :heavy_check_mark:      | :x:   | :heavy_check_mark:      | :heavy_check_mark:      | :x:     |
| `Future<List<BarcodeResult>> decodeImageBuffer(Uint8List bytes, int width, int height, int stride, int format) async`     | :heavy_check_mark:      | :x:   | :heavy_check_mark:      |:heavy_check_mark:      | :x:     |
| `Future<void> decodeVideo(Function callback) async`     | :x:       | :x:   | :x:       | :x:       | :heavy_check_mark:     |


## Supported Barcode Symbologies
- Linear Barcodes (1D)
  - Code 39 (including Code 39 Extended)
  - Code 93
  - Code 128
  - Codabar
  - Interleaved 2 of 5
  - EAN-8
  - EAN-13
  - UPC-A
  - UPC-E
  - Industrial 2 of 5

- 2D Barcodes
  - QR Code (including Micro QR Code and Model 1)
  - Data Matrix
  - PDF417 (including Micro PDF417)
  - Aztec Code
  - MaxiCode (mode 2-5)
  - DotCode

- Patch Code
- GS1 Composite Code
- GS1 DataBar
  - Omnidirectional,
  - Truncated, Stacked, Stacked
  - Omnidirectional, Limited,
  - Expanded, Expanded Stacked

- Postal Codes
  - USPS Intelligent Mail
  - Postnet
  - Planet
  - Australian Post
  - UK Royal Mail


## Usage
- Set a license key:

  ```dart
  _barcodeReader.setLicense('LICENSE-KEY');
  ```

- Read barcodes from an image file:

  ```dart
  List<BarcodeResult> results = await _barcodeReader.decodeFile(image-path);
  ```
- Read barcodes from image file bytes:

  ```dart
  Uint8List bytes = await File(image-path).readAsBytes();
  List<BarcodeResult> results = await _barcodeReader.decodeFileBytes(bytes);
  ```

- Read barcodes from video stream [CameraImage](https://pub.dev/documentation/camera/latest/camera/CameraImage-class.html):

  ```dart
  CameraImage availableImage;
  int format = FlutterBarcodeSdk.IF_UNKNOWN;

  switch (availableImage.format.group) {
    case ImageFormatGroup.yuv420:
      format = FlutterBarcodeSdk.IF_YUV420;
      break;
    case ImageFormatGroup.bgra8888:
      format = FlutterBarcodeSdk.IF_BRGA8888;
      break;
    default:
      format = FlutterBarcodeSdk.IF_UNKNOWN;
  }

  List<BarcodeResult> results = _barcodeReader.decodeImageBuffer(
                availableImage.planes[0].bytes,
                availableImage.width,
                availableImage.height,
                availableImage.planes[0].bytesPerRow,
                format);
  ```

- Read barcodes from web browser video stream:

  ```dart
  _barcodeReader.decodeVideo(
                              (results) => {updateResults(results)});
  ```

## How to Use the License Key

### Mobile
No license required. Instead, you need to get an private organization ID and update the plugin code:

```java
parameters.organizationID = "200001";
```

By default, the public organization ID `200001` authorize developers to use the SDK for 7 days.

### Desktop
Invoke the `setLicense()` method:

```dart
_barcodeReader.setLicense('LICENSE-KEY');
```

### Web
Update the `PRODUCT-KEYS` :

```html
<script src="https://cdn.jsdelivr.net/npm/dynamsoft-javascript-barcode/dist/dbr.js" data-productKeys="PRODUCT-KEYS"></script>
```

## License Agreement
https://www.dynamsoft.com/Products/barcode-reader-license-agreement.aspx

## Contact Us
<support@dynamsoft.com>

## TODO
iOS
