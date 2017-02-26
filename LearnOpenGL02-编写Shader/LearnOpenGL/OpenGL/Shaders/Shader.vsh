attribute vec3 position;
attribute lowp vec4 color;

varying lowp vec4 V_Color;
void main()
{
    V_Color = color;
    gl_Position = vec4(position, 1.0);
}
