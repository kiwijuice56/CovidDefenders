# 'Rona Round UP! - Covid Defenders
#### Eric Alfaro & Zhongyou Wu 

### Disclaimer:
Covid-19 is a very serious problem that has taken millions of lives around the world. This program is in no way attempting to disrespect or trivialize these matters. It was made in the hopes that people could have fun and for us to demonstrate computer science knowledge in the 'Rona Round UP! hackathon. Learn more about Covid-19 here: https://www.cdc.gov/coronavirus/2019-ncov/index.html.

# Covid Defenders
https://www.youtube.com/watch?v=fPNAlO9DQkI
Do you ever look at someone and wonder, what is going on inside their lungs? Probably not, but regardless Covid Defenders lets you fend off Covid-19 in a tower defense game! Your main goal is to strategically place different immune system cells around a map and fend off waves of Covid from reaching the end of the path. Like other tower defense games, these cells will automatically attack covid using projectiles.

Every virus that passes your goal decreases your % of healthy cells, so its imperative that you stay above 0%. Losing your health will result in a game over. Your health is denoted by the % after the heart symbol on the top right.

Waves of covid will naturally pass the map. You can never be sure how many waves there are, so be on guard! Once all waves are over, the next map will appear (3 maps in total).

Your best defense is some of your immune cells: The B cell, Macrophage, and Dendrite. Drag one of the cells from the top right of your screen and drop it on the map! Each type of cell is unique and can even be upgraded! Click on a placed cell to select it and click on the arrow button on the bottom right to upgrade it.

You must think wisely, because you can only place and upgrade cells if you have the required RNA. Your RNA is denoted by the numbers in front of the blue squiggly symbol at the top right. If you can't afford a tower's upgrade or cost, the button will be darker and unpressable (check the exact prices in the table below). You can get more RNA as you defeat viruses or by recycling a cell by clicking on the $ after selecting it. The value shown under the name is what you will get in return (half of what you've spent on that cell).

Launching the game is simple. In the "release" folder, choose the file that matches your OS name and execute it. Make sure you have the matching ".pck" file also installed in the same directory as the game executable (MacOS has no .pck file).
While the Linux and MacOS versions are available, I do not have the resources to test out either version.
I trust that you know how those executables work more than I do! Sorry :(

OS | File
--- | --- |
Windows | win.exe
MacOS | mac.zip
Linux | linux.x86_64

If attempting to launch from the release folder doesn't work, you can install Godot Engine (https://godotengine.org/).
Scan the project folder within Godot once installed onto your system, and the project should load up.

Also note that your program might run with an empty command window.
This is unfortunately related to some bug I can't seem to fix for now.. You do not need to interact with this window, just don't close it while you're playing or the game will close too.

## The Cells
### B Cell
Stat | Value
 --- | --- 
Cost | 40 RNA
Damage | 2 
Hit speed | 0.8 seconds 
Range | Medium
Upgrade Cost | 50 RNA
Upgraded Damage | 3
Upgraded hit speed | 0.75 seconds

The B Cell is a reliable and cheap unit with medium range, damage, and hit speed!
It creates antibodies and fires them at nearby viruses. These antibodies automatically track the virus they were fired at.

### Macrophage
Stat | Value
 --- | --- 
Cost | 55 RNA
Damage | 1
Hit speed | 1.3 seconds
Range | Low
Upgrade Cost | 40 RNA
Upgraded Damage | 2
Upgraded hit speed | 1.1 seconds

The Macrophage might have lower stats than the B Cell overall, but it makes up with its special projectile. When it splits, it's other half goes through all viruses! Macrophages are very powerful for defending clumps of Covid if placed well.

### Dendrite
Stat | Value
 --- | --- 
Cost | 80 RNA
Damage | 9
Hit speed | 2.2 seconds
Range | High
Upgrade Cost | 50 RNA
Upgraded Damage | 14
Upgraded hit speed | 1.5 seconds

The Dendrite is initially a big investment but its power and range pay off. Its overwhelmed by large amounts of Covid and very powerful against bosses.

## Strands of Covid
### Covid-19 (Red)
Stat | Value
 --- | --- 
Health | 5
Damage | 3
Speed | Slow
RNA Drop | 3

### Covid-20 (Purple)
Stat | Value
 --- | --- 
Health | 7
Damage | 4
Speed | Medium
RNA Drop | 4

### Covid-21 (Yellow)
Stat | Value
 --- | --- 
Health | 2
Damage | 5
Speed | Fast
RNA Drop | 3

### Boss Covid (Blue, Large!)
Stat | Value
 --- | --- 
Health | 200
Damage | 90
Speed | Very Slow
RNA Drop | 50

# Supported platforms
Windows 10, Linux, MacOS

# Attributions
Item | Link | Author
 --- | --- | ---
Hurt Sound | https://freesound.org/people/ReadeOnly/sounds/186927// | ReadeOnly (freesound username)
Pop Sound | https://freesound.org/people/InspectorJ/sounds/484268/ | InspectorJ (freesound username)
Music | https://www.youtube.com/watch?v=DpxZ5PHa6xo | Jacob Lizotte
Font | https://www.dafont.com/minecraftia.font | Andrew Tyler

Email alfaroeric127@gmail.com if you have any comments, questions, or concerns!
