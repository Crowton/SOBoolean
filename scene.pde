class GUI
{
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
    }

    void DrawAnd(float x, float y)
    {
        noStroke();
        fill(#FFFFFF);
        rect(x, y, 50, 700);
    }
}