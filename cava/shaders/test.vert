#version 330

layout(location = 0) in vec3 vertexPosition_modelspace;

// Pass the coordinates to the fragment shader
out vec2 fragCoord;

void main()
{
    gl_Position = vec4(vertexPosition_modelspace, 1.0);
    // Convert -1.0 to 1.0 space into 0.0 to 1.0 space
    fragCoord = (vertexPosition_modelspace.xy + vec2(1.0, 1.0)) / 2.0;
}
