#version 330 core

in vec2 TexCoords;
out vec4 FragColor;

uniform sampler2D tex;        // current audio data
uniform sampler2D prev_tex;   // previous frame (for peak)
uniform float time;
uniform vec2 resolution;

float decay = 0.02; // how fast peaks fall

void main()
{
    float x = TexCoords.x;

    // Current bar height
    float value = texture(tex, vec2(x, 0.0)).r;

    // Previous peak
    float prev_peak = texture(prev_tex, vec2(x, 0.0)).r;

    // Peak logic: either new value or decayed old peak
    float peak = max(value, prev_peak - decay);

    float y = TexCoords.y;

    // Draw bar
    float bar = step(y, value);

    // Draw peak line
    float peak_line = step(abs(y - peak), 0.01);

    vec3 color = vec3(0.0);

    // Bar color
    color += bar * vec3(0.2, 0.8, 1.0);

    // Peak color (white)
    color += peak_line * vec3(1.0);

    FragColor = vec4(color, 1.0);
}
