# HandyExtensions for iOS written in Swift

Collection of useful extension for extraordinary iOS projects. 

## []()
![alt tag](https://github.com/chanonly123/HandyExtensionsiOS/blob/master/grad_demo.gif)
![alt tag](https://github.com/chanonly123/HandyExtensionsiOS/blob/master/stack_demo.gif)

## Features
- Gradient Loading Animation
- Animated hiding subviews of UIStackView

## Runtime Requirements

- iOS9.0 or later
- Xcode 9.0 - Swift 3.0 or later

## Usage

Just copy extensions you want

### Gradient Loading animation
`yourView.setLoading(Bool)`

### UIStackView child hiding
```
// needs extra parameter to animate layout changes.
// yourView must be imidiate subview of UIStackView.
yourView.setHidden(true, layout: self.view)
```

## Contributing

Contributions are always welcome!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

