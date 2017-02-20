//
//  OpenGLView.m
//  LearnOpenGL
//
//  Created by yanghao on 2017/2/20.
//  Copyright © 2017年 yanghao. All rights reserved.
//

#import "OpenGLView.h"

@interface OpenGLView ()
{
    CAEAGLLayer* _eaglLayer;
    EAGLContext* _eaglContext;
    GLuint      _colorRenderBuffer;
    GLuint      _frameBuffer;
}

@end
@implementation OpenGLView


+ (Class)layerClass
{
    // 只有 [CAEAGLLayer class] 类型的 layer 才支持在其上描绘 OpenGL 内容。
    return [CAEAGLLayer class];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupLayer];
        [self setupContext];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [EAGLContext setCurrentContext:_eaglContext];
    [self destoryRenderAndFrameBuffer];
    [self setupRenderBuffer];
    [self render];
}

- (void)render {
    glClearColor(0, 1.0, 0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [_eaglContext presentRenderbuffer:GL_RENDERBUFFER];
}
- (void)setupLayer
{
    _eaglLayer = [[CAEAGLLayer alloc]init];
    _eaglLayer.opaque = YES;
    // 设置描绘属性，在这里设置不维持渲染内容以及颜色格式为 RGBA8
    _eaglLayer.drawableProperties = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:NO],kEAGLDrawablePropertyRetainedBacking,kEAGLColorFormatRGBA8,kEAGLDrawablePropertyColorFormat, nil];
    
}
- (void)setupContext
{
    EAGLRenderingAPI api = kEAGLRenderingAPIOpenGLES2;
    _eaglContext = [[EAGLContext alloc]initWithAPI:api];
    if (!_eaglContext)
    {
        NSLog(@"Failed to initialize OpenGLES 2.0 context");
        exit(1);
    }
    if (![EAGLContext setCurrentContext:_eaglContext])
    {
        NSLog(@"Failed to set current OpenGL context");
        exit(1);
    }
}



- (void)setupRenderBuffer
{
    glGenRenderbuffers(1, &_colorRenderBuffer);
    glBindBuffer(GL_RENDERBUFFER, _colorRenderBuffer);
    [_eaglContext renderbufferStorage:GL_RENDERBUFFER fromDrawable:_eaglLayer];
    // 设置为当前 framebuffer
    glGenFramebuffers(1, &_frameBuffer);
    glBindFramebuffer(GL_FRAMEBUFFER, _frameBuffer);
   
    /**
        帧缓存附件：
            GL_COLOR_ATTACHMENT(0-i) ： 第i个颜色缓存（0-GL_MAX_COLOR_ATTACHMENTS-1）0为默认的颜色缓存
     
            GL_DEPTH_ATTACHMENT   ： 深度缓存
            GL_STENCIL_ATTACHMENT ：模板缓存
     
     */
     //将 _colorRenderBuffer 装配到 GL_COLOR_ATTACHMENT0 这个装配点上
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, _colorRenderBuffer);
}

- (void)destoryRenderAndFrameBuffer
{
    glDeleteFramebuffers(1, &_frameBuffer);
    _frameBuffer = 0;
    glDeleteRenderbuffers(1, &_colorRenderBuffer);
    _colorRenderBuffer = 0;
}
@end
