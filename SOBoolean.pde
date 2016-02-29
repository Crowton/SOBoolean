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
        gui.SelectedGate = new Gate(mouseX, mouseY, 0, true);
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