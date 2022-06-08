#version 120

varying vec2[2] coord;
varying vec4 color;

uniform sampler2D texture; // atau bisa pake yg lain contohnya: gcolor, tex
uniform sampler2D lightmap; // texture untuk mengetahui cahaya redup, cerah, dan bayangan bawaan minecraft

#include "lib/aces/aces.glsl"

void main() {
  vec4 scene = texture2D(texture, coord[0]) * color;
    scene.rgb *= texture2D(lightmap, coord[1]).rgb;

  // Obor
  scene.rgb += scene.rgb * pow(coord[1].s - 0.01, 2.0) * vec3(1.0, 0.7, 0.2);

  // Contoh aja
  scene.rgb = pow(scene.rgb, vec3(2.2));
  scene.rgb = aces(scene.rgb);
  scene.rgb = pow(scene.rgb, vec3(0.45454545)); // 1 / 2.2 = 0.4545454545454545454545...

  gl_FragData[0] = scene;
}
