
// Boid-based swarm visualization
vec3 Boid(vec2 uv, vec2 position, vec2 velocity) {
    vec2 toBoid = uv - position;
    float dist = length(toBoid);
    if (dist > 0.05) return vec3(0);

    float angle = atan(velocity.y, velocity.x);
    float specular = pow(max(dot(normalize(toBoid), normalize(velocity)), 0.0), 32.0);

    return vec3(0.8, 0.9, 1.0) * specular * (1.0 - dist/0.05);
}
