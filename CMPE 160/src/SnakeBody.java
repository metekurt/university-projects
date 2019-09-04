import java.awt.Color;

public class SnakeBody implements Drawable {
	private int x;
	private int y;
	private int prevX;
	private int prevY;
	private boolean isHead = false;


	/**
	* Default SnakeBody constructor
	*/
	public SnakeBody(int x, int y, boolean isHead) {
		super();
		this.x = x;
		this.y = y;
		prevX = x;
		prevY = y;
		this.isHead = isHead;
	}



		@Override
	public void draw(GridPanel panel) {
		//panel.getUsedSpaces()[prevX][prevY] = false;
		//panel.getUsedSpaces()[x][y] = true;
		if (isHead){
				 panel.drawSquare(this.x, this.y, Color.RED);
			 } else {
				 panel.drawSquare(this.x, this.y, Color.BLACK);
			 }
	}

	public int getX(){
    return x;
  }
  public int getY(){
    return y;
  }

	public void setX(int x){
		prevX = this.x;
			this.x = x;
			}

			public void setY(int y){
				prevY = this.y;
				this.y = y;

			}

public void move(int x, int y){
	prevX = this.x;
	prevY = this.y;
	this.setY(y);
	this.setX(x);
}


}
