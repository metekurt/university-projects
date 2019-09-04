import java.awt.Color;
import java.util.ArrayList;
import java.util.Random;
import java.util.*;


public class GameBoard extends GridGame {

	private Food food = new Food(20, 10);

	private Snake snake = new Snake(4,2, true);
	private ArrayList<Snake> snakeList = new ArrayList<Snake>();
	private int gridHeight;
	private int gridWidth;
	public GameBoard(int gridWidth, int gridHeight, int gridSquareSize, int frameRate) {
		super(gridWidth, gridHeight, gridSquareSize, frameRate);
		// TODO Auto-generated constructor stub
		this.addDrawable(food);
		this.addDrawable(snake);
		this.snakeList.add(snake);
		this.gridHeight = gridHeight;
		this.gridWidth = gridWidth;
			food.respawn(this); // randomly move food when it spawns

	}

	boolean test = false;
	@Override
	protected void timerTick() {
		for (boolean[] row:  this.getGamePanel().getUsedSpaces()) {
			Arrays.fill(row, false);
		}



		for (Snake curSnake : snakeList) {
				ArrayList<SnakeBody> snakeBodyParts = curSnake.getBodyParts();

		  for (SnakeBody bodyPart : snakeBodyParts){
								//	System.out.format("body part x: %d body part y: %d gridWidth: %d gridHeight: %d \n", bodyPart.getX() , bodyPart.getY(),  gridWidth ,  gridHeight );
				if (isPositionInsideGrid(bodyPart.getX(), bodyPart.getY())){
					    	this.getGamePanel().getUsedSpaces()[bodyPart.getX()][bodyPart.getY()] = true;
				}


	  	}
	}




		int listSize = snakeList.size();

		for (int i = 0; i < listSize; i++) {
		Snake curSnake = snakeList.get(i);
			curSnake.runAI(food, snakeList, this);
			curSnake.setUsedSpaces(this);
			//System.out.println(snakeList.size());
		}

	}

	public boolean isPositionInsideGrid(int x, int y) {
			return (x >= 0 && x < getGridWidth()) && (y >= 0 && y < getGridHeight());
	}

public ArrayList<Snake> getSnakeList(){
	return this.snakeList;
}




}
