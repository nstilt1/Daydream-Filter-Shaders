# How to use shaders in the examples folder
Head over to `https://github.com/aracitdev/ShaderDesktop/releases/tag/1.0`

Download it, and put the shaders in the Shaders folder of ShaderDesktop.

# Getting ShaderToys to work for ShaderDesktop
(an excerpt from ShaderDesktop)
```
To convert a shader from shader toy to this:

Change void mainImage(out vec4 fragColor, in vec2 fragCoord) to just void main()
Replace fragColor with gl_FragColor and fragCoord with gl_FragCoord
Add the following to the beginning of the file:
uniform vec2 iResolution;
uniform float iTime;
uniform vec2 iMouse; Shader toy shaders that you convert cannot have anything in the iChannels.
```

The source of the shaders came from the link below, with my modification.
`https://github.com/thennequin/LivingWallpaper/tree/master/Output/Presets`

My modification uses code found here:
`https://gist.github.com/983/e170a24ae8eba2cd174f`
