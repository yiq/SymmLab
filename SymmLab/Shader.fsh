//
//  Shader.fsh
//  GLKitExample
//
//  Created by Yi Qiao on 5/24/14.
//  Copyright (c) 2014 Yi Qiao. All rights reserved.
//

varying lowp vec4 colorVarying;

uniform bool semiTransparent;


void main()
{
    lowp vec4 adjustedColor = colorVarying;
    
//    if (semiTransparent) {
//        adjustedColor.a = 0.1;
//    }
    
    gl_FragColor = adjustedColor;
}
