// Adapted from the water shader in the main room by James McCrae
uniform vec3      iResolution;
uniform float     iGlobalTime;
uniform float     iChannelTime[4];
uniform vec4      iMouse;
uniform vec4      iDate;
uniform float     iSampleRate;
uniform vec3      iChannelResolution[4];
uniform sampler2D iChannel0;
uniform sampler2D iChannel1;
uniform sampler2D iChannel2;
uniform sampler2D iChannel3;

#define TAU 6.28318530718
#define MAX_ITER 10

void mainImage( out vec4 fragColor, in vec2 fragCoord ) 
{
	float time = iGlobalTime * .5+10.0;
    // uv should be the 0-1 uv of texture...
	vec2 uv = gl_TexCoord[0].st;
    

	vec2 p = mod(uv*TAU*30.0, TAU)-250.0;

	vec2 i = vec2(p);
	float c = 1.0;
	float inten = .005;

	for (int n = 0; n < MAX_ITER; n++) 
	{
		float t = time * (1.0 - (3.5 / float(n+1)));
		i = p + vec2(cos(t - i.x) + sin(t + i.y), sin(t - i.y) + cos(t + i.x));
		c += 1.0/length(vec2(p.x / (sin(i.x+t)/inten),p.y / (cos(i.y+t)/inten)));
	}
	c /= float(MAX_ITER);
	c = 1.17-pow(c, 1.4);
	vec3 colour = vec3(pow(abs(c), 8.0));
    colour = clamp(colour + vec3(0.0, 0.35, 0.5), 0.0, 1.0);
    


	fragColor = vec4(colour, 1.0);
}

void main( void ){


vec4 color = vec4(0.0,0.0,0.0,1.0);
mainImage( color, gl_TexCoord[0].st );
color.w = 1.0;
gl_FragColor = color;

}
