# QBRefreshControl
QBRefreshControl is an abstract base class for creating a refresh control.


## ScreenShot
![ss01.png](http://adotout.sakura.ne.jp/github/QBRefreshControl/ss01.png)
![ss02.png](http://adotout.sakura.ne.jp/github/QBRefreshControl/ss02.png)
![ss03.png](http://adotout.sakura.ne.jp/github/QBRefreshControl/ss03.png)


## Usage
It is very easy to create your own refresh control conforming QBRefreshControl.

1. Create a subclass of QBRefreshControl.
2. Override `setState:` method to specify the behavior for each state of the control.  
In this method, you have to write a `switch()` block and the following cases after `[super setState:state]`.
	* QBRefreshControlStateHidden
	* QBRefreshControlStatePullingDown
	* QBRefreshControlStateOveredThreshold
3. Override `init`, `beginRefreshing`, `endRefreshing` as necessary.


## Example
See *QBRefreshControl* project for example usage.


## License
 Copyright (c) 2013 Katsuma Tanaka
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
