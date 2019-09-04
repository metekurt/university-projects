import java.awt.Color;
import java.util.*;
public class Food implements Drawable {
	private int x = 20;
	private int y = 10;
	@Override
	public void draw(GridPanel panel) {
		 panel.drawSmallSquare(this.x, this.y, Color.ORANGE);
	}

	public Food(int x, int y){

		this.x = x;
		this.y = y;
	}



	public int getX(){
		return x;
	}
	public int getY(){
		return y;
	}

	public void setX(int x){
			this.x = x;
	}

	public void setY(int y){
			this.y = y;
	}

	public void respawn(GameBoard gameBoard){
				Random r = new Random();
				int min = 0;
				int max_X = gameBoard.getGridWidth();
				int max_Y = gameBoard.getGridHeight();
				int foodX = r.nextInt(max_X-min) + min;
				int foodY = r.nextInt(max_Y-min) + min;
				while (gameBoard.getGamePanel().getUsedSpaces()[foodX][foodY] == true){
// generate a new random coordinate for the food to spawn if the previously generated coordinate is occupied
										foodX = r.nextInt(max_X-min) + min;
										foodY = r.nextInt(max_Y-min) + min;
				}
				this.move(foodX, foodY);

	}


	public void move(int x, int y){
		this.setY(y);
		this.setX(x);
	}

}
