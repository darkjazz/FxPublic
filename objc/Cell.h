/*
 *  Cell.h
 *  Fx
 *
 *  Created by tehis on 31/12/2008.
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
#include "fxutil.h"

@interface Cell : NSObject {
	float state;
	float lastState;
	int direction;
	float phase;
	float velocity;
	int coordX;
	int coordY; 
	int coordZ;
	NSMutableArray *habitat;
}

-(float) state;
-(void) setState: (float) value;

-(float) lastState;
-(void) setLastState: (float) value;

-(float) direction;
-(void) setDirection: (float) value;

-(float) phase;
-(void) setPhase: (float) value;

-(float) velocity;
-(void) setVelocity: (float) value;

-(int) coordX;
-(int) coordY;
-(int) coordZ;

-(NSMutableArray*) habitat;
-(void) setHabitat: (NSMutableArray*) value;

-(Cell*) init: (float) iState;
-(Cell*) initme: (float) iState: (int) cx: (int) cy: (int) cz;
-(float) next: (float) add: (int) frameRateRatio;
-(float) next: (float) add: (NSArray*) weights: (int) frameRateRatio;
-(void) updatePhase;
-(void) dealloc;

@end
