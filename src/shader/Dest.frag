uniform sampler2D tDiffuse;
uniform bool invert;
uniform vec3 color;

varying vec2 vUv;

void main(void) {

  vec4 dest = texture2D(tDiffuse, vUv);

  if(invert) {
    dest.rgb = 1.0 - dest.rgb;
  }

  dest.rgb *= color;

  gl_FragColor = dest;

}
