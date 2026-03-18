// ANU_CORE_FRAGMENT.glsl
// Renders the Ultimate Physical Atom as heart-shaped vortex
// ASTRAL-OS Shader Library v0.1

uniform float u_time;
uniform vec3 u_anu_position;
uniform float u_polarity; // 1.0 = Positive, -1.0 = Negative
uniform float[10] u_spirillae_spin; // Array of 10 spin rates

// Heart-shaped SDF (Signed Distance Field)
float sdHeart(vec3 p, float scale) {
    p /= scale;
    float a = p.x * p.x + 2.25 * p.y * p.y + p.z * p.z - 1.0;
    return (a * a * a - p.x * p.x * 0.1125 * p.y * p.y * p.y) * scale;
}

// Recursive Spirillae Coil Function
vec3 spirillaeCoil(vec3 pos, int coil_id, float t) {
    float major = float(coil_id < 3); // 1.0 for major, 0.0 for minor
    float radius = mix(0.3, 0.1, major); // Major thicker
    float freq = mix(7.0, 14.0, major) * u_spirillae_spin[coil_id];
    
    // Torus knot approximation for heart vortex
    float u = t * freq * (u_polarity > 0.0 ? 1.0 : -1.0);
    vec3 coil = vec3(
        radius * cos(u) * (1.0 + 0.5 * cos(u * 3.0)),
        radius * sin(u) * (1.0 + 0.5 * cos(u * 3.0)),
        0.2 * sin(u * 7.0) // Vertical oscillation
    );
    return coil;
}

void main() {
    vec3 ro = cameraPosition;
    vec3 rd = normalize(vWorldPosition - cameraPosition);
    
    // Raymarch the heart vortex
    float t = 0.0;
    vec3 col = vec3(0.0);
    
    for(int i = 0; i < 64; i++) {
        vec3 p = ro + rd * t;
        float d = sdHeart(p - u_anu_position, 0.5);
        
        if(d < 0.01) {
            // Hit Anu surface - determine which spirilla
            float spiral_glow = 0.0;
            for(int s = 0; s < 10; s++) {
                vec3 coil_pos = spirillaeCoil(p, s, u_time);
                float dist = length(p - (u_anu_position + coil_pos));
                spiral_glow += exp(-dist * 10.0) * (s < 3 ? 2.0 : 0.5);
            }
            
            // Color by polarity
            vec3 major_color = vec3(1.0, 0.843, 0.0); // #FFD700 Gold
            vec3 minor_color = vec3(0.0, 1.0, 1.0); // #00FFFF Cyan
            vec3 base = mix(minor_color, major_color, spiral_glow);
            
            // Polarity tint
            col = base * (u_polarity > 0.0 ? vec3(1.2, 1.0, 0.8) : vec3(0.8, 0.9, 1.2));
            break;
        }
        t += d;
    }
    
    gl_FragColor = vec4(col * 2.0, 1.0); // Emissive boost
}
