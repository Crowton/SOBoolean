public class GUI
{
    public void Draw()
    {
        // Draw the sidebar background
        stroke(255);
        strokeWeight(1);
        fill(25);
        rect(-1, -1, MenuWidth + 2, height + 2);
        
        // Draw sidebar title
        fill(255);
        textSize(26);
        textAlign(CENTER, CENTER);
        text("Logic Gates", MenuWidth / 2, 25);
        stroke(55);
        line(-1, 50, MenuWidth + 1, 50);
        
        // Draw the gates
        float startY = 50;
        float yPerGate = (height - startY) / 5;
        /*
        noStroke();
        fill(AndColor, 50);
        rect(0, startY, 181, 1 * yPerGate);
        fill(OrColor, 50);
        rect(0, startY + 1 * yPerGate, 181, 2 * yPerGate);
        fill(XorColor, 50);
        rect(0, startY + 2 * yPerGate, 181, 3 * yPerGate);
        fill(NotColor, 50);
        rect(0, startY + 3 * yPerGate, 181, 4 * yPerGate);
        */
        
        ellipseMode(DIAMETER);
        // AND gate
        float y = startY + ((yPerGate + startY) / 3) + (0 * yPerGate);
        float x = MenuWidth / 2 - 12.5;
        textSize(18);
        textAlign(CENTER, BOTTOM);
        fill(255);
        text("AND Gate", MenuWidth / 2, y - 10);
        noStroke();
        fill(AndColor);
        rect(x - 25, y, 50, 50);
        arc(x + 24, y + 25, 50, 50, -TAU / 4, TAU / 4);
        
        // OR Gate
        y = startY + ((yPerGate + startY) / 3) + (1 * yPerGate);
        fill(255);
        text("OR Gate", MenuWidth / 2, y - 10);
        noStroke();
        fill(OrColor);
        arc(x - 25, y + 25, 150, 50, -TAU/4, TAU/4);
        
        // XOR Gate
        y = startY + ((yPerGate + startY) / 3) + (2 * yPerGate);
        fill(255);
        text("XOR Gate", MenuWidth / 2, y - 10);
        noStroke();
        fill(XorColor);
        arc(x + 7 - 25, y + 25, 150 - 7 * 2, 50, -TAU/4, TAU/4);
        stroke(XorColor);
        strokeWeight(2);
        line(x + 1 - 25, y + 1, x + 1 - 25, y + 50 - 2);
        
        // NOT Gate
        y = startY + ((yPerGate + startY) / 3) + (3 * yPerGate);
        fill(255);
        text("NOT Gate", MenuWidth / 2, y - 10);
        noStroke();
        fill(NotColor);
        triangle(x - 25, y, x - 25 + 59, y + 25, x - 25, y + 50);
        ellipse(x - 25 + 66, y + 25, 16, 16);
        
        // Toggle Gate
        y = startY + ((yPerGate + startY) / 3) + (4 * yPerGate);
        fill(255);
        text("Toggle Gate", MenuWidth / 2, y - 10);
        noStroke();
        fill(ToggleColor);
        rect(x - 25, y, 75, 75);
        
        // Reset button
        fill(25);
        stroke(255);
        strokeWeight(2);
        rect(width - 130, height - 80, 100, 50);
        fill(255);
        textAlign(CENTER, CENTER);
        text("Reset", width - 80, height - 58);
        
        // George Boole Info
        fill(25);
        stroke(255);
        strokeWeight(2);
        rect(width - 180, 30, 150, 250);
        fill(255);
        textAlign(CENTER, CENTER);
        text("George Boole:", width - 105, 45);
        line(width - 170, 60, width - 40, 60);
        textSize(14);
        textAlign(CENTER, TOP);
        text(
            "2. november 1815 8. december 1864\n" +
            "var en engelsk filosof og matematiker, mest kendt for sin opfindelse og udvikling af Boolsk algebra."
        , width - 170, 75, 130, 255);
    }
    void HandleClick()
    {
        // Determine type of gate to place
        int type = -1;
        float startY = 50;
        float yPerGate = (height - startY) / 5;
        if(IsWithin(mouseX, mouseY, 0, startY, 181, 1 * yPerGate))
            type = 1;
        if(IsWithin(mouseX, mouseY, 0, startY + 1 * yPerGate, 181, 2 * yPerGate))
            type = 2;
        if(IsWithin(mouseX, mouseY, 0, startY + 2 * yPerGate, 181, 3 * yPerGate))
            type = 3;
        if(IsWithin(mouseX, mouseY, 0, startY + 3 * yPerGate, 181, 4 * yPerGate))
            type = 4;
        if(IsWithin(mouseX, mouseY, 0, startY + 4 * yPerGate, 181, 5 * yPerGate))
            type = 5;
           
        println("GUI TYPE: " + type);
        // Switch to create gate
        switch (type)
        {
            //And
            case(1):
                CurrentlyPlacing = new AndGate(new PVector(mouseX + 35, mouseY + 25));
                break;
            //Or
            case(2):
                CurrentlyPlacing = new OrGate(new PVector(mouseX + 35, mouseY + 25));
                break;
            //Xor
            case(3):
                CurrentlyPlacing = new XorGate(new PVector(mouseX + 35, mouseY + 25));
                break;
            //Not
            case(4):
                CurrentlyPlacing = new NotGate(new PVector(mouseX + 35, mouseY + 25));
                break;
            // Toggle
            case(5):
                CurrentlyPlacing = new ToggleGate(new PVector(mouseX + 35, mouseY + 25));
                break;
            default:
                break;
        }
    }
}

boolean IsWithin(float posx, float posy, float x, float y, float w, float h)
{
    return posx > x && posx < x + w && posy > y && posy < y + h;
}