// Variables
ArrayList<Gate> gates = new ArrayList<Gate>();
GUI gui = new GUI();

// Setup
void setup()
{
    // Set Size & Background
    size(800, 800);
    //fullScreen();
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
    // Handle selectedgate & gate placement
    if (gui.SelectedGate == null && mouseX <= 180)
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
        return;
    } else if (gui.SelectedGate != null)
    {
        for(Gate g : gates)
            if(dist(mouseX, mouseY, g.x + 35, g.y + 25) < 75 || mouseX <= 180 + 50 || mouseX >= width - 50 || mouseY <= 50 || mouseY >= height - 50)
                return;
        
        gates.add(gui.SelectedGate);
        gui.SelectedGate = null;
        return;
    }
    
    // Handle gate connections
    int i = 0;
    for(Gate g : gates)
    {
        PVector node = new PVector(g.x + 25, g.y + 25); // 14 wide
        PVector node1 = new PVector (g.x - 15, g.y + 5); // 14 wide
        PVector node2 = new PVector (g.x - 15, g.y + 45); // 14 wide
        
        if(dist(node.x, node.y, mouseX, mouseY) < 14 * 2 && gui.currentNodePoint == null && g != gui.currentNodeGate)
        {
            println("place start " + gui.currentNodePoint);
            gui.currentNodeGate = g;
            gui.currentNodePoint = node;
            gui.currentGateIndex = i;
        }
        else if(dist(node.x, node.y, mouseX, mouseY) < 14 * 2)
        {
            println("place stopped " + gui.currentNodePoint);
            gui.currentNodeGate = null;
            gui.currentNodePoint = null;
        }
        else if(dist(node1.x, node1.y, mouseX, mouseY) < 14 * 2 && g != gui.currentNodeGate && gui.currentNodePoint != null)
        {
            println("place end");
            g.input[0] = gui.currentGateIndex;
            gui.currentNodeGate = null;
            gui.currentNodePoint = null;
            return;
        }
        else if(dist(node2.x, node2.y, mouseX, mouseY) < 14 * 2 && g != gui.currentNodeGate && gui.currentNodePoint != null)
        {
            println("place end");
            g.input[1] = gui.currentGateIndex;
            gui.currentNodeGate = null;
            gui.currentNodePoint = null;
            return;
        }
        
        i++;
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