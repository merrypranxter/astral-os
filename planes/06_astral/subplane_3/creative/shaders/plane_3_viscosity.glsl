
// Viscosity simulation for Plane 3 (0.45)
float viscosity = 0.45;
float drag = 1.0 - (viscosity * 0.1);
vec3 velocity = initialVelocity * drag;

// Liquid shadow pooling
float shadowViscosity = 0.8;
vec2 shadowFlow = gradient * shadowViscosity * deltaTime;
