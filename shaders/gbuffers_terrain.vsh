#version 120

varying vec2[2] coord;
varying vec4 color;

attribute float mc_Entity;
attribute vec2 mc_midTexCoord;

uniform float frameTimeCounter;

uniform vec3 cameraPosition;

// Buat konversi posisi
uniform mat4 gbufferModelView;
uniform mat4 gbufferModelViewInverse;
/////////////////////

void main() {
  // gl_Position = gl_ProjectionMatrix * gl_ModelViewMatrix * gl_Vertex;

  coord[0] = (gl_TextureMatrix[0] * gl_MultiTexCoord0).st;
  coord[1] = (gl_TextureMatrix[1] * gl_MultiTexCoord1).st;
  color = gl_Color;

  // Posisi baru
  vec4 position = gl_ModelViewMatrix * gl_Vertex;

  // World position fixed
  position = gbufferModelViewInverse*position + vec4(cameraPosition, 0.0);

  // Setting
  float kuat_goyang = coord[1].t * coord[1].t;
  bool nempel_lemah = gl_MultiTexCoord0.t < mc_midTexCoord.t;

  // Goyang dulu euy
  vec2 extra_jos = vec2(cos(sin(position.x + position.y)*sin(position.y * 3.0) + frameTimeCounter*3.0) / 5.0, cos(sin(position.x - position.y*2.0)*sin(position.x * 2.0) + frameTimeCounter) / 6.0) * kuat_goyang;
    extra_jos *= mc_Entity == 1 // Rumput
    ? 1.0
    : mc_Entity == 2 // Rumput tinggi (Bagian bawah)
    || mc_Entity == 3 // Rumput tinggi (Bagian atas)
    ? 0.2
    : 0.0;

  if (nempel_lemah) position.xy += extra_jos;
  position.xy += mc_Entity == 3 ? extra_jos : vec2(0.0);

  // View position
  position = gbufferModelView * (position - vec4(cameraPosition, 0.0));
  gl_Position = gl_ProjectionMatrix * position;
}
