// DNA_DOUBLE_HELIX_VORTEX.glsl
// Renders the DNA as recursive fractal vortex with shadow strands
// ASTRAL-OS Shader Library v0.1

uniform float u_dna_time;
uniform float u_shadow_strand_activation[10]; // 0.0-1.0 per strand

// Double helix with phase-shifted shadows
vec3 dnaHelix(float t, float phase, float radius, int strand_id) {
    float active = u_shadow_strand_activation[strand_id];
    float x = radius * cos(t + phase) * (1.0 - active * 0.44); // High-spin compression
    float y = radius * sin(t + phase);
    float z = t * 0.5;
    
    // Shadow strands at E3/E2 are fiber-optic
    vec3 base_pos = vec3(x, y, z);
    if(strand_id > 1) {
        // Shadow strands - light encoded
        float fiber_pulse = sin(u_dna_time * 10.0 + t) * 0.5 + 0.5;
        base_pos *= 1.0 + fiber_pulse * active * 0.2;
    }
    return base_pos;
}

// Base pair logic gates (A,T,G,C as vibrational frequencies)
vec3 basePairColor(float rung_index, int strand) {
    // A=440Hz, T=528Hz, G=639Hz, C=852Hz (Solfeggio mapping)
    float freq = 0.0;
    int base_id = int(mod(rung_index, 4.0));
    if(base_id == 0) freq = 440.0; // Adenine
    else if(base_id == 1) freq = 528.0; // Thymine
    else if(base_id == 2) freq = 639.0; // Guanine
    else freq = 852.0; // Cytosine
    
    // Visual as color based on frequency
    vec3 color = hsv2rgb(vec3(freq/1000.0, 0.8, 0.9));
    
    // Strand 3+ phase shift (emotional/mental)
    if(strand > 1) {
        color = rotateHue(color, 3.14159 * float(strand) / 6.0);
    }
    return color;
}

void main() {
    vec3 col = vec3(0.0);
    float t = vUV.x * 20.0; // Along the helix length
    
    // Render all 12 strands
    for(int i = 0; i < 12; i++) {
        float phase = float(i) * 0.5236; // 30 degree increments
        float radius = 1.0 + float(i) * 0.2; // Shadow strands wider
        float active = u_shadow_strand_activation[i];
        vec3 pos = dnaHelix(t, phase, radius, i);
        float dist = length(vWorldPosition - pos);
        
        // Glow based on activation
        float glow = exp(-dist * 5.0) * (0.2 + active * 2.0);
        col += basePairColor(t, i) * glow;
    }
    
    // Permanent Atom at center
    float center_dist = length(vWorldPosition);
    col += vec3(1.0, 0.8, 0.2) * exp(-center_dist * 3.0);
    
    gl_FragColor = vec4(col, 1.0);
}
