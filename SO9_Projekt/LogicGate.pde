public abstract class LogicGate
{
    // "Properties" / Variables
    public PVector Position;
    public Node Output; 
    protected ArrayList<Node> Inputs = new ArrayList<Node>();
    
    protected color Color = #FFFFFF;
       
    // Constructors / CTX
    public LogicGate(PVector position)
    {
        Position = position;
    }
    
    // Public methods
    public abstract PVector GetCenter(); 
    public abstract boolean GetOutput();
    public abstract void Draw();
    public abstract void Update();
    public abstract boolean AddInput(Node in);
    public ArrayList<Node> GetInputChain()
    {
        ArrayList<Node> buffer = new ArrayList<Node>();
        buffer.addAll(Inputs);
        println("Inputs: " + Inputs.size());
        synchronized(buffer)
        {
            try
            {
                ArrayList<Node> buffer2 = new ArrayList<Node>();
                for(Node input : buffer)
                {
                    if(input != null && input._parent != null)
                        buffer2.addAll(input._parent.GetInputChain());
                }
                buffer.addAll(buffer2);
            }
            catch(Exception up)
            {
                println(up);
            }
        }
        
        return buffer;
    }
}

public boolean CanPlaceGate(float x, float y)
{
    for(LogicGate g : Gates)
    {
        if(dist(x + 35, y + 25, g.GetCenter().x, g.GetCenter().y) < BorderMargin * 4 || x <= MenuWidth + BorderMargin || x >= width - BorderMargin || y <= BorderMargin || y >= height - BorderMargin)
                return false;
    }
    
    return true;
}

public class AndGate extends LogicGate
{
    // Constrcutor
    public AndGate(PVector position)
    {
        super(position);
        
        Color = AndColor;
        Output = new Node(this, GetCenter());
    }
    
