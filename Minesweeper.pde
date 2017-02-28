

import de.bezier.guido.*;
public final static int NUM_ROWS= 20;
public final static int NUM_COLS=20;
public final static int NUM_BOMBS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    textSize(20);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[20][20];
    for (int i=0;i<NUM_ROWS;i++)
    {
        for (int j=0; j<NUM_COLS;j++)
        {
         buttons[i][j]= new MSButton(i,j);

        }
    }
    //your code to declare and initialize buttons goes here
    bombs= new ArrayList <MSButton>();
    setBombs();
}
public void setBombs()
{
  

    while (bombs.size()<30)
    {
    int i=(int)(Math.random()*NUM_ROWS);
    int j=(int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[i][j]))
            bombs.add(buttons[i][j]);
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
    displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    text("good job", 200,200);
}
public void displayWinningMessage()
{
    //your code here
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
         width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;

        if (isValid(r,c) && buttons[r][c].isClicked())
        {
            System.out.println(r+""+c);
            clicked=true;
        if(isValid(r-1,c) && buttons[r-1][c].isMarked())
         buttons[r-1][c].mousePressed();
        if(isValid(r-1,c+1) && buttons[r-1][c+1].isMarked())
         buttons[r-1][c+1].mousePressed();
        if(isValid(r-1,c-1) && buttons[r-1][c-1].isMarked())
         buttons[r-1][c-1].mousePressed();
        if(isValid(r,c+1) && buttons[r][c+1].isMarked())
         buttons[r][c+1].mousePressed();
        if(isValid(r,c-1) && buttons[r][c-1].isMarked())
         buttons[r][c-1].mousePressed();
        if(isValid(r+1,c-1) && buttons[r+1][c-1].isMarked())
         buttons[r+1][c-1].mousePressed();
        if(isValid(r+1,c+1) && buttons[r+1][c+1].isMarked())
         buttons[r+1][c+1].mousePressed();
        if(isValid(r+1,c) && buttons[r+1][c].isMarked())
         buttons[r+1][c].mousePressed() ;  
        }
        else if(bombs.contains(this))
        {
            displayLosingMessage();
        }
        // else if(buttons[r][c].countBombs(r,c)>0)
        // {
        //     buttons[r][c].setLabel("1");
        // }
        else
        {
            clicked=true;
       
        }

    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
            fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r>=0&&r<=19&&c>=0&&c<=19)
         return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
    
        return numBombs;
    }
}



