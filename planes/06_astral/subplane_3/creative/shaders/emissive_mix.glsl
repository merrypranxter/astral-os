
// Plane 3: 40% emissive, 60% reflected
vec3 baseColor = texture(diffuse, uv).rgb;
vec3 emissive = texture(emissiveMap, uv).rgb * 0.4;
vec3 reflected = texture(environment, reflectionVec).rgb * 0.6;
vec3 finalColor = baseColor + emissive + reflected;
