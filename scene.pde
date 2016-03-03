class GUI
{
    PImage[] gateImg = new PImage[5];
    Gate SelectedGate = null;

    void Draw()
    {
        background(0);

        // Draw gates
        for(Gate g : gates)
            g.Draw(this);
        if (SelectedGate != null)
            SelectedGate.Draw(this);
            
        // Draw placement circle
        if(SelectedGate != null)
        {
            // Check distance to nearest other gates
            for(Gate g : gates)
            {
                if(dist(mouseX, mouseY, g.x + 35, g.y + 25) < 75)
                {
                    noStroke();
                    fill(255, 0, 0, 100);
                    ellipse(g.x + 35, g.y + 25, 75 * 2, 75 * 2);                
                    stroke(#FF0000, 100);
                }
            }
            
            noFill();
            stroke(#FFFFFF);
            if(mouseX <= 180 + 50 || mouseX >= width - 50 || mouseY <= 50 || mouseY >= height - 50)
                stroke(#FF0000);
            ellipse(mouseX, mouseY, 75 * 2, 75 * 2);
        }   
            
        // Draw Menu
        Menu();
    }

    void Menu()
    {
        int w = 180;
        noStroke();
        fill(50);
        rect(0, 0, w, height);

        stroke(255);
        strokeWeight(1);
        line(w, 0, w, height);

        fill(255);
        textAlign(CENTER, CENTER);
        textSize(26);
        text("Gates:", w/2, 20);

        //Draw gates
        for (int i = 0; i < gateImg.length; i++)
        {
            //image();
        }

        int h = (height-40 - 50*4) / 4;
        int ww = (w - 75) / 2;

        DrawAnd(ww, h*0.5 + 40, #FF5555);
        DrawOr(ww, h*1.5 + 50 + 40, #55FF55);
        DrawXor(ww, h*2.5 + 100 + 40, #5555FF);
        DrawNot(ww, h*3.5 + 150 + 40, #FFFF55);
        
        textAlign(CENTER, BOTTOM);
        textSize(18);
        fill(#FFFFFF);
        text("AND Gate", 180 / 2, h * 0.5 + 30);
        text("OR  Gate", 180 / 2, h * 1.5 + 50 + 30);
        text("XOR Gate", 180 / 2, h * 2.5 + 100 + 30);
        text("NOT Gate", 180 / 2, h * 3.5 + 150 + 30);
    }

    void DrawAnd(float x, float y, color col)
    {
        noStroke();
        fill(col);
        rect(x, y, 50, 50);
        arc(x+50, y+25, 50, 50, -TAU/4, TAU/4);
    }

    void DrawOr(float x, float y, color col)
    {
        noStroke();
        fill(col);
        arc(x, y+25, 150, 50, -TAU/4, TAU/4);
    }

    void DrawXor(float x, float y, color col)
    {
        noStroke();
        fill(col);
        arc(x+7, y+25, 150-7*2, 50, -TAU/4, TAU/4);

        stroke(col);
        strokeWeight(2);
        line(x+1, y+1, x+1, y+50-2);
    }

    void DrawNot(float x, float y, color col)
    {
        noStroke();
        fill(col);
        triangle(x, y, x+59, y+25, x, y+50);
        ellipse(x+66, y+25, 16, 16);
    }
}