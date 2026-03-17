
// Crystallization pop noise
float PopNoise(vec2 uv, float time) {
    float noise = fract(sin(dot(uv, vec2(12.9898, 78.233))) * 43758.5453);
    float trigger = step(0.997, noise); // Rare events
    float decay = exp(-mod(time, 3.0) * 2.0);
    return trigger * decay;
}
