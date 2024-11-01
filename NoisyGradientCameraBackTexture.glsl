#ifdef GL_FRAGMENT_PRECISION_HIGH
precision highp float;
#else
precision mediump float;
#endif

uniform vec2 cameraAddent;
uniform mat2 cameraOrientation;
uniform samplerExternalOES cameraBack;


uniform vec2 resolution;
uniform float time;

float frac(float c) {
	return c - floor(c);
}

float rand(vec2 co) {
	return frac(sin(dot(co.yx+1.0,vec2(17.8509,75.7137)))*(43674.894+time/1.0));
}

void main(void) {
	vec2 uv = gl_FragCoord.xy / resolution.xy ;
	vec2 st = cameraAddent + uv * cameraOrientation;

	vec3 cam = texture2D(cameraBack, st).rgb;

	vec3 col = cam;
	col.r *= 10.0;
	col.g *= 3.0;


	gl_FragColor = vec4(col,1.0);

  float m = step(uv.y,rand(uv * cos(3.0)));

	gl_FragColor = vec4(vec3(m) / col, 0.3);
}
