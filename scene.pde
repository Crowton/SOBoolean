class GUI
{
    PImage[] gateImg = new PImage[5];
    
    GUI()
    {
        for (int i = 0; i < gateImg.length; i++)
        {
            //gateImg[i] = loadImage("texture/gate" + i + ".png");
        }
    }
    
    
    void Draw()
    {
        background(0);

        Gates();

        Menu();
    }

    void Gates()
    {
        for (int i = 0; i < gates.size(); i++)
        {
            float x = gates.get(i).x;
            float y = gates.get(i).y;
            switch (gates.get(i).type)
            {
                //And
                case(0):
                    DrawAnd(x, y);
                    break;
            }
        }
    }

    void Menu()
    {
        int w = 180;
        noStroke();
        fill(50);
        rect(0, 0, w, height);

        stroke(150);
        strokeWeight(3);
        line(w, 0, w, height);

        fill(255);
        textAlign(CENTER, CENTER);
        textSize(20);
        text("Gates:", w/2, 20);
        
        //Draw gates
        for (int i = 0; i < gateImg.length; i++)
        {
            //image();
        }
        
        int h = (height-40 - 50*4) / 4;
        int ww = (w - 75) / 2;
        
        DrawAnd(ww, h*0.5 + 40);
        DrawOr(ww, h*1.5 + 50 + 40);
        DrawXor(ww, h*2.5 + 100 + 40);
        DrawNot(ww, h*3.5 + 150 + 40);
    }

    void DrawAnd(float x, float y)
    {
        noStroke();
        fill(#FFFFFF);
        rect(x, y, 50, 50);
        arc(x+50, y+25, 50, 50, -TAU/4, TAU/4);
    }
    
    void DrawOr(float x, float y)
    {
        noStroke();
        fill(#FFFFFF);
        arc(x, y+25, 150, 50, -TAU/4, TAU/4);
    }
    
    void DrawXor(float x, float y)
    {
        noStroke();
        fill(#FFFFFF);
        arc(x+7, y+25, 150-7*2, 50, -TAU/4, TAU/4);
        
        stroke(#FFFFFF);
        strokeWeight(2);
        line(x+1, y+1, x+1, y+50-2);
    }
    
    void DrawNot(float x, float y)
    {
        noStroke();
        fill(#FFFFFF);
        triangle(x, y, x+59, y+25, x, y+50);
        ellipse(x+66, y+25, 16, 16);
    }
}