    // Public Methods
    public void Update()
    {
    }
    public void Draw()
    {
        // Draw input points
        strokeWeight(2);
        if(Inputs.size() > 0 && Inputs.get(0) != null)
        {
            Node input1 = Inputs.get(0);
            stroke(input1.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input1.Position.x, input1.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        if(Inputs.size() > 1 && Inputs.get(1) != null)
        {
            Node input2 = Inputs.get(1);
            stroke(input2.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input2.Position.x, input2.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        
        // Draw the gate itself
        noStroke();
        fill(Color);
        rect(Position.x, Position.y, 50, 50);
        arc(Position.x + 50, Position.y + 25, 50, 50, -TAU/4, TAU/4);
        
        // Draw the output node
        Output.Position = GetCenter();
        Output.Draw();
        
        // Draw info
        fill(255);
        textSize(12);
        textAlign(CENTER, CENTER);
        text("Inputs: " + Inputs.size(), Position.x + 25, Position.y + 65);
    }
    public PVector GetCenter()
    {
        return new PVector(Position.x + 35, Position.y + 25);
    } 
    public boolean GetOutput()
    {
        if(Inputs.size() != 2)
            return false;
        
        Node input1 = Inputs.get(0);
        Node input2 = Inputs.get(1);
        return input1.GetOutput() && input2.GetOutput();
    }
    public boolean AddInput(Node in)
    {
        if(Inputs.size() >= 2)
            return false;
            
        Inputs.add(in);
        return true;
    }
}
public class OrGate extends LogicGate
{
    // Constrcutor
    public OrGate(PVector position)
    {
        super(position);
        
        Color = OrColor;
        Output = new Node(this, GetCenter());
    }
    
    // Public Methods
    public void Update()
    {
    }
    public void Draw()
    {
        // Draw input points
        strokeWeight(2);
        if(Inputs.size() > 0 && Inputs.get(0) != null)
        {
            Node input1 = Inputs.get(0);
            stroke(input1.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input1.Position.x, input1.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        if(Inputs.size() > 1 && Inputs.get(1) != null)
        {
            Node input2 = Inputs.get(1);
            stroke(input2.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input2.Position.x, input2.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        
        // Draw the gate itself
        noStroke();
        fill(Color);
        arc(Position.x, Position.y + 25, 150, 50, -TAU/4, TAU/4);
        
        // Draw the output node
        Output.Position = GetCenter();
        Output.Draw();
        
        // Draw info
        fill(255);
        textSize(12);
        textAlign(CENTER, CENTER);
        text("Inputs: " + Inputs.size(), Position.x + 25, Position.y + 65);
    }
    public PVector GetCenter()
    {
        return new PVector(Position.x + 35, Position.y + 25);
    } 
    public boolean GetOutput()
    {
        if(Inputs.size() != 2)
            return false;
        
        Node input1 = Inputs.get(0);
        Node input2 = Inputs.get(1);
        return input1.GetOutput() || input2.GetOutput();
    }
    public boolean AddInput(Node in)
    {
        if(Inputs.size() >= 2)
            return false;
            
        Inputs.add(in);
        return true;
    }
}

public class XorGate extends LogicGate
{
    // Constrcutor
    public XorGate(PVector position)
    {
        super(position);
        
        Color = XorColor;
        Output = new Node(this, GetCenter());
    }
    
    // Public Methods
    public void Update()
    {
    }
    public void Draw()
    {
        // Draw input points
        strokeWeight(2);
        if(Inputs.size() > 0 && Inputs.get(0) != null)
        {
            Node input1 = Inputs.get(0);
            stroke(input1.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input1.Position.x, input1.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        if(Inputs.size() > 1 && Inputs.get(1) != null)
        {
            Node input2 = Inputs.get(1);
            stroke(input2.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input2.Position.x, input2.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        
        // Draw the gate itself
        noStroke();
        fill(Color);
        arc(Position.x + 50 - 50 + 7, Position.y + 25, 150 - 7 * 2, 50, -TAU/4, TAU/4);
        stroke(Color);
        strokeWeight(2);
        line(Position.x + 1, Position.y + 1, Position.x + 1, Position.y + 50 - 2);
        
        // Draw the output node
        Output.Position = GetCenter();
        Output.Draw();
        
        // Draw info
        fill(255);
        textSize(12);
        textAlign(CENTER, CENTER);
        text("Inputs: " + Inputs.size(), Position.x + 25, Position.y + 65);
    }
    public PVector GetCenter()
    {
        return new PVector(Position.x + 35, Position.y + 25);
    } 
    public boolean GetOutput()
    {
        if(Inputs.size() != 2)
            return false;
        
        Node input1 = Inputs.get(0);
        Node input2 = Inputs.get(1);
        return ((input1.GetOutput() || input2.GetOutput()) && !(input1.GetOutput() && input2.GetOutput()));
    }
    public boolean AddInput(Node in)
    {
        if(Inputs.size() >= 2)
            return false;
            
        Inputs.add(in);
        return true;
    }
}
public class NotGate extends LogicGate
{
    // Constrcutor
    public NotGate(PVector position)
    {
        super(position);
        
        Color = NotColor;
        Output = new Node(this, GetCenter());
    }
    
    // Public Methods
    public void Update()
    {
    }
    public void Draw()
    {
        // Draw input points
        strokeWeight(2);
        if(Inputs.size() > 0 && Inputs.get(0) != null)
        {
            Node input1 = Inputs.get(0);
            stroke(input1.GetOutput() ? #00FF00 : #FF0000, 100);
            line(input1.Position.x, input1.Position.y, GetCenter().x - 45, GetCenter().y);
            line(GetCenter().x - 45, GetCenter().y, GetCenter().x, GetCenter().y);
        }
        
        // Draw the gate itself
        noStroke();
        fill(Color);
        triangle(Position.x, Position.y, Position.x + 59, Position.y + 25, Position.x, Position.y + 50);
        ellipse(Position.x + 66, Position.y + 25, 16, 16);
        
        // Draw the output node
        Output.Position = GetCenter();
        Output.Draw();
        
        // Draw info
        fill(255);
        textSize(12);
        textAlign(CENTER, CENTER);
        text("Inputs: " + Inputs.size(), Position.x + 25, Position.y + 65);
    }
    public PVector GetCenter()
    {
        return new PVector(Position.x + 35, Position.y + 25);
    } 
    public boolean GetOutput()
    {
        if(Inputs.size() != 1)
            return false;
        
        Node input1 = Inputs.get(0);
        return !input1.GetOutput();
    }
    public boolean AddInput(Node in)
    {
        if(Inputs.size() >= 1)
            return false;
            
        Inputs.add(in);
        return true;
    }
}
public class ToggleGate extends LogicGate
{
    public boolean Value = true;
    
    // Constrcutor
    public ToggleGate(PVector position)
    {
        super(position);
        
        Color = ToggleColor;
        Output = new Node(this, GetCenter());
    }
    
    // Public Methods
    public void Update()
    {
    }
    public void Draw()
    {        
        // Draw the gate itself
        strokeWeight(2);
        stroke(Color);
        fill(Value ? #00FF00 : #FF0000);
        rect(Position.x, Position.y, 50, 50);
        
        // Draw the output node
        Output.Position = GetCenter();
        Output.Draw();
    }
    public PVector GetCenter()
    {
        return new PVector(Position.x + 25, Position.y + 25);
    } 
    public boolean GetOutput()
    {
        return Value;
    }
    public boolean AddInput(Node in)
    {
        return false;
    }
}

public class Node
{
    // Variables
    public LogicGate _parent = null;
    PVector Position;
    
    // Constructors
    public Node(LogicGate parent, PVector pos)
    {
        Position = pos;
        _parent = parent;
    }
    
    // Methods
    public void Draw()
    {
        stroke(0);
        strokeWeight(2);
        fill(GetOutput() ? #00FF00 : #FF0000);
        ellipseMode(RADIUS);
        ellipse(Position.x, Position.y, OutputNodeSize, OutputNodeSize);
        ellipseMode(DIAMETER);
    }
    public boolean GetOutput()
    {
        return _parent.GetOutput();
    }
    public boolean Clicked(float x, float y)
    {
        return dist(x, y, Position.x, Position.y) < OutputNodeSize;
    }
}