class Node
{
    ArrayList<Node> Connections = new ArrayList<Node>();

    float X, Y;
    float Size;
    color Color;

    Node(float x, float y, color col)
    {
        X = x;
        Y = y;
        Color = col;
    }

    void Draw()
    {
        // Draw node
        stroke(Color);
        strokeWeight(Size);
        point(X, Y);
    }

    Node GetConnection(int id)
    {
        if (id > Connections.size() - 1)
            return null;

        return Connections.get(id);
    }
    void AddConnection(Node node)
    {
        Connections.add(node);
    }
    void RemoveConnection(Node node)
    {
        if (!(Connections.contains(node)))
            return;

        Connections.remove(node);
    }
    void RemoveConnection(int id)
    {
        if (id > Connections.size() - 1)
            return;

        Connections.remove(id);
    }
    int IndexOf(Node node)
    {
        if (Connections.contains(node))
            return Connections.indexOf(node);

        return -1;
    }
}