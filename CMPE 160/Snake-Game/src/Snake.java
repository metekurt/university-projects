import java.awt.Color;
import java.util.*;
public class Snake implements Drawable {
  private int x = 0;
  private int y = 0;
  private SnakeBody head;
  private Direction currentDir;
  ArrayList<SnakeBody> snakeBodyParts = new ArrayList<SnakeBody>();




	@Override
	public void draw(GridPanel panel) {

      for (SnakeBody bodyPart : snakeBodyParts) {
        bodyPart.draw(panel);
      }

//				 panel.drawSquare(this.x, this.y, Color.RED);
	}


  public void move(Direction direction) {

    int prevX = head.getX();
    int prevY = head.getY();
    currentDir = direction;
    switch(direction){

      case DOWN:
      this.head.setY(head.getY() + 1);

      break;
      case UP:
      this.head.setY(head.getY() - 1);
      break;
      case RIGHT:
      this.head.setX(head.getX() + 1);
      break;
      case LEFT:
      this.head.setX(head.getX() - 1);
      break;

    }


    for (int i = 1; i < snakeBodyParts.size(); i ++){
      SnakeBody bodyPartToFollow = snakeBodyParts.get(i - 1);
      SnakeBody currentBodyPart = snakeBodyParts.get(i);
      int curX = currentBodyPart.getX();
      int curY = currentBodyPart.getY();
      currentBodyPart.move(prevX, prevY);
      prevX = curX;
      prevY = curY;
/*      if (bodyPartToFollow.getX() > currentBodyPart.getX()){
        currentBodyPart.setX(currentBodyPart.getX() + 1);

      } else if (bodyPartToFollow.getX() < currentBodyPart.getX()){
          currentBodyPart.setX(currentBodyPart.getX() -1);
      } else if (bodyPartToFollow.getY() > currentBodyPart.getY()){
        currentBodyPart.setY(currentBodyPart.getY() + 1);
      } else if (bodyPartToFollow.getY() < currentBodyPart.getY()){
        currentBodyPart.setY(currentBodyPart.getY() - 1);
      }
      */

//      snakeBodyParts.get(i).move(bodyPartToFollow.getX() + Math.abs(xChange), bodyPartToFollow.getY() + Math.abs(yChange));

    }


  }

  public void setUsedSpaces(GameBoard gameBoard){
     for (SnakeBody bodyPart : snakeBodyParts){
								//	System.out.format("body part x: %d body part y: %d gridWidth: %d gridHeight: %d \n", bodyPart.getX() , bodyPart.getY(),  gridWidth ,  gridHeight );
				if (gameBoard.isPositionInsideGrid(bodyPart.getX(), bodyPart.getY())){
					    	gameBoard.getGamePanel().getUsedSpaces()[bodyPart.getX()][bodyPart.getY()] = true;
				}


	  	}
  }



  private Snake reproduce(){
    SnakeBody tail = snakeBodyParts.get(snakeBodyParts.size() - 1);

    Snake sibling = new Snake(tail.getX(), tail.getY(), false);
    sibling.attachBodyParts(snakeBodyParts);
    return sibling;

  }

  public int getX(){
    return this.head.getX();
  }
  public int getY(){
    return this.head.getY();
  }
  public void eat(ArrayList<Snake> snakeList, GameBoard gameBoard){
    SnakeBody oldTail = snakeBodyParts.get(snakeBodyParts.size()-1);
    int xOffset = 0;
    int yOffset = 0;
    switch(currentDir){
      case UP:
      yOffset ++;
      break;
      case DOWN:
      yOffset --;
      break;
      case RIGHT:
      xOffset ++;
      break;
      case LEFT:
      xOffset --;
      break;
    }


    //make sure tail doesn't spawn offscreen
    if (       gameBoard.isPositionInsideGrid(oldTail.getX() + xOffset, oldTail.getY() + yOffset) &&
    !gameBoard.getGamePanel().getUsedSpaces()[oldTail.getX() + xOffset][oldTail.getY() + yOffset]
){
    SnakeBody newTail = new SnakeBody(oldTail.getX() + xOffset, oldTail.getY() + yOffset, false);
  } else {
    xOffset = -1;
    yOffset = -1;
    while( gameBoard.isPositionInsideGrid(oldTail.getX() + xOffset, oldTail.getY() + yOffset) &&
    gameBoard.getGamePanel().getUsedSpaces()[oldTail.getX() + xOffset][oldTail.getY() + yOffset]) {
      if (xOffset < 2){
        xOffset++;
        yOffset = -1;
          while( gameBoard.isPositionInsideGrid(oldTail.getX() + xOffset, oldTail.getY() + yOffset) &&
    gameBoard.getGamePanel().getUsedSpaces()[oldTail.getX() + xOffset][oldTail.getY() + yOffset]) {
      if (xOffset != 1){
      yOffset++;

    }



    }
  }
}
}
    SnakeBody newTail = new SnakeBody(oldTail.getX() + xOffset, oldTail.getY() + yOffset, false);

    snakeBodyParts.add(newTail);

    if (snakeBodyParts.size() >= 8) {
      Snake newSnake = reproduce();
      snakeList.add(newSnake);
      gameBoard.addDrawable(newSnake);

    }

  }

private void attachBodyParts(ArrayList<SnakeBody> siblingBodyParts ){
  int size = siblingBodyParts.size();
  for (int i = 2; i < 5; i++) {
    //starts at 2 because we want to get the body part right before tail
    //loop does 3 iterations because the fourth piece of snake was already accounted for in reproduce function
      this.getBodyParts().add(siblingBodyParts.get( size - i));
      siblingBodyParts.remove(size - i);
  }


}


public void tryToMove(GameBoard gameBoard){



				Random r = new Random();
				int min = 0;
				int max = 2;

				int blockedDirection = r.nextInt(max-min) + min;


			//food is to right of snake
      if (gameBoard.isPositionInsideGrid(head.getX() + 1, head.getY())){
      if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX() + 1][head.getY()]){
        if (blockedDirection != 0){

				this.move(Direction.RIGHT);
        return;
      }
      }


		}
    blockedDirection = r.nextInt(max-min) + min;
			//food is to left of snake
       if (gameBoard.isPositionInsideGrid(head.getX() - 1, head.getY())){
        if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX() - 1][head.getY()]){
                  if (blockedDirection != 0){
					this.move(Direction.LEFT);
          return;
        }
        }

		}

