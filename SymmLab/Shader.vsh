//
//  Shader.vsh
//  GLKitExample
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;
attribute vec4 diffuseColor;

varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
uniform int useLighting;

void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    
//    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
    
//    if (useLighting == 0) {
//        nDotVP = 1.0;
//    }
//    
//    colorVarying = vec4((diffuseColor * nDotVP).xyz, diffuseColor.a);
    
    float nDotVP = max(0.0, dot(normal, normalize(lightPosition)));
    colorVarying = vec4((diffuseColor * nDotVP).xyz, diffuseColor.a);
    
    gl_Position = modelViewProjectionMatrix * position;
}
