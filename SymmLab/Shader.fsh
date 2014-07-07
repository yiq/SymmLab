//
//  Shader.fsh
//  GLKitExample
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

varying lowp vec4 colorVarying;

uniform lowp float alphaAdjust;


void main()
{
    lowp vec4 adjustedColor = colorVarying;
    
    adjustedColor.a = alphaAdjust;
    
    gl_FragColor = adjustedColor;
}