blockedDirection = r.nextInt(max-min) + min;
			//food is above snake

     if (gameBoard.isPositionInsideGrid(head.getX(), head.getY()- 1)){
          if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX()][head.getY()- 1]){
                    if (blockedDirection != 0){
            					this.move(Direction.UP);
                      return;
                    }
          }
        }

blockedDirection = r.nextInt(max-min) + min;
			//food is below snake
       	if (gameBoard.isPositionInsideGrid(head.getX(), head.getY()+ 1)){
          if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX()][head.getY() + 1]){
                    if (blockedDirection != 0){
					this.move(Direction.DOWN);
          return;
        }
       }
      }



}

public void runAI(Food food, ArrayList<Snake> snakeList, GameBoard gameBoard){


  

  for (SnakeBody bodyPart : snakeBodyParts){
    if (gameBoard.isPositionInsideGrid(bodyPart.getX(), bodyPart.getY())){
    gameBoard.getGamePanel().getUsedSpaces()[bodyPart.getX()][bodyPart.getY()] = true;
  }
  }



		if (food.getX() == head.getX() &&
			food.getY() == head.getY() ) {
				//food is eaten
				//increase snake size
				//move food around randomly
				this.eat(snakeList, gameBoard);
        food.respawn(gameBoard);
			}

		if (food.getX() > head.getX() ){
			//food is to right of snake
      if (gameBoard.isPositionInsideGrid(head.getX() + 1, head.getY())){
      if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX() + 1][head.getY()]){


				this.move(Direction.RIGHT);
        return;
      }
    }

		} if (food.getX() < head.getX()) {
			//food is to left of snake
      	if (gameBoard.isPositionInsideGrid(head.getX() - 1, head.getY())){
        if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX() - 1][head.getY()]){
					this.move(Direction.LEFT);
          return;
        }
}
		}

		 if (food.getY() < head.getY()) {
			//food is above snake

          	if (gameBoard.isPositionInsideGrid(head.getX(), head.getY()- 1)){
          if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX()][head.getY()- 1]){
            					this.move(Direction.UP);
                      return;
          }
        }

		}
     if (food.getY() > head.getY()) {
			//food is below snake
      	if (gameBoard.isPositionInsideGrid(head.getX(), head.getY()+ 1)){
if (!gameBoard.getGamePanel().getUsedSpaces()[head.getX()][head.getY() + 1]){
					this.move(Direction.DOWN);
          return;
       }
      }
		}

    //snake is stuck, try to move in any direction that is freeDirection
    this.tryToMove(gameBoard);

//System.out.println(head.getX());



		//movement logic
		if (gameBoard.isPositionInsideGrid(this.x, this.y + 1)){
	//	snake.move(Direction.DOWN);
	}



}

public   ArrayList<SnakeBody>   getBodyParts(){
  return this.snakeBodyParts;
}

	/**
	* Default Snake constructor
	*/
	public Snake(int x, int y, boolean isFirstSnake) {
		super();
		this.x = x;
		this.y = y;
    head = new SnakeBody(this.x, this.y, true);
    currentDir = Direction.RIGHT;
    snakeBodyParts.add(head);
    if (isFirstSnake){
    for (int i = 1; i < 4; i++){
      SnakeBody tail = new SnakeBody(this.x - i, this.y, false);
      snakeBodyParts.add(tail);


	}
}
}
}
