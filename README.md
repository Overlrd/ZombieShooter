# ZombieShooter
#### Video Demo: https://youtu.be/ErvDZsV8Ndc
#### Description:
**"Zombie Shooter"** is a 2D game written in Lua with LOVE2D, where you'll take on the role of a survivor in a top-down view. Your mission is clear: defeat waves of hungry zombies by shooting them.Can you stay alive and keep the zombies at bay? 

"Zombie Shooter is developed using Lua and the Love2D framework. The game draws inspiration from the TopDownShooter project featured in this [Udemy course](https://www.udemy.com/course/lua-love/). However, Zombie Shooter includes several features not covered in the course, such as:

- A fully functional State Machine
- World boundaries to enhance gameplay
- An intuitive Collision Detection mechanism
- Immersive Sound Effects
- An overall improved code structure that introduces game elements as Objects."

#### Content
The codebase contains those files:
 - ```main.lua```: The *main.lua* file serves as the entry point for the game. It loads and manages game states, handles sound effects, defines controls (utilizing the French layout Z-S-Q-D), and displays the background. It plays a central role in ensuring the game runs smoothly and effectively.

##### Game State
 - `StateMacine.lua`: The *StateMachine.lua* file contains code for managing game states within the Zombie Shooter game. It defines a StateMachine class that allows for smooth transitions between different game states.
 - `states/BaseState.lua`: The *BaseState.lua* file defines a basic structure for game states within the Zombie Shooter game. It creates a BaseState class that serves as a blueprint for individual game states.

- `states/TitleScreenState.lua`: The TitleScreenState.lua file is part of the Zombie Shooter game and defines the behavior and appearance of the title screen state. Here's a summary of what this file does:
  - It inherits from the BaseState class, which provides a template for different game states.
  - The update function handles updates for the title screen. It waits for the player to press the "Enter" or "Return" key. When that happens, it transitions to the "Play State" by calling gStateMachine:change('play').
  - The render function is responsible for rendering the title screen. It displays the game's title, "ZombieShooter," in a larger font at the center of the screen. It also prompts the player to press "Enter" to start the game.


 - `states/PlayState/lua`: The *PlayState.lua* file is a part of the Zombie Shooter game. It defines the behavior and logic for the "Play State" of the game, where the actual gameplay takes place. Here's a summary of what this file does:
   - It inherits from the BaseState class, which provides a template for different game states.
   - In the init function, it initializes various game components, such as the player, zombies, bullets, and game variables like the current vague, spawned zombies, and the player's score.
   - The update function is responsible for managing game updates. It controls the spawning of zombies, updates player and zombie positions, handles bullet mechanics, checks for collisions between bullets and zombies, and updates the score and game state accordingly.
   - The render function is responsible for rendering the game. It draws zombies, bullets, and the player on the screen. It also displays information about the current vague and the number of killed zombies.

- `states/ScoreState.lua`: The *ScoreState.lua* file is a component of the Zombie Shooter game, defining the behavior and presentation of the score screen state. Here's an overview of what this file does:
  - It inherits from the BaseState class, which provides a template for different game states.
  - In the enter function, it receives the player's score as a parameter when transitioning to this state.
  - The update function handles updates for the score screen. It waits for the player to press the "Enter" or "Return" key. When that happens, it transitions back to the "Play State" by calling gStateMachine:change('play').
  - The render function is responsible for rendering the score screen. It displays the message "Oof! You lost!" at the center of the screen, followed by the player's score and a prompt to press "Enter" to play again.

##### Character

