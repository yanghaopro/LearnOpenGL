//
//  OpenGLTools.hpp
//  LearnOpenGL
//
//  Created by yanghao on 2017/2/20.
//  Copyright © 2017年 yanghao. All rights reserved.
//

#ifndef OpenGLTools_hpp
#define OpenGLTools_hpp

#include <stdio.h>
#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
char * LoadFileContentWithPath(const char* filePath);
GLuint CompileShader(GLenum shaderType, const char*shaderPath);
GLuint CreateGPUProgram(const char* vsShaderPath, const char* fsShaderPath);
#endif /* OpenGLTools_hpp */
