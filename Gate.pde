class Gate
{
    float x, y;
    int type; //0 = and, 1 = or, 2 = xor, 3 = not, 4 = Main
    boolean value;
    color col = #FFFFFF;

    //Where the input from in array
    int[] input = {0, 0};

    Gate(float xIn, float yIn, int typeIn, boolean val)
    {
        x = xIn;
        y = yIn;
        type = typeIn;
        value = val;
        
        switch (type)
        {
            //And
            case(0):
                col = #FF5555;
                break;
            //Or
            case(1):
                col = #55FF55;
                break;
            //Xor
            case(2):
                col = #5555FF;
                break;
            //Not
            case(3):
                col = #FFFF55;
                break;
            default:
                break;
        }
        
        if(type == 3)
            input = new int[] { 0 };
    }

    void SetInput(int in, int from)
    {
        input[in] = from;
    }

    void Draw(GUI gui)
    {   
        // Draw the gate itself
        switch (type)
        {
            //And
            case(0):
                gui.DrawAnd(x, y, col);
                break;
            //Or
            case(1):
                gui.DrawOr(x, y, col);
                break;
            //Xor
            case(2):
                gui.DrawXor(x, y, col);
                break;
            //Not
            case(3):
                gui.DrawNot(x, y, col);
                break;
            default:
                break;
        }
        
        // Draw "state" circle
        color outcol = ReturnOut() ? #00FF00 : #FF0000;
        strokeWeight(2);
        stroke(#000000);
        fill(outcol);
        ellipse(x + 25, y + 25, 10, 10);
        
        // Draw inputs / Input lines outline
        stroke(0);
        strokeWeight(4);
        if(input.length >= 1)
        {
            line(x - 15, y + 5, x + 25, y + 25);
        }
        if(input.length >= 2)
        {
            line(x - 15, y + 45, x + 25, y + 25);
        }
        
        // Input circles
        noStroke();
        fill(#FFFFFF);
        if(input.length >= 1)
        {
            ellipse(x - 15, y + 5, 10, 10);
        }
        if(input.length >= 2)
        {
            ellipse(x - 15, y + 45, 10, 10);
        }
        
        // Input lines
        strokeWeight(2);
        if(input.length >= 1)
        {
            stroke(input[0] == 1 ? #00FF00 : #FF0000);
            line(x - 15, y + 5, x + 25, y + 25);
        }
        if(input.length >= 2)
        {
            stroke(input[1] == 1 ? #00FF00 : #FF0000);
            line(x - 15, y + 45, x + 25, y + 25);
        }
    }

    boolean ReturnOut()
    {
        if(input.length != 2 || input.length != 1)
            return false;
        
        switch (type)
        {
            //And
            case(0):
            return (gates.get(input[0]).ReturnOut() & gates.get(input[1]).ReturnOut());

            //Or
            case(1):
            return (gates.get(input[0]).ReturnOut() | gates.get(input[1]).ReturnOut());

            //Xor
            case(2):
            return (
                (gates.get(input[0]).ReturnOut() | gates.get(input[1]).ReturnOut())
                &
                !(gates.get(input[0]).ReturnOut() & gates.get(input[1]).ReturnOut())
                );

            //Not
            case(3):
            return (!gates.get(input[0]).ReturnOut());

            //Main Input
            case(4):
            return value;

        default:
            return false;
        }
    }
}