

public class Main {
    public static void main(String[] args) {
    	GameBoard game = new GameBoard(25, 25, 30, 15);
        ApplicationWindow window = new ApplicationWindow(game.getGamePanel());
        window.getFrame().setVisible(true);

    	game.start();
    }
}
