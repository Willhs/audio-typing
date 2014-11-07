README for Will HS's Keyboard Helper in ChucK

This program is written in the ChucK programming langauge: http://chuck.cs.princeton.edu/.

It generates unique sounds based on keyboard input like:
- Inserting letters (different for lower and upper case)
- Inserting digits
- Inserting symbols (different sounds for many symbols
- Inserting whitespace
- Deleting
- Navigating text with arrow keys, ctrl, home, end, page down/up
- Executing common functions like copy, paste, undo, save
- Executing less-common functions like switching between, creating and closing tabs and windows, refreshing, find and replace, ctrl+alt+delete
- (Coming soon) text selections

How to use:
1.	Use KeyCodePrinter.ck to determine key codes for your keyboard setup.
2.	Change default key codes in keys.txt (if needed).
3.	Run with Main.ck.
