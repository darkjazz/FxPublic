/*
 *  FxView.h
 *  Fx
 *
 *  Created by tehis on 02/01/2009.
 *  
 *	This file is part of Fx.
 *
 *	Fx is free software: you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation, either version 3 of the License, or
 *	(at your option) any later version.
 
 *	Fx is distributed in the hope that it will be useful,
 *	but WITHOUT ANY WARRANTY; without even the implied warranty of
 *	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *	GNU General Public License for more details.
 
 *	You should have received a copy of the GNU General Public License
 *	along with Fx.  If not, see <http://www.gnu.org/licenses/>. 
 *
 */

#import <Cocoa/Cocoa.h>
#import  <OpenGL/OpenGL.h>
#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <OpenGL/glext.h>
#include "FxWorld.h"
#include "FxDraw.h"
#import "FxOSC.h"

#define BITS_PER_PIXEL          32.0
#define DEPTH_SIZE              32.0
#define WORLD_SIZE				16
#define SC_ADDRESS				"127.0.0.1" // "192.168.0.102"
#define SC_PORT					"57120"

@interface FxView : NSWindow {

	bool first;
	NSTimer *time;
	FxWorld *world;
	FxDraw *draw;
	bool run;
	FxOSC * oscer;
	float avgState, stdDev;
	float bg, zoom, glAlpha, rAng, rX, rY, rZ;
	int done, frameRateRatio;
	bool renew, enableMessage;
	int phase;
	NSArray * pollCellCoords;
	NSMutableArray * pollCellValues;
	NSMutableArray * oscValues;	
}

+ (NSOpenGLPixelFormat*) basicPixelFormat;

- (int) done;

- (void) initWorld;
- (void) resetWorld;
- (void) drawCells;
- (void) drawFrame;

- (void) prepareOpenGL;

- (id) initWithFrame: (NSRect) frameRect;

- (void) dealloc;

@end
