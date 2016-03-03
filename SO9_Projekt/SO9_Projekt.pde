    
// Setup
public void setup()
{
    // Set size & background
    size(1280, 800);
    background(0);
}

// Draw
public void draw()
{
    // Clear the background
    background(0);
    
    // Update all gates
    for(LogicGate gate : Gates)
    {
        gate.Update();
    }
    
    // Draw all gates
    for(LogicGate gate : Gates)
    {
        gate.Draw();
    }
    
    // Check placing a gate, if yes draw circles arround other gates
    if(CurrentlyPlacing != null)
    {
        CurrentlyPlacing.Draw();
        
        for(LogicGate g : Gates)
        {
            noFill();
            stroke(#FF0000);
            strokeWeight(2);
            ellipseMode(RADIUS);
            ellipse(g.GetCenter().x, g.GetCenter().y, BorderMargin * 2, BorderMargin * 2);
        }
        
        // Draw circle arround currently placing
        stroke(CanPlaceGate(CurrentlyPlacing.Position.x, CurrentlyPlacing.Position.y) ? #00FF00 : #FF0000);
        noFill();
        ellipse(CurrentlyPlacing.GetCenter().x, CurrentlyPlacing.GetCenter().y, BorderMargin * 2, BorderMargin * 2);
    }
    
    // Draw current node connection
    if(CurrentOutput != null)
    {
        strokeWeight(2);
        stroke(255, 50);        
        line(CurrentOutput.Position.x, CurrentOutput.Position.y, mouseX, mouseY);
    }
    
    // Draw GUI
    g.Draw();
}

// Input handlers
void mouseClicked()
{
    // If out of screen ignore click
    if(mouseX < 0 || mouseY < 0 || mouseX > width || mouseY > height)
        return;
        
    // If currently placing a gate, give that priortiy
    if(CurrentlyPlacing != null && CanPlaceGate(mouseX + 35, mouseY + 25))
    {
        if(mouseButton == RIGHT)
        {
            CurrentlyPlacing = null;
            return;
        }
        
        // Add to gates & clear current
        Gates.add(CurrentlyPlacing);
        CurrentlyPlacing = null;
        return;
    }
    
    // Check if inside GUI area, if yes then let GUI handle mouseclick
    if(mouseX >= 0 &&  mouseX <= MenuWidth)
    {
        g.HandleClick();
        return;
    }
    
    // Reset
    if (mouseX >= width - 130 && mouseX <= width - 30 && mouseY >= height - 80 && mouseY <= height - 30)
    {
        Gates = new ArrayList<LogicGate>();
    }
    
    // Check for clicking on output nodes
    if(CurrentlyPlacing == null && CurrentOutput == null)
    {
        for(LogicGate g : Gates)
        {
            if(g.Output.Clicked(mouseX, mouseY))
            {
                CurrentOutput = g.Output;
                println("click on node");
                return;
            }
        }
    }
    if(CurrentOutput != null)
    {
        if(mouseButton == RIGHT)
        {
            CurrentOutput = null;
            return;
        }
        
        // Loop through gates, find clicked gate node and add input
        for(LogicGate g : Gates)
        {
            if(g.Output.Clicked(mouseX, mouseY))
            {
                g.AddInput(CurrentOutput);
                CurrentOutput = null;
                println("click on node");
                return;
            }
        }
    }
    
    // Check for clicking on togglegate
    for(LogicGate g : Gates)
    {
        try
        {
            if((ToggleGate)g != null && IsWithin(mouseX, mouseY, g.Position.x, g.Position.y, 50, 50))
                ((ToggleGate)g).Value = !((ToggleGate)g).Value;
        }
        catch(Exception e) {println("HERE");}
        //return;
    }
}
void mouseMoved()
{
    if(CurrentlyPlacing != null)
    {
        CurrentlyPlacing.Position.x = mouseX - 35;
        CurrentlyPlacing.Position.y = mouseY - 25;
        return;
    }
}