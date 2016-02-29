Gate[] gates = new Gate[0];
Main scene = new Main();

void setup()
{
    size(1000, 800);

    Gate add = new Gate(400, 400, 0, false);

    gates = (Gate[]) expand(gates, gates.length+1);
    gates[(gates.length-1)] = add;
}

void draw()
{
    scene.Draw();
}