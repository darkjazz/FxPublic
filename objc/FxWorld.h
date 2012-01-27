/*
 *  FxWorld.h
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
#import "Habitat.h"
#import "Seeds.h"
#import "Cell.h"
#include "fxutil.h"

@interface FxWorld : NSObject {
	NSMutableArray * cells;
	Habitat * habitat;
	int size;
	NSMutableArray * seed;
	NSArray * weights;
	NSMutableArray * pollIndices;
	int pollIndex;
}

//@property (retain) NSMutableArray * cells;
//@property int size;
//@property (retain) NSArray * weights;

-(NSMutableArray*) cells;
-(int) size;
-(NSArray*) weights;
-(NSArray*) pollIndices;
-(int) pollIndex;

-(void) setCells: (NSMutableArray*) value;
-(void) setSize: (int) value;
-(void) setWeights: (NSArray*) value;


-(FxWorld*) init: (int) s: (Habitat*) h: (NSMutableArray*) sd;
-(FxWorld*) init: (int) s: (Habitat*) h: (NSMutableArray*) sd: (NSArray*) wghts;
-(void) setHabitat;
-(void) initCells;
-(void) setStates;
-(void) setPollIndices: (NSMutableArray*) value;
-(void) prepareNext;
-(void) nextPollIndex;

@end
