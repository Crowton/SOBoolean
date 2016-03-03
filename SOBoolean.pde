// Variables
ArrayList<Gate> gates = new ArrayList<Gate>();
GUI gui = new GUI();

// Setup
void setup()
{
    // Set Size & Background
    //size(1280, 800);
    fullScreen();
    println("Width: " + width + " Height: " + height);
    background(0);
}

// Draw
void draw()
{
    // Draw GUI
    gui.Draw();
}

void mousePressed()
{
    if (gui.SelectedGate == null)
    {
        int type = -1;

        // Decide which gate type to create
        int h = (height-40 - 50*4) / 4;
        if (IsWithin(mouseX, mouseY, 0, h * 0 + 50, 180, h + 50))
            type = 0;
        if (IsWithin(mouseX, mouseY, 0, h * 1 + 100, 180, h + 50))
            type = 1;
        if (IsWithin(mouseX, mouseY, 0, h * 2 + 150, 180, h + 50))
            type = 2;
        if (IsWithin(mouseX, mouseY, 0, h * 3 + 200, 180, h + 50))
            type = 3;
            
       if(type == -1)
           return;
        
        // Create Gate
        gui.SelectedGate = new Gate(mouseX - 35, mouseY - 25, type, true);
    } else
    {
        for(Gate g : gates)
            if(dist(mouseX, mouseY, g.x + 35, g.y + 25) < 75 || mouseX <= 180 + 50 || mouseX >= width - 50 || mouseY <= 50 || mouseY >= height - 50)
                return;
        
        gates.add(gui.SelectedGate);
        gui.SelectedGate = null;
    }
}
void mouseMoved()
{
    if (gui.SelectedGate != null)
    {
        gui.SelectedGate.x = mouseX - 35;
        gui.SelectedGate.y = mouseY - 25;
    }
}