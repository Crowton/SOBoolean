boolean IsWithin(float posx, float posy, float x, float y, float w, float h)
{
    return posx > x && posx < x + w && posy > y && posy < y + h;
}