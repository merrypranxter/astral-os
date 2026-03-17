
// 90-degree constrained growth
float GeometricVine(vec2 uv, vec2 start, int segments) {
    float thickness = 0.005;
    float d = 1.0;

    vec2 current = start;
    for(int i = 0; i < segments; i++) {
        // Random 90-degree turn
        float angle = floor(fract(sin(float(i) * 12.34) * 4.0) * 4.0) * 1.5708;
        vec2 next = current + vec2(cos(angle), sin(angle)) * 0.1;

        // Line segment distance
        float lineDist = length(uv - clamp(uv, min(current, next), max(current, next)));
        d = min(d, lineDist);

        current = next;
    }
    return 1.0 - smoothstep(0.0, thickness, d);
}
