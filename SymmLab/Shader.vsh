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
uniform bool useLighting;

const vec4 ambientColor = vec4(0.35, 0.35, 0.35, 1.0);
const vec3 lightPosition = vec3(0.0, 0.0, 1.0);

void main()
{
    
    if (useLighting) {
        vec3 eyeNormal = normalize(normalMatrix * normal);
        float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
        colorVarying = mix(ambientColor, diffuseColor, nDotVP);
    }
    else {
        colorVarying = diffuseColor;
    }
    
    gl_Position = modelViewProjectionMatrix * position;
}
