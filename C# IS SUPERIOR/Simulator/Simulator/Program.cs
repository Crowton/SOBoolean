﻿using System;
using SFML.Window;
using SFML.Graphics;

namespace Simulator
{
    class Program
     {
         static void Main(string[] args)
         {
             MySFMLProgram app = new MySFMLProgram();
             app.StartSFMLProgram();
         }
     }
     class MySFMLProgram
     {
         RenderWindow _window;
         public void StartSFMLProgram()
         {
             _window = new RenderWindow(new VideoMode(800, 600), "SFML window");
             _window.SetVisible(true);
             _window.Closed += new EventHandler(OnClosed);
             while (_window.IsOpen())
             {
                 _window.DispatchEvents();
                 _window.Clear(Color.Red);
                 _window.Display();
             }
         }
         void OnClosed(object sender, EventArgs e)
         {
             _window.Close();
         }
     }
}
