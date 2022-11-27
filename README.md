# xojo-web-wheel-loading-dialog
Xojo Extends to avoid flickering when showing a web dialog by displaying a progress wheel until all dialog controls are loaded.

# How to use

1. After download and open the project, **copy the webextensions module into your projects**.

![](https://github.com/davidclothier/preparingreadme/blob/main/extensions-pic.png)

2. **In the *Opening* event** of the WebDialog, the first thing you have to do before configuring your controls is to call the method ``ShowProgressWheel(sizePercentageScale)``. ``sizePercentageScale`` must be an integer value between 1 and 100.
3. **In the *Shown* event** of the same WebDialog, call the ``HideProgressWheel`` method.

That's it!

# Result
![](https://github.com/davidclothier/preparingreadme/blob/main/example-dialog.gif)

# Next features to be improved

* Collection of animations in SVG format contained in an enumeration.
* Allow a time delay controlled

# Contribution

Pull requests are welcome!
I'd like to improve this library with your help! If you've fixed a bug or have a feature you've added, just create a pull request. 

### Contact

* David Ropero - david.ropero@gmail.com

[<img src="https://image.freepik.com/iconos-gratis/boton-del-logotipo-de-twitter_318-85053.jpg" alt="Twitter" width="32"/>](https://twitter.com/clothierdroid)
[<img src="http://www.iconsdb.com/icons/preview/black/linkedin-4-xxl.png" alt="Linkedin" width="32"/>](http://www.linkedin.com/in/davidropero)

### License

MIT License
