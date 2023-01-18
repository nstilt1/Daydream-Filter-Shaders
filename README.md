# How to use shaders in the examples folder
Head over to `https://github.com/aracitdev/ShaderDesktop/releases/tag/1.0`

Download it, and copy the shaders in `/exampleShaders` to the Shaders folder of ShaderDesktop.

# Making any glsl shader change colors
Copy this:
```
float hueRate = 0.1;
vec3 rgb2hsv(vec3 c)
{
    vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
    vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}
vec3 hsv2rgb(vec3 c)
{
    vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}
vec3 incrementHue(vec3 c)
{
    // sometimes you might want to use
    // c.x += time * hueRate
    c.x += iTime * hueRate;
    return hsv2rgb(c);
}
```
And then use `incrementHue()` on the last vec3 in `main()` or `mainImage()`.
Example:
```
gl_FragColor.rgb = incrementHue(gl_FragColor.rgb);
```

# Getting ShaderToys to work for ShaderDesktop
(an excerpt from ShaderDesktop)
```
To convert a shader from shader toy to this:

Change void mainImage(out vec4 fragColor, in vec2 fragCoord) to just void main()
Replace fragColor with gl_FragColor and fragCoord with gl_FragCoord
Add the following to the beginning of the file:
* uniform vec2 iResolution;
* uniform float iTime;
* uniform vec2 iMouse; Shader toy shaders that you convert cannot have anything in the iChannels.
```
** replace `iGlobalTime` with `iTime`


# Credits

The source of the shaders came from the link below, with my modification.

`https://github.com/thennequin/LivingWallpaper/tree/master/Output/Presets`

My modification uses code found here:

`https://gist.github.com/983/e170a24ae8eba2cd174f`
