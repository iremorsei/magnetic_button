## 0.0.1

* Magnetic Button initial release.

## 0.0.2

* Description Update

## 0.0.3

* Initial Feature Updates with Bugs

## 0.0.4
### Added
- New properties for the magnetic widget:
  - `duration`: The duration of the animation.
  - `curve`: The curve of the animation.
  - `height`: The height of the magnetic widget. This is an optional parameter.
  - `width`: The width of the magnetic widget. This is an optional parameter.
  - `padding`: The padding around the magnetic widget. This is an optional parameter.
  - `mobile`: A boolean value indicating whether the widget should respond to long press events on mobile(not yet tested for functionality). If false, only Web will work.
### Improved
- Performance optimizations in the code:
  - reduced the number of times renderBox.localToGlobal(Offset.zero) is called
  - moved the calculations for relX and relY inside the if (distanceMouseButton < distanceToTrigger) statement, so they’re only calculated if necessary.

## 0.0.5
### Added
- New properties for the magnetic widget:
  - `onChanged`: A nullable callback function called when an `Offset` change event occurs.

## 0.0.6
### Added
* Major Bug Fix

## 0.0.7
### Added
* Bug Fix & No need to use Global Key 
- New properties for the magnetic widget:
  - `mx`: This is the horizontal offset of the magnetic widget
  - `my`: This is the vertical offset of the magnetic widget

## 0.0.8
### Added
* Minor Bug Fix
- New property for the magnetic widget::
  - `distance`: Determines the proximity at which an animation for a widget is initiated.
 

### To Do
- test hold feature on a live mobile device.
