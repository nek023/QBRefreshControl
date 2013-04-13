# QBRefreshControl
QBRefreshControl is an abstract base class for creating a refresh control.

### NOTES
This demo uses [QBAnimationSequence](https://github.com/questbeat/QBAnimationSequence) as a submodule for animation control, so you should do

	git submodule init
	git submodule update
	
at first.


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
*QBRefreshControl* is released under the **MIT License**, see *LICENSE.txt*.
