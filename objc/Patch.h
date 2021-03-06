/*
 *  Patch.h
 *  Fx
 *
 *  Created by tehis on 28/03/2009.
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


@interface Patch : NSObject {
	const char* name;
	bool active;
	int color; // 0 - grayscale, 1 - blue, 2 - green
	int colormap; // 0 - state, 1 - reverse
	int alphamap; // 0 - state, 1 - reverse
	float alphahi, alphalo;
	float colorhi, colorlo;
	float sizehi, sizelo;
	float size, red, green, blue, alpha, left, bottom, scale;
	NSMutableDictionary * events;
}

-(Patch*) init;
-(bool) active;
-(float) size;
-(float) red;
-(float) green;
-(float) blue;
-(float) alpha;
-(float) bottom;
-(float) left;
-(float) scale;
-(NSMutableDictionary*) events;

-(void) setActive: (bool) value;
-(void) setAlpha: (float) value;
-(void) setSize: (float) value;
-(void) setColor: (int) value;
-(void) setColormap: (int) value;
-(void) setAlphamap: (int) value;
-(void) setAlphahi: (float) value;
-(void) setAlphalo: (float) value;
-(void) setColorhi: (float) value;
-(void) setColorlo: (float) value;
-(void) setSizehi: (float) value;
-(void) setSizelo: (float) value;
-(void) setScale: (float) value;

-(void) mapValues: (int) i: (int) j: (float) state;

-(void) dealloc;

@end
