/*
 *  FxDraw.h
 *  Fx
 *
 *  Created by tehis on 17/01/2009.
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
#include <GLUT/glut.h>
#include <OpenGL/glext.h>
#include "Cell.h"
#include "fxutil.h"
#include "Patch.h"

@interface FxDraw : NSObject {
	NSMutableDictionary * patches;
	int indexi, indexj, indexk, worldSize, frameRateRatio;
	float left, bottom, front, width, height, depth, red, green, blue, alpha, size;
	float state, gAlpha, halfscreen;
	Cell* currentCell;
	Patch* cp;
}


-(float) state;
-(void) setState: (float) value;

-(int) indexi;
-(void) setIndexi: (int) value;

-(int) indexj;
-(void) setIndexj: (int) value;

-(NSMutableDictionary*) patches;

-(void) setGlobalAlpha: (float) value;

-(void) setPatch: (NSString*) key: (int) on; 

-(void) dealloc;


- (FxDraw*) init;
- (void) drawCell: (Cell*) cell: (int) i: (int) j: (int) k: (int) ws: (int) fr;
- (void) horizons;
- (void) axial;
- (void) grid;
- (void) mesh;

- (void) strokeRect;
- (void) strokeRect: (int) plane: (float) lineWidth;
- (void) drawRect;
- (void) fillRect;
- (void) fillRect: (int) plane;
- (void) drawAxialRect: (float) colN: (float) colE: (float) colS: (float) colW;
- (void) drawLine: (float) startx: (float) starty: (float) startz: 
	(float) endx: (float) endy: (float) endz: (float) lineWidth;
- (void) drawCircle: (float) cx: (float) cy: (float) r: (int) num_segments: (bool) fill;
- (void) drawCube;
- (void) strokeCube;
- (void) stroke3Dvertex;
- (void) drawVertex3f: (float) startx: (float) starty: (float) startz: (float) endx: (float) endy: (float) endz: (float) lineWidth ;
- (void) drawPoint: (float) x: (float) y: (float) z: (float) sz;
- (void) drawCubicCurve: (float[]) a: (float[]) b: (float[]) c: (float[]) d: (int) segs: (float) lineWidth; 

@end
