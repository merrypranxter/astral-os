
// Plane 3→4 boundary shader
vec2 uv = fragCoord.xy / iResolution.xy;
float time = iTime * 0.2;

// Heat shimmer distortion
vec2 distortion = vec2(
    sin(uv.y * 20.0 + time) * 0.02,
    cos(uv.x * 20.0 + time) * 0.02
);

// Iridescence calculation
float angle = dot(normalize(uv - 0.5), vec2(0.5));
vec3 irid = 0.5 + 0.5 * cos(time + angle * 10.0 + vec3(0, 2, 4));

vec4 color = texture(iChannel0, uv + distortion) * vec4(irid, 1.0);
