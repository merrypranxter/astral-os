
// Violet pit glow for eels
float VioletGlow(vec2 uv, vec2 pitCenter) {
    float dist = distance(uv, pitCenter);
    float glow = exp(-dist * 20.0) * 0.8;
    return glow;
}

vec3 leyLineEel = vec3(0.9, 0.9, 1.0) * 0.3; // Translucent body
leyLineEel += vec3(0.58, 0.0, 0.83) * VioletGlow(uv, pitPos); // Violet pits
