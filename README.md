# CTN-Originals AutoHotkey Library

This AutoHotkey library adds some general functionality to the language and tools to speed up everything and make it more efficient to write with. Some of the best things in the library are:

- `console.log`: A logging function that outputs messages to the console.
- `ErrorHandling`: A set of functions to handle errors and exceptions.
- `ArrayUtilities`: A set of functions to manipulate arrays easily.
- `ObjectUtilities`: A set of functions to manipulate objects easily.


## Set-Up

To use this library, simply download the entire repository, store it either in your AutoHotkey\lib folder or store it in a project. 
Now you can include it in your AutoHotkey script using the `#Include` directive:

```ahk
#Include lib\CTN_ahk-lib\import.ahk
```

# Documentation

## console.log

The `console.log` method allows you to log messages to the console for debugging and troubleshooting your scripts. To use it, create an instance of the `console` class and call the `log` method:

```ahk
MyConsole := new console("My Console") 
MyConsole.log("Hello, world!")
```

You can also pass in additional options to customize the behavior of the logger:
```ahk
MyConsole.log("Hello, world!", {prefix: {enable: true, text: "INFO"}})
; Output: 
; INFO: Hello, world!
```

By default, the logger will write to a log file located at `logs\console.txt`.

---
## ArrayUtilities
> Comming soon
---
## ObjectUtilities
> Comming soon

# Contributing
If you have any suggestions or find a bug, please feel free to open an issue or a pull request on GitHub.

- - -


## License
                                 Apache License
                           Version 2.0, January 2004
                        http://www.apache.org/licenses/