# Magnetic Button

The Magnetic Button is a custom Flutter widget that creates an interactive button with a "magnetic" effect. When you hover over the button, it moves in response to the mouse position, creating a unique and engaging user experience.

## Features

- **Hover Effect**: The button moves in response to the mouse position when hovered over, creating a "magnetic" effect.
- **Return Duration**: When the mouse is not hovering over the widget, the button returns to its original position. The speed at which it returns is controlled by the `returnDuration` property. This property is set in milliseconds, so a larger value will make the return slower, and a smaller value will make it faster.
- **Customizable**: You can customize the child widget of the Magnetic Button to fit your needs.

## Usage


1. First, create a `MagneticButton` widget and pass in your desired child widget:

   ```dart
   MagneticButton(
     child: Container(
       decoration: BoxDecoration(
         borderRadius: BorderRadius.all(Radius.circular(40)),
         color: Color(0xFF1c1d20),
         border: Border.all(color: Color(0xFF303032))
       ),
       width: 160,
       height: 80,
       child: Center(
         child: Text(
           'Explore',
           style: TextStyle(
             fontWeight: FontWeight.w400,
             fontSize: 19,
           ),
         ),
       ),
     ),
   )
   
## Future Features

We’re always looking to improve the Magnetic Button and add new features that enhance its functionality and user experience. Here are some features we’re planning to implement in the future:

- **On-Hold Magnetic Effect**: We’re planning to add an on-hold magnetic effect. This feature will allow the button to continue moving in response to the mouse position even when the mouse button is held down, creating a more interactive user experience.

Please note that these features are planned for future releases and are subject to change. We welcome feedback and suggestions from our users. If you have an idea for a feature that you’d like to see in Magnetic Button, please let us know!