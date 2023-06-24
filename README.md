# PassEncoder

Apple Wallet (formerly Passbook) pass encoding and signing in Swift.

Works on iOS! (Sign the manifest on a Mac)

## Features

- Modern Swift API
- Allows you to specify custom pass data
- Add other files (images, JSON, etc)
- Manifest generation
- File system managed seamlessly
- Get pass `Data` easily

## Requirements
- iOS 13+
- macOS 10.12+ or Linux (with zlib development package)
- Xcode 9.0+
- Swift 5.2+
- OpenSSL

## Installation

### Swift Package Manager

Add the following line to your dependencies section of `Package.swift`:

    .package(url: "https://github.com/nivbp7/PassEncoder.git", branch: "master")

and add "PassEncoder" to your target's dependencies.

## Usage

    let data = Data(jsonString.utf8) //create a Data object from a JSON string 
    
    // Create our encoder 
    guard let encoder = PassEncoder(passData: data) else {return}
            
    // Add the required icons and logos
    guard let iconPath = Bundle.main.url(forResource: "icon", withExtension: "png"),
        let icon2Path = Bundle.main.url(forResource: "icon2", withExtension: "png"),
        let logoPath = Bundle.main.url(forResource: "logo", withExtension: "png"),
        let logo2Path = Bundle.main.url(forResource: "logo2", withExtension: "png")
    else {return}
        
    encoder.addFile(from: iconPath)
    encoder.addFile(from: icon2Path)
    encoder.addFile(from: logoPath)
    encoder.addFile(from: logo2Path)

    // Create the manifest
    guard let passData = encoder.createManifest() else {return}

    * Sign the manifest file on your Mac * 

    // Add the manifest to the encoder
    encoder.addFileWithoutHash(named: "signature", from: data)
        
    // Your archived .pkpass file as Data
    let signedData = try self.encoder.archivedData()
    
    
> **Heads up!** Operations in this library are all synchronous, so it is advisable to run them on a separate `OperationQueue` so that they do not block your thread.

### Creating and preparing your certificate

You need to repeat this step for each different `passTypeId` you have in your `pass.json`.

1. Go to the [Apple Developer Pass Type IDs page](https://developer.apple.com/account/ios/identifier/passTypeId) and create your pass type.
2. Go to the [certificate section](https://developer.apple.com/account/ios/certificate/) and follow the instructions to create a certificate for your pass.
3. Download the certificate, and ensure it is named `Certificates.p12`.
4. Run the following command: `openssl pkcs12 -in Certificates.p12 -out PassCert.pem`.
5. Your pass certificate is now stored in `PassCert.pem`!

You'll also need to download the Apple Worldwide Developer Relations Root Certificate Authority file to sign passes.

1. Download the [certificate from here](https://www.apple.com/certificateauthority/).
2. Import it into Keychain Access (double-click it).
3. Find it in Keychain Access, and export it as a .pem file.

## Documentation

For documentation of the original repo, check out the [documentation](https://aydenp.github.io/PassEncoder/) and see all of the methods and variables that are made available to you.

## Contributing

If you find an issue in the code or while using it, [create an issue](/issues/new). If you can, you're encouraged to contribute and make a [pull request](/pulls).

## License

This project is licensed under the [MIT license](/LICENSE). Please make sure you comply with its terms while using it in any way.

## Links

