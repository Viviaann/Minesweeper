

import de.bezier.guido.*;
public final static int NUM_ROWS= 20;
public final static int NUM_COLS=20;
public final static int NUM_BOMBS=20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs;
public boolean isDed;  
//ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 500);
    textAlign(CENTER,CENTER);
    textSize(20);
    
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
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
  

    while (bombs.size()<40)
    {
    int i=(int)(Math.random()*NUM_ROWS);
    int j=(int)(Math.random()*NUM_COLS);
    if(!bombs.contains(buttons[i][j]))
    {
            bombs.add(buttons[i][j]);
    }
    }
}
public void displayLosingMessage()
{
    background(0);
    fill(255,0,0);
    text("you lose", 200,450);
}

public void draw ()
{
   
    if(isWon())
    displayWinningMessage();
}
public boolean isWon()
{
    //your code here
    return false;
}

public void displayWinningMessage()
{
    text("good job!",200,200);
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
    public boolean keyPressed()
    {
        if(key=='f')
            return true;
        else 
            return false;
    }
    public void mousePressed () 
    {
        clicked = true;

        if(keyPressed==true)
        {
            if(marked==true)
              {clicked=false;
                marked=false;
        }
        
            else
                marked=true;
        }
        else if(bombs.contains(buttons[r][c]))
        {
            displayLosingMessage();
        }
        else if(countBombs(r,c)>0)
        {
            setLabel(""+ countBombs(r,c));
        }

        else
        {
        clicked=true;
        if(isValid(r-1,c)&& !buttons[r-1][c].isClicked())
         buttons[r-1][c].mousePressed();
        if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
         buttons[r+1][c].mousePressed();
         if(isValid(r-1,c-1) && !buttons[r-1][c-1].isClicked())
         buttons[r-1][c-1].mousePressed();
        if(isValid(r,c+1) && !buttons[r][c+1].isClicked())
         buttons[r][c+1].mousePressed();
        if(isValid(r,c-1) && !buttons[r][c-1].isClicked())
         buttons[r][c-1].mousePressed();
        if(isValid(r+1,c-1) && !buttons[r+1][c-1].isClicked())
         buttons[r+1][c-1].mousePressed();
        if(isValid(r+1,c+1) && !buttons[r+1][c+1].isClicked())
         buttons[r+1][c+1].mousePressed();
        if(isValid(r+1,c) && !buttons[r+1][c].isClicked())
         buttons[r+1][c].mousePressed() ;  
        }
        

    }

    public void draw () 
    {    
        if (marked==true)
            fill(0,0,255);
         else if( clicked && bombs.contains(this) ) 
            {
                fill(255,0,0); 
               
           }
        else if(clicked && bombs.contains(buttons[r+1][c]) ) 
            {fill(174,225,242);
            }
         else if( clicked && bombs.contains(buttons[r+1][c-1]) ) 
           { fill(174,225,242);
           }
         else if( clicked && bombs.contains(buttons[r+1][c+1]) ) 
           { fill(174,225,242);
           }
         else if( clicked && bombs.contains(buttons[r-1][c]) ) 
            {fill(174,225,242);}
         else if( clicked && bombs.contains(buttons[r-1][c+1]) ) 
            {fill(174,225,242);}
         else if( clicked && bombs.contains(buttons[r-1][c-1]) ) 
            {fill(174,225,242);}
         else if( clicked && bombs.contains(buttons[r][c+1]) ) 
            {fill(174,225,242);}
         else if( clicked && bombs.contains(buttons[r][c-1]) ) 
            {fill(174,225,242);}
        


        else if (clicked)
            fill( 200 );
        else if(clicked&& !bombs.contains(buttons[0][c]))
            fill(200);
         else 
            fill(100 );

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
        if(r>=0&&r<=NUM_ROWS&&c>=0&&c<=NUM_COLS)
         return true;
        return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        if( isValid(r+1,c) && bombs.contains(buttons[r+1][c]))
            numBombs++;
        if( isValid(r+1,c+1) && bombs.contains(buttons[r+1][c+1]))
             numBombs++;
         if( isValid(r+1,c-1) && bombs.contains(buttons[r+1][c-1]))
             numBombs++;
         if( isValid(r-1,c) && bombs.contains(buttons[r-1][c]))
             numBombs++;
         if( isValid(r-1,c+1) && bombs.contains(buttons[r-1][c+1]))
             numBombs++;
         if( isValid(r-1,c-1) && bombs.contains(buttons[r-1][c-1]))
             numBombs++;
         if( isValid(r,c+1) && bombs.contains(buttons[r][c+1]))
             numBombs++;
         if( isValid(r,c-1) && bombs.contains(buttons[r][c-1]))
             numBombs++;

        return numBombs;
    }
}



