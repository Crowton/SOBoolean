// ID for the next gate to be created
public static int NextGateId = 0;

// List of all currently created gates
public ArrayList<LogicGate> Gates = new ArrayList<LogicGate>();

// Gates
public static final color AndColor = #FF5555;
public static final color OrColor = #55FF55;
public static final color XorColor = #5555FF;
public static final color NotColor = #FFFF55;
public static final color ToggleColor = #FFFFFF;
public static float OutputNodeSize = 7.5;

// GUI
public static final int MenuWidth = 180;
GUI g = new GUI();

// Logic
public static LogicGate CurrentlyPlacing = null;
public static Node CurrentOutput = null;
public static final int BorderMargin = 5;