- `Player.lua`: The *Player.lua* file defines the behavior and attributes for the player character in the Zombie Shooter game. Here's a breakdown of what this file does:
  - It requires the 'Bullet' module, indicating that it will use elements from that module.
  - The Player class is defined using the Class{} syntax, suggesting that it inherits from a class (not shown in this file, likely from class.lua).
  - In the init function, it loads the player's image and sets up its initial position at the center of the screen. It also defines the player's speed.
  - The update function is responsible for updating the player's position based on user input. It calls the handleInput function to process keyboard input and ensures that the player stays within the screen boundaries using the notOutTheScreen function.
  - The render function draws the player's image on the screen, orienting it based on the mouse's position relative to the player.
  - The handleInput function processes keyboard input and updates the player's position accordingly, allowing the player to move in response to key presses.
  - The notOutTheScreen function prevents the player from moving outside the screen boundaries. If the player reaches the screen's edge, their position is adjusted to keep them within the visible area.

- `Zombie.lua`: The *Zombie.lua* file defines the behavior and attributes for the zombie enemy characters in the Zombie Shooter game. Here's a breakdown of what this file does:
  - It creates the Zombie class using the Class{} syntax.
  - It loads a zombie image, presumably used for rendering zombies on the screen.
  - In the init function, it sets up the initial state of a zombie character. This includes assigning a spawn position, initializing position, width, height, speed, and a radius for collision detection. The dead attribute is set to false to indicate that the zombie is initially alive.
  - The update function is responsible for updating the zombie's position based on the player's position. It calculates the direction toward the player using the math.atan2 function and moves the zombie in that direction.
  - There is commented-out code for adding random angles to the zombie's direction, which can introduce some variability in zombie movement. This code can be uncommented and adjusted as needed.
  - The spawn function determines a random spawn position for the zombie. It can spawn on one of the four sides of the screen (left, right, top, or bottom).
  - The render function draws the zombie on the screen at its current position using the loaded zombie image.

- `Bullet.lua`: The Bullet.lua file defines the behavior and attributes for bullets in the Zombie Shooter game. Here's a breakdown of what this file does:
  - It creates the Bullet class using the Class{} syntax.
  - In the init function, it loads a bullet image and sets up the initial state of a bullet. This includes assigning an initial position (x and y), width, height, speed, direction, and setting the dead attribute to false to indicate that the bullet is initially active.
  - The update function is responsible for updating the bullet's position based on its direction and speed. It uses trigonometric functions (math.cos and math.sin) to calculate the new position in each frame, allowing the bullet to move along a specific trajectory.
  - The render function draws the bullet on the screen at its current position, applying a scaling factor to adjust its size and centering it using the image's dimensions.

##### Utilitary 

- zombie_utils.lua: The zombie_utils.lua file contains utility functions for managing collision detection and avoidance between zombie objects in the Zombie Shooter game. Here's a breakdown of what this file does:
  - The checkCollision function checks whether two zombies (or any objects with similar properties) have collided. It calculates the distance between the centers of the two zombies and compares it to the sum of their radii. If the distance is less than the sum of the radii, it returns true to indicate a collision; otherwise, it returns false.
  - The moveZombies function is responsible for handling collision avoidance between zombies. It iterates through a list of zombies and checks for collisions between each pair of zombies. If a collision is detected, it calculates a movement vector that separates the two zombies and moves zombie1 away from zombie2. This separation is achieved by calculating the direction and magnitude of the movement and applying it to zombie1.
  - The file then returns a table containing the two functions, checkCollision and moveZombies, making them accessible for use in other parts of the game

- `class.lua`: The *class.lua* file is a Lua library that facilitates object-oriented programming (OOP) in Lua. It enables the creation of classes and objects, allowing for the organization and encapsulation of code in a more structured manner.

##### Sprites

- `sprites/player.png`: the image of the player character in the game
- `sprites/bullet.png`: the image of the bullet in the game
- `sprites/zombie.png`: the image of the zombie character in the game

##### Sounds
- `sounds/hurt.wav`: The sound effect that plays when a zombie is destroyed.
- `sounds/lost.wav`: The sound effect that plays when the player loses.
- `sounds/music.wav`: The game's background music.
- `sounds/shoot.wav`: The sound effect that plays when the player shoots.

##### Fonts
- `font.ttf`: The default font of the game used to display the score when playing.
- `font2`: The second font used in ScoreState and TitleScreenState to display the score or the game screen title.
