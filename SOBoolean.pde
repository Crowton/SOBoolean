// Variables
ArrayList<Gate> gates = new ArrayList<Gate>();
GUI gui = new GUI();

// Setup
void setup()
{
    // Set Size & Background
    size(800, 800);
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
    if(gui.SelectedGate == null)
    {
        int type = 0;
        
        /*
        DrawAnd(ww, h*0.5 + 40);
        DrawOr(ww, h*1.5 + 50 + 40);
        DrawXor(ww, h*2.5 + 100 + 40);
        DrawNot(ww, h*3.5 + 150 + 40);
        */
        
        // Decide which gate type to create
        int h = (height-40 - 50*4) / 4;
        if(IsWithin(mouseX, mouseY, 0, h * 0 + 50, 180, h + 50))
            type = 0;
        if(IsWithin(mouseX, mouseY, 0, h * 1 + 50, 180, h + 50))
            type = 1;
        if(IsWithin(mouseX, mouseY, 0, h * 2 + 50, 180, h + 50))
            type = 2;
        if(IsWithin(mouseX, mouseY, 0, h * 3 + 50, 180, h + 50))
            type = 3;
        
        // Create Gate
        gui.SelectedGate = new Gate(mouseX, mouseY, type, true);
    }
    else
    {
        gates.add(gui.SelectedGate);
        gui.SelectedGate = null;
    }
}
void mouseMoved()
{
    if(gui.SelectedGate != null)
    {
        gui.SelectedGate.x = mouseX;
        gui.SelectedGate.y = mouseY;
    }
}