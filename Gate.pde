class Gate
{
    float x, y;
    int type; //0 = and, 1 = or, 2 = xor, 3 = not, 4 = Main
    boolean value;

    //Where the input from in array
    int[] input = new int[2];

    Gate(float xIn, float yIn, int typeIn, boolean val)
    {
        x = xIn;
        y = yIn;
        type = typeIn;
        value = val;
    }

    void SetInput(int in, int from)
    {
        input[in] = from;
    }

    void Draw(GUI gui)
    {
        switch (type)
        {
            //And
            case(0):
            gui.DrawAnd(x, y);
            //Or
            case(1):
            gui.DrawOr(x, y);
            //Xor
            case(2):
            gui.DrawXor(x, y);
            //Not
            case(3):
            gui.DrawNot(x, y);
        }
    }

    boolean ReturnOut()
    {
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